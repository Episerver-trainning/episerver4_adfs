var portlet;
function onMouseOver(element) {
  var segments = element.clientname.substring(1).split('_');
  portlet = segments[0];
  var r = segments[1];
  var c = segments[2];
  clearAll();
  markRow(r);
  markCol(c);
  markBox(r,c);
  //setMissing(r,c);
  element.focus();
  element.select();
}

function onHintClick(element) {
//    trace('onHintClick');
    setHint();
}

function onMouseOut(element) {
//    trace('onMouseOut');
    element.blur();
//    trace('onMouseOut - finished');
}

function onKeyUp(element) {
//    trace('onKeyUp');
//    element.blur();
//    trace('onKeyUp - finished');
}

function getTable() {
	var tables = document.getElementsByTagName('table');
	for (i = 0; i < tables.length; i++)
		if (tables[i].attributes['clientname'] && tables[i].clientname == 'sudokuTable'+portlet) return tables[i];
	return null;
}

function clearAll() {
    var table = getTable();
    for (r = 0; r < 9; r++)
        for (c = 0; c < 9; c++)
            table.rows[r].cells[c].style.backgroundColor = '';
}
function markRow(row) {
    var table = getTable();
    for (c = 0; c < 9; c++)
        table.rows[row].cells[c].style.backgroundColor = "#9999ff";
}
function markCol(col) {
    var table = getTable();
    for (r = 0; r < 9; r++)
        table.rows[r].cells[col].style.backgroundColor = "#9999ff";
}
function markBox(row,col) {
    var table = getTable();
    var brow = Math.floor(row / 3);
    var bcol = Math.floor(col / 3);
    for (r = 0; r < 3; r++)
        for (c = 0; c < 3; c++)
            table.rows[brow*3+r].cells[bcol*3+c].style.backgroundColor = "#9999ff";
}

function setHint() {
    var table = getTable();
    for (r = 0; r < 9; r++) {
        for (c = 0; c < 9; c++) {
            if (table.rows[r].cells[c].firstChild.value) {
                var missing;
                missing = getMissing(r,c).length;
                if (missing == 1)
                    table.rows[r].cells[c].firstChild.className = 'hint'; 
            }
        }
    }
}

/*
function setMissing(row, col) {
    var missing = getMissing(row, col);
    var output = '';
    for (i = 0; i < missing.length; i++)
        output += missing[i] + ' ';
    hint.innerText = output;
}
function getMissing(row, col) {
    trace('getMissing r' + row + ' c' + col);
    var table = document.all.sudokuTable;
    var hint = document.all.hint;
    var vals = new Array();
    var brow = Math.floor(row / 3);
    var bcol = Math.floor(col / 3);
    
    for (r = 0; r < 9; r++) {
          if (table.rows[r].cells[col].firstChild.value && table.rows[r].cells[col].firstChild.value.length > 0) 
              vals.push(table.rows[r].cells[col].firstChild.value);
          else if (table.rows[r].cells[col].innerText && table.rows[r].cells[col].innerText.length > 0) 
              vals.push(table.rows[r].cells[col].innerText);
    }
    for (c = 0; c < 9; c++) {
        if (table.rows[row].cells[c].firstChild.value && table.rows[row].cells[c].firstChild.value.length > 0) 
            vals.push(table.rows[row].cells[c].firstChild.value);
        else if (table.rows[row].cells[c].innerText && table.rows[row].cells[c].innerText.length > 0)
            vals.push(table.rows[row].cells[c].innerText);
    }
    for (r = 0; r < 3; r++) {
        for (c = 0; c < 3; c++) {
            if (table.rows[brow*3+r].cells[bcol*3+c].firstChild.value && table.rows[brow*3+r].cells[bcol*3+c].firstChild.value.length > 0) 
                vals.push(table.rows[brow*3+r].cells[bcol*3+c].firstChild.value);
            else if (table.rows[brow*3+r].cells[bcol*3+c].innerText && table.rows[brow*3+r].cells[bcol*3+c].innerText.length > 0)
                vals.push(table.rows[brow*3+r].cells[bcol*3+c].innerText);
        }
    }
    
    // calculate a number of set operations...
    vals.sort();
    var unique = new Array();
    for (i = 0; i < vals.length; i++)
        if (unique[unique.length - 1] != vals[i])
            unique.push( vals[i] );
    var range = new Array(1,2,3,4,5,6,7,8,9);
    var missing = new Array();
    var ui = 0;
    for (i = 0; i < range.length; i++) {
        if (ui >= unique.length || range[i] < unique[ui]) 
            missing.push(range[i]);
        else 
            ui++;
    }
    return missing;
}
*/
