/*
 * LinkEditor.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("LinkEditor 4");

function CreateImageLink(selectedElement, currentRange, linkEditorReturnValue, selectionType)
{
	var imageIsSelected = (selectionType == 'CONTROL' && selectedElement.tagName.toUpperCase() == 'IMG');

	if (linkEditorReturnValue == '|')
	{	// The user selected "clear" in the image window
		if(imageIsSelected) // An existing image was selected - clear (remove) it
			selectedElement.outerHTML = '';
	}
	else if (linkEditorReturnValue != 0)
	{	// The user entered values and clicked OK
		var params	= linkEditorReturnValue.split('|');
		var url		= params[0];
		var altText	= params[1];
		// Make sure altText is set to either the given value or an empty string
		altText = (altText && altText.length > 0) ? altText.Trim() : '';
		
		if (imageIsSelected)
		{	
			// Current selection is an image - update a clone of it, and replace the original with the modified clone.
			// This way of doing it supports undo/redo (just setting properties in original images does not).
			var tempImage = document.createElement(selectedElement.outerHTML);
			
			tempImage.setAttribute('orgurl', url);
			tempImage.src = url;
			tempImage.alt = altText;
			selectedElement.outerHTML = tempImage.outerHTML;
		}
		else
		{	
			// Inserting a new image - replace whatever text was selected with the image
			// Create temp image and insert the images outer html into the document.
			// This technique guarantees that all attribute values are encoded correctly, if needed.
			var tempImage = document.createElement('img');			
			tempImage.setAttribute('orgurl', url);
			tempImage.alt = altText;
			tempImage.src = url;
			tempImage.border = 0;

			if (selectionType == 'CONTROL')
				selectedElement.pasteHTML(tempImage.outerHTML);			
			else
			{
				// If we get here it probably means that some text inside a link has been selected. 
				// Simple solution - just ignore the text selection and insert the image in front of 
				// the link's inner html.
				currentRange.pasteHTML(tempImage.outerHTML);
			}
		}
	}
}

function CreateURL(selectedElement, currentRange, linkEditorReturnValue, selectionType)
{
	var linkIsSelected = (selectedElement && selectedElement.tagName.toUpperCase() == 'A');

	if (linkEditorReturnValue == '|')
	{	// The user selected "clear" in the link window
		if (linkIsSelected) // An existing link was selected - clear it (remove the link, but leave the text/contents)
			selectedElement.outerHTML = selectedElement.innerHTML;
	}
	else if (linkEditorReturnValue != 0)
	{	// The user entered values and clicked OK
		var params	= linkEditorReturnValue.split('|');
		var url		= params[0];
		var target	= params[1];
		var selText	= params[2];
		var title	= params[3];

		title =	(title != null && title.length > 0) ? title.Trim() : null;

		if (linkIsSelected)
		{	
			// Current selection is a link - update a clone of it, and replace the original with the modified clone.
			// This way of doing it supports undo/redo (just setting properties in original images does not).
			var tempLink = CreateLink(url, title, target, selectedElement.outerHTML);

			// Regarding handlling of the text/contents of the link
			// Problem:		We are not allowed to modify tempLinks innerHtml/insertAdjacentHTML/etc without breaking the undo-stack.
			//				(This might be because tempLink is not part of the DOM yet - similar code WORKS for tableEditor, cell properties)
			// Solution:	Convert the tempLink to a string, and find the insert point before the closing tag </ to paste in the content.
			// Drawbacks:	May handle links with attributes or similar containing the "</" sequence. 
			//				String manipulation is not the desired way to manipulate elements and their content.

			var elementAsString 	= new String(tempLink.outerHTML);
			var newContent		= "";

			if(selText && selText.length > 0)
			{	// User entered a link text - use it even if we had an image selected (will replace the image)
				//elementAsString = elementAsString.replace("><", ">"+selText+"<"); // Previous version, based on "><" sequence
				newContent = selText;
			}
			else if(selectionType != 'CONTROL')
			{	// No link text was entered, and we are not updating a link containing an image: display the link url as text
				//elementAsString = elementAsString.replace("><", ">"+url+"<"); // Previous version, based on "><" sequence
				newContent = url;
			}
			else
			{	// Use whatever contents the link had before (copy them to the clone), primarily for links created around images
				//elementAsString = elementAsString.replace("><", ">"+selectedElement.innerHTML+"<"); // Previous version, based on "><" sequence
				newContent = selectedElement.innerHTML;
			}
			
			selectedElement.outerHTML = InsertTagContents(elementAsString, newContent);			
		}
		else if (selectionType == 'CONTROL' && selectedElement.tagName.toUpperCase() == 'IMG')
		{	
			// Current selection is an image, create a link around it
			var tempLink = CreateLink(url, title, target);

			if(!selText || selText.length == 0)	// No text entered for the link, use the image
				tempLink.innerHTML = selectedElement.outerHTML;
			else								// User specifically entered a text to use - replace the image with the text
				tempLink.innerHTML = selText;

			var range = selectedElement.ownerDocument.body.createTextRange();	
			range.moveToElementText(selectedElement);
			range.pasteHTML(tempLink.outerHTML);
			range.select();
		}
		else
		{	
			// Current selection is text (or no selection)
			// Special handling of trailing spaces, because of the default word-processing behaviour
			// when double-clicking a word (the selection will include the trailing space).
			if(!selText || selText.length == 0)
				selText = url;

			var tempLink = CreateLink(url, title, target);
			tempLink.innerText = selText.Trim();

			lastChar = currentRange.text.charAt(currentRange.text.length-1);
			if(lastChar == ' ')
			{
				currentRange.moveEnd("character", -1);
				currentRange.select();
			}
			
			currentRange.pasteHTML(tempLink.outerHTML);
		}
	}
}

function CreateLink(url, title, target, tagHTML)
{
	if (!tagHTML)
		tagHTML = '<a>';

	var link = document.createElement(tagHTML); 
	link.href = url;
	link.setAttribute('orgurl', url);			

	if (title)
		link.title = title;				
	else
		link.removeAttribute('title', 0);

	if (target && target.length > 0)
		link.target = target;
	else
		link.removeAttribute('target', 0);

	return link;
}

function InsertTagContents(originalTagString, newContents)
{
	var substringIndex = originalTagString.lastIndexOf("</");
	if(substringIndex == -1)	// No closing tag found, string might be corrupt
		return originalTagString;
	var modifiedTagString = originalTagString.substring(0, substringIndex) + newContents + originalTagString.substring(substringIndex, originalTagString.length);
	return modifiedTagString;
}

function ParentAElement(currentRange)
{
	var elem = currentRange.parentElement();
		
	while (elem != null && elem.tagName.toUpperCase() != 'A')
	{
		elem = elem.parentElement;
	}
	return elem;
}

function LaunchLinkEditor(dialogURL, id, dialogArguments)
{
	var DIALOG_ARGUMENT_INSERT_IMAGE = 0;
	var DIALOG_ARGUMENT_INSERT_LINK = 2;
	var returnValue;
	var selText		= '';
	var url			= '';
	var target		= '';
	var anchors		= '';
	var alt			= '';
	var title		= '';
	var doc = eval(id + '_IFrameObj').tableEdit.editorDocument;	
		
	var currentRange = doc.selection.createRange();
	var selType = doc.selection.type.toUpperCase();
	var selectedElement;

	if (selType == 'CONTROL' && currentRange.item(0).tagName.toUpperCase() == 'IMG')
	{	// Selection is currently an image, check whether we want to alter the image or create/alter a link containing the image
		selectedElement = currentRange.item(0);
		
		if (dialogArguments == DIALOG_ARGUMENT_INSERT_IMAGE)
		{	// Altering the image object
			alt		= selectedElement.alt;
			url		= selectedElement.getAttribute('orgurl');
			if(url == null)
				url = selectedElement.src;
		}
		else
		{	// Altering/creating a surrounding link
			if(selectedElement.parentElement && selectedElement.parentElement.tagName.toUpperCase() == 'A')
			{	// The image is already included in a link - alter it
				selectedElement = selectedElement.parentElement;
				target	= selectedElement.target;
				url		= selectedElement.getAttribute('orgurl');
				title	= selectedElement.getAttribute('title');
				if(url == null)
					url = selectedElement.href;
			}
			// else - the image is currently not part of a link - we just create a new one (no need to set parameters)
		}
	}
	else 
	{
		selectedElement = ParentAElement(currentRange);
		
		if ( (selType == 'TEXT' || selType == 'NONE') && selectedElement != null)
		{
			// Selection or cursor is currently on a link, pass the current link info as arguments to the LinkEditor
			selText = selectedElement.innerHTML;
			target	= selectedElement.target;
			url		= selectedElement.getAttribute('orgurl');
			title	= selectedElement.getAttribute('title');
			if(url == null)
				url = selectedElement.href;
		}
		else
		{	// Ordinary text is selected, pass it in as an argument to the LinkEditor
			selText = currentRange.text;
			selectedElement = null;
		}
	}

	if (dialogArguments == DIALOG_ARGUMENT_INSERT_LINK)
	{	// When inserting a link, build a string with all anchors from all editors on the page, to pass in as argument
		var allAnchors = new Array();
		for(e = 0; e < window.editorList.length; e++)
		{
			editorInstanceAnchors = window.editorList[e].editor.document.anchors;
			for(i = 0; i < editorInstanceAnchors.length; i++)
				allAnchors.push(editorInstanceAnchors[i].name);
		}
		anchors = allAnchors.sort().join('|');
	}

	if (anchors && anchors.length > 0)
		dialogURL += '&anchors=' + encodeURIComponent(anchors);

	if (url && url.length > 0)
		dialogURL += '&url=' + encodeURIComponent(url);

	if (target && target.length > 0)
		dialogURL += '&target=' + target;

	if (selText && selText.length > 0)
		dialogURL += '&text=' + encodeURIComponent(selText);

	if (alt && alt.length > 0)
		dialogURL += '&alt=' + encodeURIComponent(alt);

	if (title && title.length > 0)
		dialogURL += '&title=' + encodeURIComponent(title);

	returnValue = OpenLinkToolDialog(dialogURL, dialogArguments);
					
	if (dialogArguments == DIALOG_ARGUMENT_INSERT_IMAGE)
		CreateImageLink(selectedElement, currentRange, returnValue, selType);
	else
		CreateURL(selectedElement, currentRange, returnValue, selType);
}