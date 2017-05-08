<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LinkToolbar.ascx.cs" Inherits="EPiServer.Util.LinkToolbar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type='text/javascript'>
function ConfirmedPrompt(msg,current)
{
	var clientArgs	= document.all['ClientArgument'];
	var retVal		= prompt(msg,current);
	if(retVal!=null)
	{
		clientArgs.value = retVal;
		return true;
	}
	else
		return false;
}

function HandleOnload()
{
	if (window.OnloadMessage)
		alert(window.OnloadMessage);
	window.detachEvent('onload', HandleOnload);
}

window.attachEvent('onload', HandleOnload);

</script>
<input type="hidden" id="ClientArgument" name="ClientArgument">
<div style="float:left;width:180px;" class="ToolBar">
		<asp:ImageButton CssClass="ImageButton" ImageAlign="AbsMiddle" ImageUrl="Images/icon_foldernew.gif" ID="buttonCreateFolder" Runat="server" />
		<asp:ImageButton CssClass="ImageButton" ImageAlign="AbsMiddle" ImageUrl="Images/icon_folderdelete.gif" ID="buttonDeleteFolder" Runat="server" />
		<asp:ImageButton CssClass="ImageButton" ImageAlign="AbsMiddle" ImageUrl="Images/icon_folderrename.gif" ID="buttonRenameFolder" Runat="server" />
</div>
<div style="width:100%;" class="ToolBar">
	<div style="float:left;">
		<asp:ImageButton CssClass="ImageButton" ImageAlign="AbsMiddle" ImageUrl="Images/icon_filedelete.gif" ID="buttonDeleteFile" Runat="server" />
		<asp:ImageButton CssClass="ImageButton" ImageAlign="AbsMiddle" ImageUrl="Images/icon_filerename.gif" ID="buttonRenameFile" Runat="server" />
	</div>
	<div style="text-align:right;width:100%;">
		<asp:CheckBox Runat="server"
			ID="ShowThumbnails"
			Text="Show thumbnails"
			Visible="False"
			AutoPostBack="True"
			EnableViewState="True"
			Checked="True"
			OnCheckedChanged="ShowThumbnails_CheckedChanged"
		/>
		<asp:DropDownList AutoPostback="False" ID="selectView" onchange="location.href=this.value;" runat="server"/>
	</div>
</div>
