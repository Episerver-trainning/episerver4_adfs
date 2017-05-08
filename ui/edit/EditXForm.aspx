<%@ Page language="c#" Codebehind="EditXForm.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditXForm" %>
<%@ Register TagPrefix="EPiServer"		Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms"			Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>
<%@ Register TagPrefix="EPiServerSys"	Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys"	TagName="XFormToolbox" Src="XFormToolbox.ascx"%>
<%@ Register TagPrefix="EPiServerSys"	TagName="XFormFieldProperty" Src="XFormFieldProperty.ascx"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/xformedit.js"></script>
		<asp:literal Runat="server" ID="CssPath" />
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/xformedit.css" />	
        <link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
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
		function handleKeyPressed()
		{
			if(event.keyCode == 13 && !(event.srcElement.type == 'submit' || event.srcElement.type == 'textarea'))
			{
				event.cancelBubble = true;
				return false;
			}
			return true;
		}
		// -->
		</script>
	</head>
	<body onkeydown="return handleKeyPressed()">
		<form id="EditForm" runat="server">
			<asp:PlaceHolder ID="ErrorMsg" Visible="False" Runat="server" />
			<table cellspacing="5">
				<tr>
					<td valign="top" colspan="2">
						<input type="hidden" name="__formcontent" id="FormContent" />
						<EPiServerSys:HelpButton Runat="server" 
							ID="HelpButton"
							NavigateUrl="EditXForm.htm" />
						<table class="EditPage" cellspacing="1" cellpadding="0" width="100%">
							<tr>
								<td><EPiServer:Translate text="/edit/editform/formnamecaption"  runat="server"/></td>
								<td>
									<asp:TextBox type="text" ID="FormName" runat="server" />
								</td>
							</tr>
							<tr>
								<td><EPiServer:Translate text="/edit/editxform/formfoldercaption"  runat="server" ID="Translate2"/></td>
								<td>
									<asp:ListBox ID="FormFolders" Runat="server" Rows="1" />
								</td>
							</tr>
							<tr>
								<td><EPiServer:Translate text="/edit/editform/allowanonymouspostcaption" runat="server" /></td>
								<td><asp:CheckBox id="FormAnonymousPost" runat="server" /></td>
							</tr>
							<tr>
								<td><EPiServer:Translate text="/edit/editform/allowmultiplepostcaption" runat="server" /></td>
								<td><asp:CheckBox id="FormMultiplePost" runat="server" /></td>
							</tr>
							<tr id="__cellpageafterpost" runat="server">
								<td><EPiServer:Translate text="/edit/editform/pageafterpost" runat="server" /></td>
								<td><EPiServer:InputPageReference id="FormPageAfterPost" runat="server" /></td>
							</tr>
							<tr>
								<td colspan="2"><br>
									<input type="submit" translate="/button/save" onclick="if(formValid())formPopulateForSubmit(this.form);" runat="server" ID="SaveButton" />
									<input type="submit" translate="/edit/editxform/saveas" onclick="if(formValid())formPopulateForSubmit(this.form);" runat="server" ID="SaveAsButton" />
									<input type="submit" CausesValidation="False" translate="/button/delete" ID="DeleteButton" runat="server" />
									<input type="submit" CausesValidation="False" translate="/button/cancel" ID="CancelButton" runat="server" />
								</td>
							</tr>
						</table>				
					</td>
				</tr>
			</table>
			<table cellspacing="5">
				<tr>
					<td valign="top" colspan="2" class="EPEdit-columnCaption"><%=Translate("/edit/editform/placefieldsinmatrix")%></td>
				</tr>
				<tr>
					<td valign="top" class="editarea">
						<span name="xformcontrol" onclick="fieldProperties()" ID="FormControl">
							<XForms:XFormControl Runat="Server" ID="FormControl" EditMode="True" />
							<asp:Literal Runat="server" ID="NewFormContent" />
						</span>
					</td>
					<td valign="top">
						<EPiServerSys:XFormToolbox id="Toolbox" runat="server" />
						<EPiServerSys:XFormFieldProperty id="FieldProperty" runat="server" />
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
						<table>
							<tr>
								<td><button id="id_insertrow" onclick="fieldInsertRow(id_matrix)"><%=TranslateForScript("/edit/editform/insertrowbutton")%></button></td>
								<td><button id="id_addrow" onclick="fieldAddRow(id_matrix)"><%=TranslateForScript("/edit/editform/addrowbutton")%></button></td>
								<td><button id="id_deleterow" onclick="fieldDeleteRow(id_matrix,'<%=TranslateForScript("/edit/editform/deleterowbutton")%>?')"><%=Translate("/edit/editform/deleterowbutton")%></button></td>
							</tr>
							<tr>
								<td><button id="id_insertcol" onclick="fieldInsertColumn(id_matrix)"><%=TranslateForScript("/edit/editform/insertcolumnbutton")%></button></td>
								<td><button id="id_addcol" onclick="fieldAddColumn(id_matrix)"><%=TranslateForScript("/edit/editform/addcolumnbutton")%></button></td>
								<td><button id="id_deletecol" onclick="fieldDeleteColumn(id_matrix,'<%=TranslateForScript("/edit/editform/deletecolumnbutton")%>?')"><%=Translate("/edit/editform/deletecolumnbutton")%></button></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>