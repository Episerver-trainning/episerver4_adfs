/*
 * admin.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
function validateFrameset()
{
	if (this.window.name != 'ep_main')
		window.open('default.aspx?url=' + escape(window.location.pathname), '_top');
}
