/*
 * HyperlinkProperties.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("HyperlinkProperties 1");

function hyperlinkHasFocus(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var selection	= iframeObj.editorAPI.editorDocument.selection;

	try
	{
		var element;
		//Image with surronding a tag
		if(selection.type.toUpperCase() == 'CONTROL')
			element = selection.createRange().item(0);
		else
			element = selection.createRange().parentElement();
		while (element != null && element.tagName.toUpperCase() != 'A')
			element = element.parentElement;
		return (element != null && element.tagName.toUpperCase() == 'A');
	}
	catch(e)
	{
		return false;
	}
}

function UpdateHyperlink(selectedLinkElement, currentRange, linkEditorReturnValue, selectionType, selectedImageElement)
{
	if (linkEditorReturnValue == -1)
	{	
		// The user selected "clear" in the link window
		if (selectedLinkElement != null)
		{
			selectedLinkElement.outerHTML = selectedLinkElement.innerHTML;
		}
		return;
	}
	
	// The user entered values and clicked OK
	var linkIsSelected	= (selectedLinkElement && selectedLinkElement.tagName.toUpperCase() == 'A');
	var linkObjectHTML	= (linkIsSelected == null) ? 'A' : selectedLinkElement.outerHTML;
	var tempLink		= document.createElement(linkObjectHTML);
	var imageObjectHTML	= (selectedImageElement == null) ? 'IMG' : selectedImageElement.outerHTML;
	var tempImage;

	// Regarding handlling of the text/contents of the link
	// Problem:		We are not allowed to modify tempLinks innerHtml/insertAdjacentHTML/etc without breaking the undo-stack.
	//				(This might be because tempLink is not part of the DOM yet - similar code WORKS for tableEditor, cell properties)
	// Solution:	Convert the tempLink to a string, and find the insert point before the closing tag </ to paste in the content.
	// Drawbacks:	May handle links with attributes or similar containing the "</" sequence. 
	//				String manipulation is not the desired way to manipulate elements and their content.
	var elementAsString;
	var newContent		= '';

	if (linkIsSelected)
	{	// Current selection is a link - update a clone of it, and replace the original with the modified clone.
		// This way of doing it supports undo/redo (just setting properties in original images does not).
		UpdateLink(tempLink, linkEditorReturnValue);
		elementAsString = new String(tempLink.outerHTML);

		if(linkEditorReturnValue.imageObject != null)
		{
			tempImage = document.createElement(imageObjectHTML);
			UpdateLinkImageElement(tempImage, linkEditorReturnValue.imageObject);
			newContent = tempImage.outerHTML;
		}
		else
		{
			newContent = linkEditorReturnValue.text;
		}

		try
		{
			selectedLinkElement.outerHTML = InsertTagContents(elementAsString, newContent);
		}
		catch(e)
		{
			return;
		}
	}
	else
	{
		UpdateLink(tempLink, linkEditorReturnValue);
		elementAsString = new String(tempLink.outerHTML);
		
		if(linkEditorReturnValue.imageObject != null)
		{
			tempImage = document.createElement(imageObjectHTML);
			UpdateLinkImageElement(tempImage, linkEditorReturnValue.imageObject);
			newContent = tempImage.outerHTML;
		}
		else
		{
			newContent = linkEditorReturnValue.text;
		}
		
		if(selectedImageElement != null)
		{	// Current selection is an image element
			var range = selectedImageElement.ownerDocument.body.createTextRange();
			range.moveToElementText(selectedImageElement);
			range.pasteHTML(InsertTagContents(elementAsString, newContent));
			range.select();
		}
		else
		{	
			if (selectionType == 'NONE')
			{
				currentRange.parentElement().innerHTML = InsertTagContents(elementAsString, newContent);
			}
			else
			{
				// Current selection is text (or no selection)
				// Special handling of trailing spaces, because of the default word-processing behaviour
				// when double-clicking a word (the selection will include the trailing space).
				lastChar = currentRange.htmlText.charAt(currentRange.htmlText.length-1);
				if(lastChar == ' '  || lastChar == '')
				{
					currentRange.moveEnd("character", -1);
					currentRange.select();
				}
				currentRange.pasteHTML(InsertTagContents(elementAsString, newContent));
			}
		}
	}
}

function UpdateLink(linkElement, linkAttributes)
{
	if (linkAttributes.href != null && linkAttributes.href.length > 0)
	{
		if (linkAttributes.language != null && linkAttributes.language.length > 0)
		{
			linkAttributes.href += (linkAttributes.href.indexOf('?') > -1) ? '&' : '?';
			linkAttributes.href += 'epslanguage=' + linkAttributes.language;
		}
	}
	linkElement.href = linkAttributes.href;
	
	linkElement.setAttribute('orgurl', linkAttributes.href);

	if (linkAttributes.title && linkAttributes.title.Trim().length > 0)
		linkElement.title = linkAttributes.title.Trim();
	else
		linkElement.removeAttribute('title', 0);

	if (linkAttributes.target && linkAttributes.target.length > 0)
		linkElement.target = linkAttributes.target;
	else
		linkElement.removeAttribute('target', 0);
}

function UpdateLinkImageElement(tempImage, newAttributes)
{
	// NOTE: The updating of the image's src needs to take place before height/width updates,
	// because IE automatically sets height/width attributes when the src attribute is changed.
	if(newAttributes.src && newAttributes.src != null)
	{
		tempImage.setAttribute('orgurl', newAttributes.src);
		tempImage.src = newAttributes.src;
	}

	if(newAttributes.align && newAttributes.align != null)
		tempImage.align	= newAttributes.align;
	else
		tempImage.removeAttribute('align', 0);
	
	if(newAttributes.width && newAttributes.width != null)
	{
		tempImage.style.width = newAttributes.width;
		// Possibly: remove the width attribute, if present
	}
	else
	{
		tempImage.removeAttribute('width', 0);
		tempImage.style.removeAttribute('width', 0);
	}

	if(newAttributes.height && newAttributes.height != null)
	{
		tempImage.style.height = newAttributes.height;
		// Possibly: remove the height attribute, if present
	}
	else
	{
		tempImage.removeAttribute('height', 0);
		tempImage.style.removeAttribute('height', 0);
	}	

	if(newAttributes.border && newAttributes.border != null)
		tempImage.border = newAttributes.border;
	else
		tempImage.removeAttribute('border', 0);

	if(newAttributes.hspace && newAttributes.hspace != null)
		tempImage.hspace = newAttributes.hspace;
	else
		tempImage.removeAttribute('hspace', 0);

	if(newAttributes.vspace && newAttributes.vspace != null)
		tempImage.vspace = newAttributes.vspace;
	else
		tempImage.removeAttribute('vspace', 0);

	if(newAttributes.className && newAttributes.className != null)
		tempImage.className	= newAttributes.className;
	else
		tempImage.removeAttribute('className', 0);

	// Make sure altText is set to either the given value or an empty string
	var altText		= newAttributes.alt;
	altText			= (altText && altText.length > 0) ? altText.Trim() : '';
	tempImage.alt	= altText;
}

function InsertTagContents(originalTagString, newContents)
{
	var substringIndex = originalTagString.lastIndexOf("</");
	if(substringIndex == -1)	// No closing tag found, string might be corrupt
		return originalTagString;
	var modifiedTagString = originalTagString.substring(0, substringIndex) + newContents + originalTagString.substring(substringIndex, originalTagString.length);
	return modifiedTagString;
}

function ParentAElement(initialElement)
{
	var elem = initialElement;
		
	while (elem != null && elem.tagName.toUpperCase() != 'A')
	{
		elem = elem.parentElement;
	}
	return elem;
}

function CollectImageAttributes(image, imageAttributes)
{
	// Image attribute code almost copy of code from HyperlinkImageProperties.js

	imageAttributes.align		= image.getAttribute('align');
	imageAttributes.border		= image.getAttribute('border');
	imageAttributes.hspace		= image.getAttribute('hspace');
	imageAttributes.vspace		= image.getAttribute('vspace');
	imageAttributes.className	= image.getAttribute('className');
	imageAttributes.width		= image.getAttribute('width');
	imageAttributes.height		= image.getAttribute('height');
	imageAttributes.alt			= image.getAttribute('alt');
	imageAttributes.src			= image.getAttribute('orgurl');
	imageAttributes.fileSize	= image.fileSize;

	// If the image did not have an orgurl attribute set, use the src
	if(imageAttributes.src == null)
		imageAttributes.src = image.getAttribute('src');

	// Make sure the correct width values are passed in, based on a combination of "width" and "style" attribute values.
	if(image.style.width == null || image.style.width.length == 0) //TEST: use image.style.getAttributeNode(width)...
	{	
		// No width was set using style...
		var widthAttr = image.getAttributeNode('width');
		if(!widthAttr.specified)
		{	
			// The "width" attribute was not set for the image - the value in arguments array is "visual" value
			imageAttributes.realwidth	= imageAttributes.width;	// Pass in the base value as separate argument
			imageAttributes.width		= null;						// No value set for width, pass in null
		}
		else
		{	
			// Arguments array should already contain the correct value. Assign to be clear.
			imageAttributes.width = widthAttr.nodeValue;
		}
	}
	else
	{	
		// The value for width is defined in the "style" attribute. 
		// Note: The contents in arguments array may be incorrect if the style is set to percentage value. Assign correct value.
		imageAttributes.width = image.style.width;
	}
		
	// Make sure the correct height values are passed in, based on a combination of "height" and "style" attribute values.
	if (image.style.height == null || image.style.height.length == 0) //TEST: use image.style.getAttributeNode(height)...
	{	
		// No height was set using style...
		var heightAttr	= image.getAttributeNode('height');
		if(!heightAttr.specified)
		{	
			// The "height" attribute was not set for the image - the value in arguments array is "visual" value
			imageAttributes.realheight	= imageAttributes.height;	// Pass in the base value as separate argument
			imageAttributes.height		= null;						// No value set for the attribute, pass in null
		}
		else
		{	
			// Arguments array should already contain the correct value. Assign to be clear.
			imageAttributes.height = heightAttr.nodeValue;
		}
	}
	else
	{	
		// The value for height is defined in the "style" attribute.
		// Note: The contents in arguments array may be incorrect if the style is set to percentage value. Assign correct value.
		imageAttributes.height = image.style.height;
	}
}

function SelectedImageElement(currentRange)
{
	var i;
	
	for (i = 0; i < currentRange.length; i ++)
	{
		var selectedItem = currentRange.item(i);
		if (selectedItem.tagName.toUpperCase() == 'IMG')
			return selectedItem;
	}
	
	return null;
}

function LaunchHyperlinkProperties(dialogUrl, id, fileManagerBrowserUrl, imageDialogUrl, resizeDialogUrl)
{
	var returnValue;
	
	var selText					= '';
	var doc						= eval(id + '_IFrameObj').tableEdit.editorDocument;	
	var currentRange			= doc.selection.createRange();
	var selType					= doc.selection.type.toUpperCase();
	var selectedLinkElement		= null;
	var selectedImageElement	= null;
	var linkAttributes			= new Object();
	var imageAttributes			= new Object();
	
	// Set base image attributes
	imageAttributes.fileManagerBrowserUrl	= fileManagerBrowserUrl;
	imageAttributes.resizeDialogUrl			= resizeDialogUrl;
	imageAttributes.editorID				= id;
	imageAttributes.parentWindow			= window;
	
	// Do we have a control selection that contains an image ?
	if (selType == 'CONTROL')
	{	
		selectedImageElement = SelectedImageElement(currentRange);
		
		// If no image found, prevent creation of link
		// This should never happen (and we do not know how to handle this case...)
		if (selectedImageElement == null)
			return;
			
		// Get surroundling link, if any
		selectedLinkElement = ParentAElement(selectedImageElement);
			
		if (selectedLinkElement != null && selectedLinkElement.innerHTML != selectedImageElement.outerHTML)
		{	
			// The selected image is part of a "complex" link (containing text and/or images)
			// Treat the selection as if the image did not have focus
			selText = selectedLinkElement.innerHTML;
		}
		else
		{
			// Either no surrounding link or the selectedLinkElement *only* contains the img element
			CollectImageAttributes(selectedImageElement, imageAttributes);
		}
	}
	else 
	{
		// Get existing, surrounding link, if any
		selectedLinkElement = ParentAElement(currentRange.parentElement());
		
		if (selectedLinkElement != null)
		{
			// Selection or cursor is currently on a link, pass the current link info as arguments to the LinkEditor
			selText = selectedLinkElement.innerHTML;
		}
		else if (selType == 'TEXT')
		{	// Ordinary text is selected, pass it in as an argument to the LinkEditor
			selText = currentRange.htmlText;
		}
		else
		{	
			// No selection, get text from current word
			var newRange = currentRange.duplicate();
			newRange.expand("word");
			if (!currentRange.isEqual(newRange) && newRange.text == newRange.htmlText && newRange.text.length > 0)
			{
				// There was a word for us to use...
				selType = 'TEXT';
				currentRange = newRange;
				selText = currentRange.htmlText;
			}
			else
			{
				// Special case - if at end of line, then the expand("word") will not do an expansion
				newRange = currentRange.duplicate();
				newRange.moveStart("character", -1); // back one character
				newRange.collapse();
				
				selectedLinkElement = ParentAElement(newRange.parentElement());
				if (selectedLinkElement != null)
				{
					// Selection or cursor is currently on a link, pass the current link info as arguments to the LinkEditor
					selText = selectedLinkElement.innerHTML;
				}
				else
				{
					newRange.expand("word");
					if (!currentRange.isEqual(newRange) && newRange.text == newRange.htmlText && newRange.text.length > 0)
					{
						// There was a word for us to use...
						selType = 'TEXT';
						currentRange = newRange;
						selText = currentRange.htmlText;
					}
					else
					{
						// No word, just use parent element
						selText = currentRange.parentElement().innerHTML;
						if (selText.indexOf('<A') >= 0)
							selText = '';
					}
				}
			}
		}
	}

	if (selectedLinkElement != null)
	{
		linkAttributes.href			= selectedLinkElement.getAttribute('orgurl') == null ? selectedLinkElement.href : selectedLinkElement.getAttribute('orgurl');
		linkAttributes.target		= selectedLinkElement.getAttribute('target');
		var href = linkAttributes.href
		if (href.indexOf('epslanguage=') > 0 && href.length >= href.indexOf('epslanguage=') + 14)
		{
			var language = href.substr(href.indexOf('epslanguage=') + 12, href.length);
			if (language.indexOf('&') > 0)
				language = language.substring(0,language.indexOf('&'));
			linkAttributes.language = language;
		}
		linkAttributes.title		= selectedLinkElement.getAttribute('title');
		if (linkAttributes.href && linkAttributes.href.length > 0)
		{
			dialogUrl += (dialogUrl.indexOf('?') > -1) ? '&' : '?';
			dialogUrl += 'url=' + encodeURIComponent(linkAttributes.href);
		}
	}
	linkAttributes.text						= selText;
	linkAttributes.imageObject				= imageAttributes;
	linkAttributes.imageDialogUrl			= imageDialogUrl;
	linkAttributes.fileManagerBrowserUrl	= fileManagerBrowserUrl;
	linkAttributes.resizeDialogUrl			= resizeDialogUrl;
	linkAttributes.parentWindow				= window;
	
	var allAnchors = new Array();
	for(e = 0; e < window.editorList.length; e++)
	{
		var editorInstanceAnchors = window.editorList[e].editor.document.anchors;
		for(i = 0; i < editorInstanceAnchors.length; i++)
			allAnchors.push(editorInstanceAnchors[i].name);
	}
	linkAttributes.anchors		= allAnchors.sort();

	returnValue = OpenDialog(dialogUrl, linkAttributes, 445, 412);
	// TODO: Compare the input "linkAttributes" and "returnValue" to see if they are identical
	// to prevent an undo-step when opening and clicking OK without modifications
	if(returnValue != null && returnValue != 0)
	{
		UpdateHyperlink(selectedLinkElement, currentRange, returnValue, selType, selectedImageElement);
	}
}
