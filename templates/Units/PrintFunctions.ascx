<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PrintFunctions.ascx.cs" Inherits="development.Templates.Units.PrintFunctions" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<script type='text/javascript'>
<!--
function printPage() 
{
	var da = (document.all) ? 1 : 0;
	var pr = (window.print) ? 1 : 0;
	
	if(!pr)
		return;
	
	var printArea = document.getElementById("mainareadiv");
	
	if(printArea == null && da) 
		printArea = document.all.mainareadiv;
	
	if(printArea) 
	{
		var sStart = "<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"<%=Configuration.RootDir%>styles/structure.css\"><link rel=\"stylesheet\" type=\"text/css\" href=\"<%=Configuration.RootDir%>styles/editor.css\"><link rel=\"stylesheet\" type=\"text/css\" href=\"<%=Configuration.RootDir%>styles/units.css\"></head><body onload=\"javascript:window.print();\">";
		sStop = "</body></html>";

		var w = window.open('','printWin','width=650,height=440,scrollbars=yes');
		wdoc = w.document;
		wdoc.open();
		wdoc.write( sStart + printArea.innerHTML ) ;
		wdoc.writeln( sStop );
		wdoc.close();
	}
}
//-->
</script>