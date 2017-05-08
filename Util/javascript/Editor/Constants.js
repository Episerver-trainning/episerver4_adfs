/*
 * Constants.js	- EPiServer DHtml Editor pseudo constant definitions
 * Copyright (c) 2004 ElektroPost Stockholm AB
 */

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("Constants 5");


// Direction of split when splitting a cell
var SPLIT_HORIZONTALLY		= 1;
var SPLIT_VERTICALLY		= 2;

// Design-time classes for table cells
var CLASS_SELECTED			= 'selected';
var CLASS_SELECTABLE		= 'selectable';
var CLASS_BORDERLESS		= 'borderless';
var CLASS_ROWHEADER			= 'rowheader';
var CLASS_COLHEADER			= 'colheader';

// Flag value used to indicate multiple values for an attribute (cell properties)
var MULTIPLE_VALUES			= -1;

// Precompiled regular expressions for fast lookups
var HAS_CLASS_SELECTED			= new RegExp(CLASS_SELECTED); 
var HAS_CLASS_SELECTABLE		= new RegExp(CLASS_SELECTABLE); 
var HAS_CLASS_BORDERLESS		= new RegExp('\\s*' + CLASS_BORDERLESS); 
var HAS_CLASS_ROWHEADER			= new RegExp('\\s*' + CLASS_ROWHEADER); 
var HAS_CLASS_COLHEADER			= new RegExp('\\s*' + CLASS_COLHEADER); 
var HEADERS_AND_BORDERLESS_REGEXP = new RegExp('\\s*(' + CLASS_BORDERLESS + '|' + CLASS_ROWHEADER + '|' + CLASS_COLHEADER + ')','g');
var REMOVE_TABLE_CLASSES_REGEXP	= new RegExp('\\s*(' + CLASS_BORDERLESS + '|' + CLASS_SELECTABLE + ')', 'g');
var REMOVE_CELL_CLASSES_REGEXP	= new RegExp('\\s*(' + CLASS_BORDERLESS + '|' + CLASS_SELECTABLE + '|' + 
												CLASS_SELECTED  + '|' + CLASS_ROWHEADER + '|' + CLASS_COLHEADER + ')', 'g');
var ALL_IMG_AND_A_TAGS_REGEXP	= new RegExp("(<(a|img)\\s[^>]+>)", "ig");
var URL_WITH_QUOTES_REGEXP		= new RegExp("(src|href)\\s*=\\s*([\"'])(.+?)\\2", "i");
var URL_WITH_NO_QUOTES_REGEXP	= new RegExp("(src|href)\\s*=\\s*([^\\s>]+)", "i");
var ALL_ORGURLS_REGEXP			= new RegExp("\\sorgurl\\s*=", "ig");
var ALL_NULL_ORGURLS_REGEXP		= new RegExp('\\sorgurl\\s*="null"', "ig");
var ORGURL_WITH_QUOTES_REGEXP	= new RegExp("\\s(orgurl)\\s*=\\s*([\"'])(.+?)\\2", "i");
var ORGURL_WITH_NO_QUOTES_REGEXP= new RegExp("\\s(orgurl)\\s*=\\s*([^\\s>]+)", "i");
var IS_IMG_REGEXP				= new RegExp("<img\\s", "i");
var HAS_ALT_REGEXP				= new RegExp("\\salt\\s*=", "i");
var HAS_VSPACE_REGEXP			= new RegExp("\\svspace\\s*=", "i");
var ORGVSPACE_WITH_QUOTES_REGEXP = new RegExp("\\s(orgvspace)\\s*=\\s*([\"'])(.+?)\\2", "i");
var ZERO_VSPACE_REGEXP			= new RegExp("\\svspace\\s*=\\s*([\"']{0,1})0\\1", "i");

// Constants for the URL_ and ORGURL_ reg expressions above
var TAG_INDEX					= 1; 
var URL_INDEX					= 2;
var QUOTES_INDEX				= 2;
var ATTRIB_VALUE_INDEX			= 3;  

var HOVERMARGIN_TABLE	= 5;
var HOVERMARGIN_CELL	= 1;

var HOVER_NONE			= 0;
var HOVER_CELL_LEFT		= 1;
var HOVER_CELL_TOP		= 2;
var HOVER_CELL_BOTTOM	= 3;
var HOVER_CELL_RIGHT	= 4;
var HOVER_TABLE_LEFT	= 5;
var HOVER_TABLE_TOP		= 6;
var HOVER_TABLE_BOTTOM	= 7;
var HOVER_TABLE_RIGHT	= 8;

