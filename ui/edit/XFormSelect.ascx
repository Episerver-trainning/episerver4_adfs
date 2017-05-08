<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XFormSelect.ascx.cs" Inherits="EPiServer.Edit.XFormSelect" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="EPiServer.Core" %>

<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<script type="text/javascript">
<!--
var KEYCODE_C = 67;

window.document.attachEvent('onkeydown', xFormKeyHandler);
window.document.body.focus();

window.attachEvent('onload', initialize);
var folderDialogUrl = '<%=EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir%>' + 'XFormFolderDialog.aspx';

function xFormKeyHandler()
{
	var returnValue = true;	

	if (event.shiftKey && event.ctrlKey)
	{
		switch (event.keyCode)
		{
			case KEYCODE_C:
				var formId = document.getElementById('<%=SelectedFormID.ClientID%>').value;
				if (confirm("Copy xform id to clipboard?\n\n" + formId))
					clipboardData.setData("Text", formId);
				break;
		}
	}
	return returnValue;
}

function editForm(useSelected)
{
	var editUrl = 'EditXFormFrame.aspx?pageId=<%=Request["pageId"]%>&parentId=<%=Request["parentId"]%>&formid=';
	if(useSelected)
		editUrl = editUrl + document.getElementById('<%=AvailableXForms.ClientID%>').value;
	formid = window.showModalDialog(editUrl,4,'status:no; resizable:yes; help:no; dialogWidth:800px; dialogHeight:800px; center:yes;scroll:auto;');
	if(formid == null)
		return false;
	var selectedForm = document.getElementById('<%=SelectedFormID.ClientID%>');
	selectedForm.value = formid;
	document.getElementById('<%=SelectFormButton.ClientID%>').click();
}

function selectAndClose(returnValue)
{
	window.parent.returnValue = returnValue;
	window.parent.close();
}
function selectForm()
{
	var selectedFormID = document.getElementById('<%=SelectedFormID.ClientID%>').value;
	var selectedFormName = document.getElementById('<%=SelectedFormName.ClientID%>').value;
	
	if(selectedFormID)
		selectAndClose(selectedFormID + '____' + selectedFormName);
	else
		selectAndClose('');
}
function formIsSelected()
{
	return document.getElementById('<%=SelectedFormID.ClientID%>').value;
}

function initialize()
{
	var newFolderButton = document.getElementById('newFolderButton');
	var renameFolderButton = document.getElementById('renameFolderButton');
	var deleteFolderButton = document.getElementById('deleteFolderButton');
	
	if('<%= NewFolderEnabled %>' == 'True')
	{
		newFolderButton.disabled	= false;
		newFolderButton.src			= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/newfolder_off.gif';
	}
	else
	{
		newFolderButton.disabled	= true;
		newFolderButton.src			= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/newfolder_disabled.gif';
	}
	
	if('<%= RenameFolderEnabled %>' == 'True')
	{
		renameFolderButton.disabled	= false;
		renameFolderButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/rename_off.gif';
	}
	else
	{
		renameFolderButton.disabled	= true;
		renameFolderButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/rename_disabled.gif';
	}
	
	if('<%= DeleteFolderEnabled %>' == 'True')
	{
		deleteFolderButton.disabled	= false;
		deleteFolderButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/delete_off.gif';
	}
	else
	{
		deleteFolderButton.disabled	= true;
		deleteFolderButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/delete_disabled.gif';
	}

	setImageButtonBehaviour(newFolderButton);
	setImageButtonBehaviour(renameFolderButton);
	setImageButtonBehaviour(deleteFolderButton);
}

function setImageButtonBehaviour(img)
{
	img.onmouseover = setImageSrc;
	img.onmousedown = setImageSrc;
	img.onmouseout	= setImageSrc;
	img.onmouseup	= setImageSrc;
}

function setImageSrc()
{
	if (event.srcElement.disabled)
		return;
		
	switch (event.type)
	{
		case 'mouseover':
			event.srcElement.src = event.srcElement.src.substring(0, event.srcElement.src.lastIndexOf('_')) + '_over.gif';
			break;
		case 'mousedown':
			event.srcElement.src = event.srcElement.src.substring(0, event.srcElement.src.lastIndexOf('_')) + '_selected.gif';			
			break;
		case 'mouseout':
			event.srcElement.src = event.srcElement.src.substring(0, event.srcElement.src.lastIndexOf('_')) + '_off.gif';			
			break;
		case 'mouseup':
			event.srcElement.src = event.srcElement.src.substring(0, event.srcElement.src.lastIndexOf('_')) + '_over.gif';			
			break;
	}
}

function LaunchNewFolderWindow()
{
	var folderList = document.getElementById('<%= FormFolders.UniqueID %>');
	var returnValue = OpenDialog(folderDialogUrl + '?mode=create', null, 370, 125);

	if(returnValue != null && returnValue != 0)
	{
		document.getElementById('<%=NewFolderName.ClientID%>').value = returnValue;
		document.forms[0].submit();
	}
}

