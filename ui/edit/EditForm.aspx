<%@ Page language="c#" Codebehind="EditForm.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditForm" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" TagName="FormControl" Src="FormControl.ascx"%>
<%@ Register TagPrefix="EPiServerSys" TagName="FormToolbox" Src="FormToolbox.ascx"%>
<%@ Register TagPrefix="EPiServerSys" TagName="FormFieldProperty" Src="FormFieldProperty.ascx"%>
<%@ Import Namespace="EPiServer.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditForm</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/formedit.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<style>
		#id_matrix{
			background: white;
			color: black;
		}
		</style>		
		<script type='text/javascript'>
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		// -->
		</script>
	</head>
	<body>
		<episerversys:SystemPrefix id="SystemPrefix" runat="server" />
		
		<table>
			<tr>
				<td valign="top" colspan="2">
					<form id="EditForm" runat="server">
						<EPiServerSys:FormControl id="FormControl" runat="server" />
					</form>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td valign="top" colspan="2" class="EPEdit-columnCaption"><%= Translate("/edit/editform/placefieldsinmatrix")%></td>
			</tr>
			<tr>
				<td valign="top" style="background:white;height: 300px;width:400px" id="PlaceHolder" runat="server"></td>
				<td valign="top" class="EPEdit-tableColumn">
				<EPiServerSys:FormToolbox id="Toolbox" runat="server" />
				<EPiServerSys:FormFieldProperty id="FieldProperty" runat="server" />
				
				</td>
			</tr>
			<tr>
				<td valign="top" colspan="2">
					<table>
						<tr>
							<td><button id="id_insertrow" class="EP-largeButton" onclick="fieldInsertRow(id_matrix)"><%=Translate("/edit/editform/insertrowbutton")%></button></td>
							<td><button id="id_addrow" class="EP-largeButton" onclick="fieldAddRow(id_matrix)"><%=Translate("/edit/editform/addrowbutton")%></button></td>
							<td><button id="id_deleterow" class="EP-largeButton" onclick="fieldDeleteRow(id_matrix,'<%=TranslateForScript("/edit/editform/deleterowbutton")%>?')"><%=Translate("/edit/editform/deleterowbutton")%></button></td>
						</tr>
						<tr>
							<td><button id="id_insertcol" class="EP-largeButton" onclick="fieldInsertColumn(id_matrix)"><%=Translate("/edit/editform/insertcolumnbutton")%></button></td>
							<td><button id="id_addcol" class="EP-largeButton" onclick="fieldAddColumn(id_matrix)"><%=Translate("/edit/editform/addcolumnbutton")%></button></td>
							<td><button id="id_deletecol" class="EP-largeButton" onclick="fieldDeleteColumn(id_matrix,'<%=TranslateForScript("/edit/editform/deletecolumnbutton")%>?')"><%=Translate("/edit/editform/deletecolumnbutton")%></button></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top" colspan="2"></td>
			</tr>
		</table>
		<hr>
		<div id="id_propertieshtml" style="display: none;">
			<hr>
			<b><%= Translate("/edit/editform/htmlcode") %></b>
			<div id="id_htmlsource"></div>
		</div>
	</body>
</html> 