var MULTISELECT_NONE	= 0;
var MULTISELECT_CELLS	= 1;
var MULTISELECT_ROWS	= 2;
var MULTISELECT_COLUMNS = 3;

var KEYBIT_CTRL			= 1;
var KEYBIT_SHIFT		= 2;
var KEYBIT_ALT			= 4;

var KEYMASK_NO_KEYS		= 0;
var KEYMASK_CTRL_ONLY	= KEYBIT_CTRL;
var KEYMASK_SHIFT_ONLY	= KEYBIT_SHIFT;
var KEYMASK_ALT_ONLY	= KEYBIT_ALT;
var KEYMASK_CTRL_SHIFT	= KEYBIT_CTRL + KEYBIT_SHIFT;
var KEYMASK_CTRL_ALT	= KEYBIT_CTRL + KEYBIT_ALT;

var KEYCODE_BACKSPACE	= 8;
var KEYCODE_TAB			= 9;
var KEYCODE_SHIFT_ONLY	= 16;
var KEYCODE_CONTROL_ONLY= 17;
var KEYCODE_ALT_ONLY	= 18;
var KEYCODE_ENTER		= 13;
var KEYCODE_LEFT		= 37
var KEYCODE_DELETE		= 46;
var KEYCODE_A			= 65;
var KEYCODE_C			= 67;
var KEYCODE_K			= 75;
var KEYCODE_Q			= 81;
var KEYCODE_V			= 86;
var KEYCODE_X			= 88;
var KEYCODE_Y			= 89;
var KEYCODE_Z			= 90;

var RIGHT_MOUSE_BUTTON	= 2;

// Cursor styles when resizing, straight from the HTML standard, so do not change.
var CURSOR_NORTH		= "n";
var CURSOR_SOUTH		= "s";
var CURSOR_EAST			= "e";
var CURSOR_WEST			= "w";

// Resize-direction bits
var DIRECTION_NORTH		= 1;
var DIRECTION_SOUTH		= 2;
var DIRECTION_EAST		= 4;
var DIRECTION_WEST		= 8;

// Tool status constants
var TOOLSTATUS_UNKNOWN				= 0
var TOOLSTATUS_SELECTED				= 1;
var TOOLSTATUS_SELECTABLE			= 2;
var TOOLSTATUS_NOT_SELECTABLE		= 3;

var TOOLSTATE_KEY					= 0;
var TOOLSTATE_KEY_CLICKSCRIPT		= 1;
var TOOLSTATE_KEY_ENABLEDSCRIPT		= 2;
var TOOLSTATE_KEY_ONLOADSCRIPT		= 3;
var TOOLSTATE_KEY_ONSUBMITSCRIPT	= 4;
var TOOLSTATE_KEY_HOTKEY			= 5;
var TOOLSTATE_KEY_INFOSTRING		= 6;

var COMMAND_IDENTIFIER_NAME				= 0;
var COMMAND_IDENTIFIER_LAST_STATUS		= 1;
var COMMAND_IDENTIFIER_TOOL_STARTINDEX	= 2;

// Reserved dialog argument indexes
var DLG_ARGS_PARENT_WINDOW		= 0;
var DLG_ARGS_EDITOR_ID			= 1;
var DLG_ARGS_FONTCOLORLIST		= 2;
var DLG_ARGS_CUSTOM_ARGS_BASE	= 3;

// Reserved SelectValue.aspx dialog indexes
var SELECTDLG_ARGS_WINDOW_TITLE		= 0;
var SELECTDLG_ARGS_SEPARATOR_CHAR	= 1;
var SELECTDLG_ARGS_VALUES			= 2;
var SELECTDLG_ARGS_SELECTED_VALUE	= 3;
var SELECTDLG_ARGS_TEXT				= 4;
var SELECTDLG_ARGS_ALLOW_INPUT		= 5;

// Table moving actions
var MOVE_ACTION_STARTED		= "started"; // When a table is selected for moving
var MOVE_ACTION_MOVING		= "moving";  // When a move point has been set to target the table  
var MOVE_ACTION_NOT_ACTIVE	= null		 // When the move action is not active
