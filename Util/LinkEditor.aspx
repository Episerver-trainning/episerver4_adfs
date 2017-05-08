<%@ Page language="c#" Codebehind="LinkEditor.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.LinkEditor" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<META NAME="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta name="robots" content="noindex,nofollow">
		<TITLE>EPiServer Link Tool</TITLE>
	</HEAD>
	<script type='text/javascript'>
			
		var InsertImage			= 0;
		var InsertDocument		= 1;
		var InsertLink			= 2;

		function LoadLinkEditor()
		{	
			window.returnValue = 0;
		
			var qs = '<%=QueryString%>';
			var url;
			switch(window.dialogArguments & 127)
			{
				case InsertImage:
					url = '<%=EditDir%>LinkImage.aspx';
					break;
				case InsertDocument:
					url = '<%=EditDir%>LinkDocument.aspx';
					break;
				case InsertLink:
				default:
					url = '<%=EditDir%>LinkGeneric.aspx';
					break;
			
			}
			_frameWrapper.location.href = url + qs;
		}
		
	</script>
	<BODY onload="LoadLinkEditor()" bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" scroll="no" style="border:none">
		<form id="LinkEditor" method="post" runat="server">
			<iframe id="_frameWrapper" style="width:100%;height:100%" frameborder="0" scrolling="auto" src="Empty.htm">
			</iframe>
		</form>
	</BODY>
</HTML>