function LaunchRenameFolderWindow()
{
	var folderList = document.getElementById('<%= FormFolders.UniqueID %>');
	var selectedFolder = folderList.options[folderList.selectedIndex].value;
	var returnValue = OpenDialog(folderDialogUrl + '?mode=rename', selectedFolder, 370, 125);

	if(returnValue != null && returnValue != 0)
	{
		document.getElementById('<%=RenameFolder.ClientID%>').value = selectedFolder;
		document.getElementById('<%=NewFolderName.ClientID%>').value = returnValue;
		document.forms[0].submit();
	}
}

function LaunchDeleteFolderWindow()
{
	var folderList = document.getElementById('<%= FormFolders.UniqueID %>');
	var selectedFolder = folderList.options[folderList.selectedIndex].value;

	if (confirm('<%=EPiServer.Global.EPLang.Translate("/edit/editxform/folderdialog/deletequestion")%>'))
	{
		document.getElementById('<%=DeleteFolder.ClientID%>').value = selectedFolder;
		document.forms[0].submit();
	}
}

-->
</script>
<table class="EditPage" cellspacing="10" cellpadding="0" width="100%">
	<tr>
		<td>
			<asp:Label Runat="server" Width="145px"><episerver:translate runat="server" text="/edit/editxform/folder" /></asp:Label>
			<asp:ListBox ID="FormFolders" 
				Runat="server" 
				AutoPostBack="True" 
				Rows="1" 
				Width="150px" />
		</td>
		<td>
			<img id="newFolderButton" onclick="LaunchNewFolderWindow()" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/newfolder_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/createnewformfoldertooltip")%>">
			<img id="renameFolderButton" onclick="LaunchRenameFolderWindow()" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/rename_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/renameformfoldertooltip")%>">
			<img id="deleteFolderButton" onclick="LaunchDeleteFolderWindow()" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/XForm/Tools/delete_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/deleteformfoldertooltip")%>">
		</td>
	</tr>
	<tr>
		<td>
			<asp:ListBox id="AvailableXForms" 
				Rows="18"
				Width="300px"
				SelectionMode="Single" 
				AutoPostBack="True"
				runat="server" />
		</td>
		<td valign="top">
			<asp:PlaceHolder ID="FormData" Runat="server" Visible="False">
				<table cellpadding="0" width="100%">
					<tr>
						<td valign="top">
							<table>
								<tr>
									<td colspan="2">
										<b><episerver:translate runat="server" text="/edit/editxform/forminformation" /></b>
									</td>
								</tr>
								<tr>
									<td>
										<episerver:translate runat="server" text="/edit/editxform/folder" />:&nbsp;
									</td>
									<td>
										<% =Folder %>
									</td>	
								</tr>
								<tr>
									<td>
										<episerver:translate runat="server" text="/edit/editxform/createdby" />&nbsp;
									</td>
									<td>
										<% =CreatedBy %>
									</td>	
								</tr>
								<tr>
									<td>
										<episerver:translate runat="server" text="/edit/editxform/created" />&nbsp;
									</td>
									<td>
										<% =Created %>
									</td>	
								</tr>
								<tr>
									<td>
										<episerver:translate runat="server" text="/edit/editxform/changedby" />&nbsp;
									</td>
									<td>
										<% =ChangedBy %>
									</td>	
								</tr>
								<tr>
									<td>
										<episerver:translate runat="server" text="/edit/editxform/changed" />&nbsp;
									</td>
									<td>
										<% =Changed %>	
									</td>	
								</tr>
								<tr>
									<td colspan="2">
										<br />
										<asp:Literal Runat="server" ID="FormUsedOnPageInfo" /><br />
										<EPiServer:PageList Runat="server" ID="FormReferences">
											<ItemTemplate>
												<episerver:Property PropertyName="PageName" Runat="server" />
												[<%#Container.CurrentPage.PageLink.ID%>]<br />
											</ItemTemplate>
										</EPiServer:PageList>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</asp:PlaceHolder>
		</td>
	</tr>
	<tr>
		<td colspan="2"><br />
			<input type="button" onclick="selectForm()" <%=SelectedFormID.Value == String.Empty ? "disabled" : ""%> value="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/useformbutton")%>" />			
			<input type="button" onclick="editForm(true)" <%=SelectedFormID.Value == String.Empty ? "disabled" : ""%> value="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/editformbutton")%>" />
			<input type="button" onclick="editForm(false)" value="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/createformbutton")%>" />
			<input type="button" onclick="selectAndClose('')" value="<%=EPiServer.Global.EPLang.Translate("/edit/editxform/noformbutton")%>" />
			<input type="button" onclick="selectAndClose(null)" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>" />
			<asp:Button Runat="server" OnClick="DeleteForm_Click" ID="DeleteButton" />
			<asp:Button Runat="Server" OnClick="SelectForm_Click" ID="SelectFormButton" CssClass="hidden" />
		</td>
	</tr>
</table>
<input type="hidden" runat="Server" ID="SelectedFormID" />
<input type="hidden" runat="Server" ID="SelectedFormName" />
<input type="hidden" runat="Server" ID="RenameFolder" />
<input type="hidden" runat="Server" ID="NewFolderName" />
<input type="hidden" runat="Server" ID="DeleteFolder" />
