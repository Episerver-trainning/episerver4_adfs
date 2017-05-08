<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XForm.ascx.cs" Inherits="development.Templates.Units.XForm" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms"			Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>

<episerver:TranslatedValidationSummary Runat="server" />
<asp:Literal runat="server" id="PostedMessage" />
<asp:Panel Runat="server" ID="FormPanel">
	<episerver:property PropertyName="MainXForm" runat="server" ID="XFormProperty" />
</asp:Panel>
<asp:Panel Runat="server" ID="StatisticsPanel" Visible="false">
	<p>
		<asp:literal id="NumberOfVotes" runat="server" />
		<!-- Set StatisticsType to format output: N=numbers only, P=percentage -->
		<episerver:xformstatistics StatisticsType="P" runat="server" id="Statistics" PropertyName="MainXForm"  />
	</p>
</asp:Panel>
<br />
<asp:LinkButton ID="Switch" runat="server" OnClick="SwitchView" CausesValidation="False">
	<episerver:translate Text="/templates/form/showstat" runat="server" ID="Translate3" />
</asp:LinkButton>
