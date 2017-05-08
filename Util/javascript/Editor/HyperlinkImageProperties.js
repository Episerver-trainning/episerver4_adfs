/*
 * ImageProperties.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("HyperlinkImageProperties 3");

function UpdateLinkElement(linkElement, linkAttributes)
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

	if (linkAttributes.title)
		linkElement.title = linkAttributes.title;
	else
		linkElement.removeAttribute('title', 0);

	if (linkAttributes.target && linkAttributes.target.length > 0)
		linkElement.target = linkAttributes.target;
	else
		linkElement.removeAttribute('target', 0);
}

function UpdateImageProperties(selectedImage, newAttributes, currentRange, existingLinkElement)
{
	if (newAttributes == -1)
	{	// The user selected "delete" in the image properties window
		if(existingLinkElement && existingLinkElement.innerHTML == selectedImage.outerHTML)
		{
			var newDisplayText = existingLinkElement.getAttribute('orgurl') == null ? existingLinkElement.href : existingLinkElement.getAttribute('orgurl');
			existingLinkElement.innerHTML = newDisplayText;
		}
		else
			selectedImage.outerHTML = '';
	}
	else
	{	// The user entered values and clicked OK
		// Update a clone of the image, and replace the original with the modified clone (for one-step undo).
		// Create a new element that is a "clone" by virtue of passing in the entire tag when constructing the element...
		var imageObjectHTML = (selectedImage == null) ? 'IMG' : selectedImage.outerHTML;
		var tempImage = document.createElement(imageObjectHTML);

		// Regarding handlling of the text/contents of the link
		// Problem:		We are not allowed to modify tempLinks innerHtml/insertAdjacentHTML/etc without breaking the undo-stack.
		//				(This might be because tempLink is not part of the DOM yet - similar code WORKS for tableEditor, cell properties)
		// Solution:	Convert the tempLink to a string, and find the insert point before the closing tag </ to paste in the content.
		// Drawbacks:	May handle links with attributes or similar containing the "</" sequence. 
		//				String manipulation is not the desired way to manipulate elements and their content.
		var elementAsString;
		var newContent		= '';

		UpdateImageElement(tempImage, newAttributes);
		
		var linkObjectHTML = (existingLinkElement == null) ? 'A' : existingLinkElement.outerHTML;
		var tempLinkObject = document.createElement(linkObjectHTML);
		if(newAttributes.linkObject != null && newAttributes.linkObject != -1)
		{	// The image dialog returned a link object (new link or update of existing link)
			if(existingLinkElement == null)
			{	// We had no link - create a new link element
				UpdateLinkElement(tempLinkObject, newAttributes.linkObject);
				elementAsString = new String(tempLinkObject.outerHTML);
				newContent = tempImage.outerHTML;
				if(selectedImage != null)
				{	// Copy the new values (image AND link) back to the original image
					selectedImage.outerHTML = InsertTagContents(elementAsString, newContent);
				}
				else
				{	// New image AND new link created - paste them where the cursor is
					currentRange.pasteHTML(InsertTagContents(elementAsString, newContent));
				}
			}
			else if(newAttributes.linkObject.isUpdated)
			{	// We had an existing link and it has been modified - update it
				// This means the link is a "pure" image-link, with an existing image
				UpdateLinkElement(tempLinkObject, newAttributes.linkObject);
				elementAsString = new String(tempLinkObject.outerHTML);
				newContent = tempImage.outerHTML;
				// Copy the new values back to the original image
				existingLinkElement.outerHTML = InsertTagContents(elementAsString, newContent);
			}
			return;
		}
		else if(newAttributes.linkObject == -1)
		{	// No link info (no link or remove existing link)
			if(existingLinkElement != null)
			{	// We had an existing link - remove it
				// This means the link is a "pure" image link (no text)
				existingLinkElement.outerHTML = tempImage.outerHTML;
				return;
			}
		}

		// Update only the image object. If a link exists around it, it has not been updated.
		if(selectedImage != null)
		{	// Copy the new values back to the original image
			selectedImage.outerHTML = tempImage.outerHTML;
		}
		else
		{
			currentRange.pasteHTML(tempImage.outerHTML);
		}
	}
}

function UpdateImageElement(tempImage, newAttributes)
{
	// NOTE: The updating of the image's src needs to take place before height/width updates,
	// because IE automatically sets height/width attributes when the src attribute is changed.
	if(newAttributes.src != null)
	{
		tempImage.setAttribute('orgurl', newAttributes.src);
		tempImage.src = newAttributes.src;
	}

	if(newAttributes.align != null)
		tempImage.align	= newAttributes.align;
	else
		tempImage.removeAttribute('align', 0);
	
	if(newAttributes.width != null)
	{
		tempImage.style.width = newAttributes.width;
		tempImage.removeAttribute('width', 0);
	}
	else
	{
		tempImage.removeAttribute('width', 0);
		tempImage.style.removeAttribute('width', 0);
	}

	if(newAttributes.height != null)
	{
		tempImage.style.height = newAttributes.height;
		tempImage.removeAttribute('height', 0);
	}
	else
	{
		tempImage.removeAttribute('height', 0);
		tempImage.style.removeAttribute('height', 0);
	}	

	if(newAttributes.border != null)
		tempImage.border = newAttributes.border;
	else
		tempImage.removeAttribute('border', 0);

	if(newAttributes.hspace != null)
		tempImage.hspace = newAttributes.hspace;
	else
		tempImage.removeAttribute('hspace', 0);

	if(newAttributes.vspace != null)
		tempImage.vspace = newAttributes.vspace;
	else
		tempImage.removeAttribute('vspace', 0);

	if(newAttributes.vspace != null)
	{
		tempImage.vspace = newAttributes.vspace;
		tempImage.orgvspace = newAttributes.vspace;
	}
	else
	{
		tempImage.removeAttribute('vspace', 0);
		tempImage.removeAttribute('orgvspace', 0);
	}

	if(newAttributes.className != null)
		tempImage.className	= newAttributes.className;
	else
		tempImage.removeAttribute('className', 0);

	// Make sure altText is set to either the given value or an empty string
	var altText		= newAttributes.alt;
	altText			= (altText && altText.length > 0) ? altText.Trim() : '';
	tempImage.alt	= altText;
}

function FindParentAElement(selection)
{
	var element;
	
	if(selection.type.toUpperCase() == 'CONTROL')
		element = selection.createRange().item(0);
	else
		element = selection.createRange().parentElement();
	while (element != null && element.tagName.toUpperCase() != 'A')
		element = element.parentElement;
	if(element != null && element.tagName.toUpperCase() == 'A')
		return element;
	else
		return null;
}

function LaunchHyperlinkImageProperties(dialogUrl, id, fileManagerBrowserUrl, linkDialogUrl, resizeDialogUrl)
{
	var image = null;
	var imageAttributes = new Object();
	var linkAttributes = new Object();
	var returnValue;
	var range;
	var selection;

	var iframeObj = eval(id + '_IFrameObj');	
	var editorAPI = iframeObj.tableEdit;

	if (editorAPI.lastEvent != null && 
		editorAPI.lastEvent.srcElement != null && 
		editorAPI.lastEvent.srcElement.tagName.toUpperCase() == 'IMG')
	{
		range = editorAPI.editorDocument.body.createControlRange();
		range.addElement(editorAPI.lastEvent.srcElement);	
		range.select();
	}

	selection = editorAPI.editorDocument.selection;
	range = selection.createRange();

	var linkElement = FindParentAElement(selection);
	if(linkElement != null)
	{
		linkAttributes.href			= linkElement.getAttribute('orgurl') == null ? linkElement.href : linkElement.getAttribute('orgurl');
		linkAttributes.target		= linkElement.getAttribute('target');
		var href = linkAttributes.href
		if (href.indexOf('epslanguage=') > 0 && href.length >= href.indexOf('epslanguage=') + 14)
		{
			var language = href.substr(href.indexOf('epslanguage=') + 12, href.length);
			if (language.indexOf('&') > 0)
				language = language.substring(0,language.indexOf('&'));
			linkAttributes.language = language;
		}
		linkAttributes.title		= linkElement.getAttribute('title');
		if (linkAttributes.href && linkAttributes.href.length > 0)
		{
			dialogUrl += (dialogUrl.indexOf('?') > -1) ? '&' : '?';
			dialogUrl += 'url=' + encodeURIComponent(linkAttributes.href);
		}
	}
	linkAttributes.text						= null;
	linkAttributes.imageObject				= imageAttributes;
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
	linkAttributes.anchors = allAnchors.sort();

	// Set some environment context needed by the dialog window
	imageAttributes.fileManagerBrowserUrl	= fileManagerBrowserUrl;
	imageAttributes.linkDialogUrl			= linkDialogUrl;
	imageAttributes.resizeDialogUrl			= resizeDialogUrl;
	imageAttributes.editorID				= id;
	imageAttributes.parentWindow			= window;
	
	if(selection.type.toUpperCase() == 'CONTROL' && range.item(0).tagName.toUpperCase() == 'IMG')
	{	// Selection is currently an image
		image = range.item(0);
	
		// Check if the selected image is inside a link containing text and/or other images also
		if (linkElement != null && linkElement.innerHTML != range.item(0).outerHTML)
			linkAttributes.isNotPureImageLink = true;

		// Copy the image attributes
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
		{	// No width was set using style...
			var widthAttr = image.getAttributeNode('width');
			if(!widthAttr.specified)
			{	// The "width" attribute was not set for the image - the value in arguments array is "visual" value
				imageAttributes.realwidth	= imageAttributes.width;	// Pass in the base value as separate argument
				imageAttributes.width		= null;						// No value set for width, pass in null
			}
			else
			{	// Arguments array should already contain the correct value. Assign to be clear.
				imageAttributes.width = widthAttr.nodeValue;
			}
		}
		else
		{	// The value for width is defined in the "style" attribute. 
			// Note: The contents in arguments array may be incorrect if the style is set to percentage value. Assign correct value.
			imageAttributes.width = image.style.width;
		}
			
		// Make sure the correct height values are passed in, based on a combination of "height" and "style" attribute values.
		if(image.style.height == null || image.style.height.length == 0) //TEST: use image.style.getAttributeNode(height)...
		{	// No height was set using style...
			var heightAttr	= image.getAttributeNode('height');
			if(!heightAttr.specified)
			{	// The "height" attribute was not set for the image - the value in arguments array is "visual" value
				imageAttributes.realheight	= imageAttributes.height;	// Pass in the base value as separate argument
				imageAttributes.height		= null;						// No value set for the attribute, pass in null
			}
			else
			{	// Arguments array should already contain the correct value. Assign to be clear.
				imageAttributes.height = heightAttr.nodeValue;
			}
		}
		else
		{	// The value for height is defined in the "style" attribute.
			// Note: The contents in arguments array may be incorrect if the style is set to percentage value. Assign correct value.
			imageAttributes.height = image.style.height;
		}
	}
	else if (linkElement != null)
	{	// A new image is being inserted inside a link (already containing text and/or images)
		linkAttributes.isNotPureImageLink = true;
	}
	
	imageAttributes.linkObject = linkAttributes;	
	
	returnValue = OpenDialog(dialogUrl, imageAttributes, 485, 445);
	// TODO: Compare the input "imageAttributes" and "returnValue" to see if they are identical
	// to prevent an undo-step when opening and clicking OK without modifications
	if(returnValue != null && returnValue != 0)
	{
		UpdateImageProperties(image, returnValue, range, linkElement);
	}
}