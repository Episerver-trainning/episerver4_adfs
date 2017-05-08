<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Settings.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.Settings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<EPiServerSys:ValidationSummary id="Summary" runat="server" />

<br/>
<asp:Panel ID="SettingsPanel" Runat="server">
</asp:Panel>
<br/>
<asp:Button Runat="server" OnClick="SaveButton_Click" Translate="/button/save" CssClass="WorkroomButton" />
<asp:Button Runat="server" OnClick="CancelButton_Click" Translate="/button/cancel" CausesValidation="False" CssClass="WorkroomButton"/>
