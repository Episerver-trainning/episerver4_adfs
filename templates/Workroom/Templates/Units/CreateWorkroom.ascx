<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CreateWorkroom.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.CreateWorkroom" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:panel id="EditWorkroomPanel" runat="server" CssClass="WorkroomContainer">

		<EPiServerSys:ValidationSummary id="Summary" runat="server" />

		<h2>
			<%#Translate("common/createnew")%>
		</h2>

		<p/>

		<div class="descriptionsmall">
			<%#Translate("common/name")%>:
		</div>
		<div class="content">
			<asp:TextBox Runat="server" ID="WorkroomName" CssClass="large" />
			<asp:RequiredFieldValidator ControlToValidate="WorkroomName" Runat="server" EnableClientScript="False" />
		</div>

		<br/>
		<br/>
		<br/>

		<asp:Button id="SaveButton" CssClass="WorkroomButton" OnClick="SaveButton_Click" runat="server" Text='<%#Translate("/button/save")%>'></asp:Button>
		<asp:Button id="CancelButton" CssClass="WorkroomButton" OnClick="CancelButton_Click" runat="server" Text='<%#Translate("/button/cancel")%>'></asp:Button>

</asp:panel>
