/*
 * PasteUnformatted.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("PasteUnformatted 11");

var _allTagsRegExp		= new RegExp("<(/{0,1})(\\w+)([\\s\\S]*?)>", "ig");
var _styleClassRegExp	= new RegExp("(style|class|bgcolor|background|bordercolor)\\s*=\\s*([\"'].*?[\"']|[^\"']\\S*)", "ig");
var _outerTagRegExp		= new RegExp("^\\s*<(\\w+)([^>]*>)([\\S\\s]+)<\\/\\1>\\s*$"); 
var _startsWithTag		= new RegExp("^\\s*<");
var _cssRules			= [];

function CleanUpAfterFormatting(id)
{
	// Make sure that there are no orphaned element references left behind (since we have rebuilt contents).
	var editor = eval(id + '_IFrameObj').editorAPI;
	editor.ResetLastEvent();
	// Fix tables that have damaged visuals because the design classes has been removed
	editor.AddTableDesignElements();
}

function removeFormatting(id)
{
	// An image or other control is selected, cannot do anything with that...
	if (IsControlSelection(id))
		return;

	var defaultTag		= GetDefaultFormattingElement(id);
	var editorAPI		= eval(id + '_IFrameObj').editorAPI;
	var cells			= editorAPI.selectedCells;
	
	if (editorAPI.IsEntireTableSelected())
	{
		var sourceIndex = editorAPI.table.sourceIndex;
		editorAPI.table.outerHTML = RemoveFormattingTags(editorAPI.table.outerHTML, defaultTag);
		editorAPI.InitActiveTable( editorAPI.editorDocument.all(sourceIndex) );
		editorAPI.SelectEntireTable( editorAPI.table );
		CleanUpAfterFormatting(id);
		return;
	}
	
	if (cells && cells.length >= 1)
	{
		// One or more table cells are selected, remove formatting from each cell
		RemoveFormattingFromElements(cells, defaultTag, true);
		CleanUpAfterFormatting(id);
		return;
	}
	
	var currentRange	= getEditor(id).document.selection.createRange();
	if (IsEmptyRange( currentRange ))
		currentRange.moveToElementText( currentRange.parentElement() );
	
	var currentBody		= getEditor(id).document.body;
	var fullRange		= currentBody.createTextRange();
	
	// Entire text selected ?
	if (IsSameRange(fullRange, currentRange))
	{
		currentBody.innerHTML = RemoveFormattingTags(currentBody.innerHTML, defaultTag);
		currentRange.moveToElementText( currentBody );
	}
	else
	{
		var dummyRange = currentRange.duplicate();
		var wordsToSelection = -dummyRange.moveStart("word", -0x7FFFFFFF);
		var characterLength = currentRange.text.length;
		

		// Check if range is inside a table or a list
		var parentElement = currentRange.parentElement();
		while (parentElement && parentElement.tagName.search(/^(body|td|th|li)$/i) < 0)
		{
			parentElement = parentElement.parentElement;
		}
		
		// If the current selection is inside a table or a list, special-case it
		if (parentElement && parentElement.tagName.toLowerCase() != 'body')
		{
			RemoveFormattingFromElements( [parentElement], defaultTag, false );
		}
		else
		{
			// Special case - if current range exactly covers a parent element, move range to parent element
			if (currentRange.htmlText == currentRange.parentElement().innerHTML)
				currentRange.moveToElementText(currentRange.parentElement());
				
			var beginRange = currentRange.duplicate();
			beginRange.collapse();
			beginRange.setEndPoint('StartToStart', fullRange);

			var endRange = currentRange.duplicate();
			endRange.collapse(false);
			endRange.setEndPoint('EndToEnd', fullRange);
			
			if (beginRange.compareEndPoints('StartToEnd', beginRange) == 0)
				currentBody.innerHTML = RemoveFormattingTags(currentRange.htmlText, defaultTag) + endRange.htmlText;
			else
				currentBody.innerHTML = beginRange.htmlText + RemoveFormattingTags(currentRange.htmlText, defaultTag) + endRange.htmlText;
		}
		currentRange.move("character", -0x7FFFFFFF);
		currentRange.move("word", wordsToSelection);
		currentRange.moveEnd("character", characterLength);
	}
	
	currentRange.select();
	CleanUpAfterFormatting(id);
}

function RemoveFormattingFromElements( cells, defaultTag, removeClassFromTD )
{
	var index;
	var cell;
	
	for (index = 0; index < cells.length; index ++)
	{
		cell = cells[index];
		cell.innerHTML = RemoveFormattingTags(cell.innerHTML, defaultTag);
		if (removeClassFromTD)
			SetTableCellClass( cell, null );
	}
}

function RemoveFormattingTags( html, newTag )
{
	// Remove all tags except P, DIV, BR, TABLE, IMG, A, UL, LI, OL
	var match;
	var leaveTagsNoAttributes = new RegExp("^(p|div|br|ul|li|ol)$", "i");
	var leaveTagsRemoveFormatting = new RegExp("^(table|tr|td|th|tbody|img|a|map|area)$", "i");
	var lastMatchIndex = 0;
	var newHtml = '';
	
	// Replace all H tags with the default paragraph tag (i e DIV or P)
	html = html.replace(/<(\/{0,1})(h[1-7])>/ig, '<$1' + newTag + '>');
	_allTagsRegExp.exec('');
	while ( (match = _allTagsRegExp.exec(html)) != null)
	{
		var slash = match[1];
		var tagName = match[2];
		var attributes = match[3];
		if (leaveTagsNoAttributes.test(tagName))
		{
			newHtml += html.substring(lastMatchIndex, match.index) + '<' + slash + tagName + '>';
			lastMatchIndex = match.lastIndex;
			continue;
		}
		if (leaveTagsRemoveFormatting.test(tagName))
		{
			attributes = attributes.replace(_styleClassRegExp, '');
			newHtml += html.substring(lastMatchIndex, match.index) + '<' + slash + tagName + attributes + '>';
			lastMatchIndex = match.lastIndex;
			continue;
		}
		newHtml += html.substring(lastMatchIndex, match.index);
		lastMatchIndex = match.lastIndex;
	}
	newHtml += html.substr(lastMatchIndex);
	return newHtml;
}

// Paste unformatted tool
function pasteUnformatted(id)
{
	var iframeObj = eval(id + '_IFrameObj');	

	textToPaste = clipboardData.getData('Text');

	if(textToPaste != null)
	{
		//Make sure testToPaste is a correct string by forcing a conversion
		textToPaste += '';
 		iframeObj.tableEdit.editorDocument.selection.createRange().text = textToPaste;
 	}
}

function GetDefaultFormattingElement(id)
{
	var iframeObj = eval(id + '_IFrameObj');		
	return iframeObj.editorAPI.ParagraphIsDiv ? "DIV" : "P";
}

function IsControlSelection(id)
{
	return getEditor(id).document.selection.type.toLowerCase() == 'control';
}

function insertStyleSheetMenuItems(id, menu)
{
	var i;
	var oldItems = null;

	menu.editorID = id;

	// The style items the we are going to load are always on top of the menu, 
	// so remove any existing items and save them so we can add them back later.
	if (menu.menuItems.length > 0)
	{
		oldItems = menu.menuItems;
		menu.menuItems = new Array();
		this.itemCount = 0;
	}	
	
	menu.sortedMenu = true;
	menu.sortKeyPrefix = "--";

	ReadCssRules(id);
	for (i = 0; i < _cssRules.length; i ++)
	{
		var rule = _cssRules[i];
		if (rule.Id != id)
			continue;

		var className	= rule.ClassName;
		var tagName		= rule.TagName;
		var sortKey		= String.fromCharCode(i + 64);

		// Ignore rules defined for image elements in this menu
		if(tagName == 'IMG' || tagName == 'TABLE' || tagName == 'TH' || tagName == 'TD')
			continue;

		if (className != null)
			className = "'" + className + "'";
				
		if (tagName != null)
			tagName = "'" + tagName + "'";
					
		var onclickScript = "setClassName('" + id + "','" + rule.MenuName + "'," + className + "," + tagName + ");"
		menu.AddMenuItem(rule.MenuName, null, onclickScript, "true", null, null, null, sortKey);
	}

	menu.sortKeyPrefix = null;		

	if (menu.menuItems.length > 0)
	{
		// Add a separator between stylesheet items and the "Remove formatting" item that will be added later. 
		// (the sortkey guarantees correct position in the menu)
		sortKey = "-";
		menu.AddMenuItem(null,null,null,'true',null,null,null, sortKey);
	}
	
	// Add any old items back
	if (oldItems)
	{
		for(i = 0; i < oldItems.length; i++)
			menu.menuItems[this.itemCount++] = oldItems[i];
	}	
}

function ReadCssRules(id)
{
	var editor;
	var styleSheets;
	var cssIndex;
	var editorCSS;
	var rule;
	var i;
	var menuName;

	try
	{
		editor		= getEditor(id);
		styleSheets	= editor.document.styleSheets;
		
		for(cssIndex = 0; cssIndex < styleSheets.length; cssIndex++)
		{
			editorCSS = styleSheets[cssIndex];				
			
			for(i = 0; i < editorCSS.rules.length; i++)
			{
				rule = editorCSS.rules[i];

				menuName = rule.style.getAttribute('EditMenuName');
				if (menuName == null)
					continue;
				if (RuleDefined(id,menuName))
					continue;
	
				var ruleName  = new String( rule.selectorText );
				var tagName	  = null;
				var className = null;	
				var splitPos  = ruleName.indexOf('.');

				if (splitPos == 0)
				{
					// A dot appeared as the first character in the selector text, i e we only
					// have a class name not connected to a tag.
					className = ruleName.substring(1, ruleName.length);
				}
				else if(splitPos > 0)
				{
					// A dot appeared somewhere in the text, i e text before dot = tag name, text
					// after the dot = class name
					tagName = ruleName.substring(0, splitPos).toUpperCase();
					className = ruleName.substring(splitPos + 1, ruleName.length);
				}
				else
				{
					// No dot found, we only have a tag name
					tagName = ruleName.toUpperCase();
				}
				
				_cssRules[_cssRules.length] = {MenuName:menuName, ClassName:className, TagName:tagName, Id:id};
			}
		}
	}
	catch(e)
	{
		// Uncomment for debugging
		//status = "Stylesheet menu disabled, can not read stylesheets because " + e.message.toLowerCase();
	}
}

function RuleDefined(id,menuName)
{
	var i;
	var rule;
	for (i = 0; i < _cssRules.length; i ++)
	{
		var rule = _cssRules[i];
		if (rule.MenuName == menuName && rule.Id == id)
			return true;
	}
	
	return false;
}

function insertStyleSheetDropdownItems(id, menu, tool)
{
	var classSelectID = id + '_class';
	var classSelect = document.createElement('SELECT');
	var i;

	classSelect.id = classSelectID;
	classSelect.onchange = function() { ClassPickerDropdown_onchange(id,tool) };
	classSelect.disabled = !tool.editorAPI.editable;
	tool.appendChild(classSelect);
	tool.classSelect = classSelect;
	tool.style.marginLeft = '3px';
	tool.style.marginTop = '0px';
	tool.style.height = '1.9em';

	ReadCssRules(id);
	
	for (i = 0; i < _cssRules.length; i ++)
	{
		var rule	= _cssRules[i];
		if (rule.Id != id || rule.TagName == 'IMG' || rule.TagName == 'TABLE' || rule.TagName == 'TH' || rule.TagName == 'TD') // Ignore styles for image elements in this dropdown
			continue;
		AddFormattingOption(rule.MenuName, i, id);
		rule.ToolId = tool.id;
	}
	if (classSelect.options.Length > 0)
		classSelect.value = 0;

	tool.Handle_onstatechange = function(id) { ClassPickerDropdown_onstatechange(id,tool); };
	tool.Handle_onunload = CleanUpStyleSheetDropdownItems;
}

function AddFormattingOption(name, index, id)
{
	var classSelect = document.getElementById(id + '_class');
	var opt		= document.createElement('OPTION');
	opt.text	= name;
	opt.value	= index;
	classSelect.options.add(opt);
}

function CleanUpStyleSheetDropdownItems(tool)
{
	tool.classSelect.onchange	= null;
	tool.classSelect			= null;
	tool.Handle_onstatechange	= null;
}

function ClassPickerDropdown_onchange(id,tool)
{
	var classSelect = document.getElementById(id + '_class');
	var ruleIndex = classSelect.value;
	
	tool.editorDocument.body.focus();
	if (classSelect.value == 'remove')
	{
		removeFormatting(id);
	}
	else
	{
		var rule = _cssRules[ruleIndex];
		if (rule)
			setClassName(id, rule.MenuName, rule.ClassName, rule.TagName);
	}
}

function ClassPickerDropdown_onstatechange(id,tool)
{
	var classSelect = document.getElementById(tool.editorAPI.editorID + '_class');
	if (id == 'FontName' || tool.status == TOOLSTATUS_NOT_SELECTABLE)
	{
		classSelect.disabled = tool.status == TOOLSTATUS_NOT_SELECTABLE;
		return;
	}
	if (tool.editorAPI.editorState.Mode == EDITORMODE_HTML)
		return;
	if (tool.status >= tool.editorDocument.all.length)
		return;
	
	var currentContext = '';
	var element = tool.editorDocument.all[tool.status];
	var tag;
	var innermostClass = -1;
	while (element.tagName.toLowerCase() != 'body')
	{
		tag = '<' + element.tagName;
		if (element.className)
		{
			tag += ' class=' + element.className;
		}
		currentContext = tag + '>' + currentContext;
		
		if (innermostClass < 0)
		{
			innermostClass = IdentifyClass(tool.id, element);
		}
		element = element.parentElement;
	}
	classSelect.value = innermostClass;
	status = currentContext;
}

function IdentifyClass(toolId, element)
{
	var foundClass = null;
	var i;
	
	for (i = 0; i < _cssRules.length; i ++)
	{
		var rule = _cssRules[i];
		if (rule.ToolId != toolId)
			continue;
			
		if (((rule.TagName == element.tagName) || (rule.TagName == null)) && ((rule.ClassName == element.className) || (rule.ClassName == null && element.className == '')))
			return i;
	}
	
	return -1;
}

function contains(array, string)
{
	var x;
	for(x = 0; x < array.length; x++)
		if(array[x] == string) return true;
	return false;
}

function IsEmptyRange(range)
{
	return range != null && range.compareEndPoints('StartToEnd', range) == 0;
}

function IsValidToReplace(fromTag)
{
	return (fromTag.search(/^(FONT|STRONG|EM|B|I|U|P|SPAN|DIV|H[1-7])$/i) != -1);
}

function RemoveValidToReplaceTags(htmlText)
{
	return htmlText.replace(/<\/?(FONT|STRONG|EM|B|I|U|P|SPAN|DIV|H[1-7])(>|(\s(\s|\S)*?>))/gi,'');	
}

function IsBlockElement(element)
{
	if (element.style.display.indexOf('block') != -1)
		return true;
		
	// Nothing in the display style attribute that says about "block", but it can still be a 
	// block element, if it is one of the default block elements.
	return (element.tagName.search(/^(ADDRESS|BLOCKQUOTE|CENTER|COL|COLGROUP|DD|DIR|DIV|DL|DT|FIELDSET|FORM|H[1-7]|HR|IFRAME|LEGEND|LISTING|MARQUEE|MENU|OL|P|PLAINTEXT|PRE|TABLE|TD|TH|TR|UL|XMP)$/i) != -1);
}

function ConstructHtmlTag(htmlText, descriptor)
{
	var tagName = descriptor.tagName;

	if (tagName == null)
		tagName = descriptor.defaultTagName;

	htmlText = RemoveValidToReplaceTags(htmlText);

	if (descriptor.className != null)
	{
		return '<' + tagName + ' class="' + descriptor.className + '">' + htmlText + '</' + tagName + '>';
	}

	return '<' + tagName + '>' + htmlText + '</' + tagName + '>';
}

function ReformatTableCells( cells, currentRange, descriptor, throwErrors )
{
	var index;
	var formatTag = descriptor.tagName == null ? null : descriptor.tagName.toUpperCase();
	
	if (descriptor.className != null && (formatTag == null || formatTag == 'TD' || formatTag == 'TH'))
	{
		// If it is a class that can be used on a td / th, simply set the 
		// class for the cell and do nothing with the cell contents.
		for (index = 0; index < cells.length; index ++)
		{
			SetTableCellClass( cells[index], descriptor )
		}
	}
	else
	{
		// Reformat each cell as a separate range
		var range = currentRange.duplicate();
		
		for (index = 0; index < cells.length; index ++)
		{
			range.moveToElementText( cells[index] );
			ReformatRange( range, descriptor, throwErrors );
		}
	}
}

function StripCrLf(inputString)
{
	return inputString.replace(/[\r\n]/gi,'');
}

function ParentRangeReformat( currentRange, descriptor )
{
	// A workaround to handle lists (ul/ol) which returns a parent element equal to an <li>
	// even though the current range covers the entire list. Iterate up thru the parent structure
	// until we have at least the same amount of text for the parent as the current range.
	var parentElement = currentRange.parentElement();
	if (parentElement.tagName.toUpperCase() == 'BODY')
		return false;
		
	var testRange = currentRange.duplicate();
	var minTextLength = StripCrLf(currentRange.htmlText).length;
	var isMatch = false;
	
	while (StripCrLf(parentElement.outerHTML).length < minTextLength)
	{
		parentElement = parentElement.parentElement;
		if (parentElement.tagName.toUpperCase() == 'BODY')
			return false;
		testRange.moveToElementText(parentElement);
		isMatch = true;
	}

	if (isMatch && IsSameRange(currentRange, testRange))
	{
		descriptor.defaultTagName = 'span';
		parentElement.outerHTML = ConstructHtmlTag(parentElement.outerHTML, descriptor);
		return true;
	}
	
	return false;
}

function IsSameRange( range1, range2 )
{
	if (range1.isEqual(range2))
		return true;
		
	if (range1.compareEndPoints("StartToStart",range2) != 0)
		return false;
		
	// Ideally the range1.isEqual(range2) test should be sufficient, but in reality isEqual can return false
	// even though the ranges start and end points match. This test is safer and does what we want.
	if (range1.compareEndPoints("EndToEnd",range2) == 0)
		return true;
		
	// Finally we have another problematic case where we need to check the textual content...
	return range1.text == range2.text;
}

function ReformatRange( currentRange, descriptor, throwErrors )
{
	if (IsEmptyRange(currentRange))
	{
		currentRange.moveToElementText( currentRange.parentElement() );
		ReformatParent( currentRange, descriptor, throwErrors );
	} 
	else if (IsSameRange(currentRange, GetParentRange(currentRange)))
	{
		ReformatParent( currentRange, descriptor, throwErrors );
	}
	else if (!ParentRangeReformat(currentRange, descriptor))
	{
		descriptor.defaultTagName = 'span';		
		currentRange.pasteHTML( ConstructHtmlTag(currentRange.htmlText, descriptor) );
	}
}

function SetTableCellClass( currentElement, descriptor )
{
	var className = ' ' + currentElement.className + ' '; 
	var designStyles = (descriptor == null || descriptor.className == null) ? new Array() : [descriptor.className];

	if (className.search(/\sselectable\s/) >= 0)
		designStyles.push('selectable');
	if (className.search(/\sborderless\s/) >= 0)
		designStyles.push('borderless');
	if (className.search(/\sselected\s/) >= 0)
		designStyles.push('selected');

	currentElement.className = designStyles.join(' ');
}

function GetFirstParentBlockElement(element, violatingTag)
{
	while(element != null)
	{		
		if (IsBlockElement(element))
			break;
		element = element.parentElement;
	}		

	return element;
}

function TagNestingError(element, descriptor)
{
	var newtag = descriptor.tagName;
	if (newtag == null)
		newtag = descriptor.defaultTagName;
	var blockElement = GetFirstParentBlockElement(element, newtag);
	var blockTag;
	
	if (blockElement != null)
		blockTag = '<' + blockElement.tagName + '>';
	else
		blockTag = '<' + element.tagName + '> or one of its parent elements';

	ShowMsg('Invalid nesting of tags - cannot place <' + newtag + '> inside ' + blockTag);
}

function SetElementContent(currentElement, savedHtml, descriptor, throwErrors)
{
	if (!currentElement.canHaveHTML)
		return;
		
	if (currentElement.tagName == descriptor.tagName && descriptor.className != null)
	{
		// Special case, make a copy of the current element and set the new class
		// to retain any special attributes.
		var clonedElement = currentElement.document.createElement(currentElement.outerHTML);
		var newElementHTML = clonedElement.outerHTML.slice(0,-3-descriptor.tagName.length) + savedHtml + '</' + descriptor.tagName + '>';
		clonedElement.className = descriptor.className;		
		currentElement.outerHTML = newElementHTML;
		return;
	}

	try
	{
		currentElement.innerHTML = ConstructHtmlTag(savedHtml, descriptor);
	}
	catch (ex)
	{
		if (throwErrors)
			throw ex;
			
		TagNestingError(currentElement, descriptor);
	}
}

function ReformatParent( currentRange, descriptor, throwErrors )
{
	var ex;
	var currentElement;
	var savedHtml;
	var parentElement	= currentRange.parentElement();
	if (parentElement.canHaveHTML)
		savedHtml = parentElement.innerHTML;
	else
		savedHtml = parentElement.outerHTML;
	
	while (IsValidToReplace(parentElement.tagName))
	{
		currentElement	= parentElement;
		parentElement	= parentElement.parentElement;

		if (parentElement.childNodes.length != 1)
		{
			if (currentElement.tagName.toUpperCase() == 'SPAN')
				descriptor.defaultTagName = 'SPAN';
			try
			{
				currentElement.outerHTML = ConstructHtmlTag(savedHtml, descriptor);
			}
			catch (ex)
			{
				if (throwErrors)
					throw ex;
					
				TagNestingError(parentElement, descriptor);
			}
			return;
		}
	}
	
	SetElementContent(parentElement, savedHtml, descriptor, throwErrors);
}

function setClassName(id, menuName, className, tagName)
{
	if (IsControlSelection(id))
		return;

	var throwErrors = true;
	
	try
	{
		FormatSelection(id, menuName, className, tagName, throwErrors);
	}
	catch(ex)
	{
		removeFormatting(id);

		throwErrors = false;
		FormatSelection(id, menuName, className, tagName, throwErrors);
	}
	
	CleanUpAfterFormatting(id);
}

function FormatSelection(id, menuName, className, tagName, throwErrors)
{
	var editorAPI			= eval(id + '_IFrameObj').editorAPI;	
	var currentRange		= getEditor(id).document.selection.createRange();
	var orgRangeBookmark	= currentRange.getBookmark();
	var descriptor			= {className:className, tagName:tagName, defaultTagName:GetDefaultFormattingElement(id)};
	var cells				= editorAPI.selectedCells;
	
	if (cells && cells.length >= 1)
	{
		ReformatTableCells(cells, currentRange, descriptor, throwErrors);
	}
	else
	{
		ReformatRange(currentRange, descriptor, throwErrors);

		// Restore selection
		if (orgRangeBookmark != null)
		{
			currentRange.moveToBookmark(orgRangeBookmark);
			
			// The following is needed to get the correct parent element from our selection,
			// otherwise the selections parent element will be body, i e it seems as if
			// the object model has been a bit confused by reselecting a bookmark over a text
			// range that was changed.
			currentRange.collapse();
			var currentElement = currentRange.parentElement();
			if (currentElement)
				currentRange.moveToElementText(currentElement);
			currentRange.select();
		}
	}	
}
