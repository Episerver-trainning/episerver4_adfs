<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Form.ascx.cs" Inherits="development.Templates.Units.Form" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:Literal runat="server" id="PostedMessage" />
<asp:Panel Runat="server" ID="FormPanel">
	<episerver:property PropertyName="MainForm" runat="server" ID="FormProperty" />
</asp:Panel>
<asp:Panel Runat="server" ID="StatisticsPanel" Visible="false">
	<p>
		<asp:literal id="NumberOfVotes" runat="server" />
		<!-- Set StatisticsType to format output: N=numbers only, P=percentage -->
		<episerver:formstatistics StatisticsType="P" runat="server" id="Statistics" PropertyName="MainForm"  />
	</p>
</asp:Panel>
<br />
<asp:LinkButton ID="Switch" runat="server" OnClick="SwitchView" CausesValidation="False">
	<episerver:translate Text="/templates/form/showstat" runat="server" ID="Translate3" />
</asp:LinkButton>