/*
 * ImageProperties.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("ImageProperties 3");

function UpdateImageProperties(selectedImage, newAttributes)
{
	if(!newAttributes)
		return;
		
	// Update a clone of the image, and replace the original with the modified clone (for one-step undo).
	// Create a new element that is a "clone" by virtue of passing in the entire tag when constructing the element...
	var tempImage = document.createElement(selectedImage.outerHTML);

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
		// Possibly: remove the width attribute, if present
	}
	else
	{
		tempImage.removeAttribute('width', 0);
		tempImage.style.removeAttribute('width', 0);
	}

	if(newAttributes.height != null)
	{
		tempImage.style.height = newAttributes.height;
		// Possibly: remove the height attribute, if present
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

	// Copy the new values back to the original image
	selectedImage.outerHTML = tempImage.outerHTML;
}

function LaunchImageProperties(dialogURL, id, insertImageURL)
{
	var image;
	var imageAttributes = new Object();
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
	
	if(selection.type.toUpperCase() == 'CONTROL' && range.item(0).tagName.toUpperCase() == 'IMG')
	{	// Selection is currently an image
		image = range.item(0);

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
		
		// Set some environment context needed by the dialog window
		imageAttributes.linkEditorUrl	= insertImageURL;
		imageAttributes.editorID		= id;
		imageAttributes.parentWindow	= window;
		
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
	else
	{	// No image was selected
		return;
	}

	returnValue = OpenDialog(dialogURL, imageAttributes, 445, 360);

	UpdateImageProperties(image, returnValue);
}