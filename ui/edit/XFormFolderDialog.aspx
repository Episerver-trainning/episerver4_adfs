<%@ Page language="c#" Codebehind="XFormFolderDialog.aspx.cs" AutoEventWireup="false" Inherits="EPiServerGUI.edit.XFormFolderDialog" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<head>
		<title><%=Title%></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name=vs_defaultClientScript content="JavaScript">
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<base target="_self">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<style>
			#inputfieldrow
			{
				width: 100%;
				margin: 10px;
			}
			#buttonrow
			{
				width: 100%;
				margin: 5px;
			}
			#inputfieldrow label
			{
				width: 150px;
			}
			#inputfieldrow input
			{
				width: 180px;
			}
		</style>
		<script type="text/javascript">
		<!--
			/* Trim() function duplicated from HtmlTextBox2_API.js */
			String.prototype.Trim = new Function("return this.replace(/^\\s+|\\s+$/g,'')");

			function save()
			{
				var newName = document.getElementById('FolderName').value.Trim();
				if (newName.length == 0 || new RegExp('[<>\"\'\/\\\\]').test(newName))
				{
					document.getElementById('FolderForm').onsubmit = launchErrorMessage;
				}
				else
				{
					returnValue = newName.Trim();
					document.getElementById('FolderForm').onsubmit = null;
				}
			}
			
			function launchErrorMessage()
			{
				alert('<%=ErrorMessage%>');
				return false;
			}
						
			function cancel()
			{
				returnValue = false;
				window.close();
			}
			
			function handleKeyPressed()
            {
	            if(event.keyCode == 13)
	            {
		            save();
	            }
	            return false;
            }
		-->
		</script>
	</head>
	<body>
		<form id="FolderForm" method="post" runat="server">
			<div id="inputfieldrow">
				<label for="FolderName"><%=Text%></label>
				<input type="text" id="FolderName" onkeydown="handleKeyPressed()" runat="server" />
			</div>
			<div id="buttonrow">
				<input type="submit" onclick="save()" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>" />			
				<input type="button" onclick="cancel()" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>" />
			</div>
		</form>
	</body>
</html>
