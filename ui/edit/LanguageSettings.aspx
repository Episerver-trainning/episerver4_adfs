<%@ Page language="c#" Codebehind="LanguageSettings.aspx.cs" AutoEventWireup="false" Inherits="EPiServerGUI.Edit.LanguageSettings" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Language Settings</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js"></script>
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
	
	function PageDeleted(id, navId)
	{
		if(window.parent)
		{
			var cmd = new commandNavigateDescriptorEx('pagedeleted','',id,navId);
			window.parent.commandEvent( window, cmd );
		}
	}
	// -->
	</script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="Form1" method="post" runat="server">
		<episerversys:systemprefix runat="server" id="pagePrefix" />
		
		<p>
			<asp:CheckBox Checked="True" AutoPostBack="True" OnCheckedChanged="InheritChanged" ID="inheritSettings" Text="Inherit" Runat="server"></asp:CheckBox>
		</p>
		
		<fieldset style="padding: 10px">
			<legend><EPiServer:Translate Text="#availablelanguagestitle" runat="server" /></legend>
			<p>
				<EPiServer:Translate Text="#availablelanguagesdescriptionfirst" runat="server" ID="Translate1" NAME="Translate1"/>
				<EPiServer:Translate Text="#availablelanguagesdescriptionsecond" runat="server" ID="Translate6" NAME="Translate1"/>
			</p>
			<asp:Panel ID="availableLanguagesView" Runat="server">
					<ul>
						<asp:Repeater ID="availableLanguagesList" Runat="server">
							<ItemTemplate>
								<li><%#GetBranchName(DataBinder.Eval(Container.DataItem,"LanguageBranch"))%></li>
							</ItemTemplate>
						</asp:Repeater>
					</ul>
					<asp:Button OnClick="ChangeAvailableLanguages" ID="availableEditButton" Translate="/button/change" Text="Change" Runat="server"></asp:Button>
			</asp:Panel>
			<asp:Panel Visible="False" ID="availableLanguagesEdit" Runat="server">
					<asp:CheckBoxList RepeatColumns="3" Runat="server" ID="availableLanguages"/>
					<br />
					<asp:Button Runat="server" Translate="/button/save" OnClick="SaveAvailableLanguages" Text="Save"></asp:Button>
					<asp:Button Runat="server" Translate="/button/cancel" Text="Cancel" OnClick="CancelSave"></asp:Button>
			</asp:Panel>
		</fieldset>
		<br />
		<fieldset style="padding: 10px">
			<legend><EPiServer:Translate Text="#replacementlanguagestitle" runat="server" ID="Translate2" NAME="Translate1"/></legend>
			<p>
				<EPiServer:Translate Text="#replacementlanguagesdescriptionfirst" runat="server" ID="Translate3" NAME="Translate1"/>
				<EPiServer:Translate Text="#replacementlanguagesdescriptionsecond" runat="server" ID="Translate7" NAME="Translate1"/>
			</p>
			<asp:Panel ID="replacementLanguagesView" Runat="server">
					<ul>
						<asp:Repeater ID="replacementLanguagesList" Runat="server">
							<ItemTemplate>
								<li><%#GetBranchName(DataBinder.Eval(Container.DataItem,"LanguageBranch"))%> > <%#GetBranchName(DataBinder.Eval(Container.DataItem,"ReplacementLanguageBranch"))%></li>
							</ItemTemplate>
						</asp:Repeater>
					</ul>
					<asp:Button OnClick="ChangeReplacementLanguages" ID="replacementEditButton" Translate="/button/change" Text="Change" Runat="server"></asp:Button>
			</asp:Panel>
			<asp:Panel Visible="False" ID="replacementLanguagesEdit" Runat="server">
					<table cellpadding="2">
						<asp:Repeater ID="replacementLanguages" Runat="server">
							<HeaderTemplate>
								<tr>
									<td>
										<b><EPiServer:Translate Text="#visitorlanguageheading" runat="server" ID="Translate11" NAME="Translate1"/></b>
									</td>
									<td>
										<b><EPiServer:Translate Text="#replacementlanguageheading" runat="server" ID="Translate12" NAME="Translate1"/></b>
									</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr>
									<td><%#GetBranchName(DataBinder.Eval(Container.DataItem,"LanguageID"))%></td>
									<td>
										<%#SetupLanguageDropDown((string)DataBinder.Eval(Container.DataItem,"LanguageID"))%>
									</td>
								</tr>
							</ItemTemplate>
						</asp:Repeater>
					</table>
					<br />
					<asp:Button Runat="server" Translate="/button/save" OnClick="SaveReplacementLanguages" Text="Save" ID="Button2" NAME="Button2"></asp:Button>
					<asp:Button Runat="server" Translate="/button/cancel" Text="Cancel" OnClick="CancelSave" ID="Button1" NAME="Button1"></asp:Button>
			</asp:Panel>
		</fieldset>
		<br />
		<fieldset style="padding: 10px">
			<legend><EPiServer:Translate Text="#fallbacklanguagestitle" runat="server" ID="Translate4" NAME="Translate1"/></legend>
			<p>
				<EPiServer:Translate Text="#fallbacklanguagesdescriptionfirst" runat="server" ID="Translate5" NAME="Translate1"/>
				<EPiServer:Translate Text="#fallbacklanguagesdescriptionsecond" runat="server" ID="Translate8" NAME="Translate1"/>
			</p>
			<asp:Panel ID="fallbackLanguagesView" Runat="server">
					<ul>
						<asp:Repeater ID="fallbackLanguagesList" Runat="server">
							<ItemTemplate>
								<li><%#RenderFallbackList(Container.DataItem)%></li>
							</ItemTemplate>
						</asp:Repeater>
					</ul>
					<asp:Button OnClick="ChangeFallbackLanguages"  ID="fallbackEditButton" Translate="/button/change" Text="Change" Runat="server"></asp:Button>
			</asp:Panel>
			<asp:Panel Visible="False" ID="fallbackLanguagesEdit" Runat="server">
					<table cellpadding="5">
						<asp:Repeater ID="fallbackLanguages" Runat="server">
							<HeaderTemplate>
								<tr>
									<td>
										<b><EPiServer:Translate Text="#visitorlanguageheading" runat="server" ID="Translate9" NAME="Translate1"/></b>
									</td>
									<%#RenderEmptyFallbackColumns()%>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr>
									<td><%#GetBranchName(DataBinder.Eval(Container.DataItem,"LanguageBranch"))%></td>
									<%#RenderFallbackColumns(Container.DataItem)%>
								</tr>
							</ItemTemplate>
						</asp:Repeater>
					</table>
					<br />
					<asp:Button Runat="server" OnClick="SaveFallbackLanguages" Text="Save" Translate="/button/save" ID="Button4" NAME="Button2"></asp:Button>
					<asp:Button Runat="server" Text="Cancel" OnClick="CancelSave" ID="Button3" Translate="/button/cancel" NAME="Button3"></asp:Button>
			</asp:Panel>
		</fieldset>

     </form>
	
  </body>
</html>
