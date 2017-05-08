<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Profile.ascx.cs" Inherits="development.Templates.Units.Profile" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:LinkButton ID="SaveButton" Runat="server" OnClick="SaveProfile" />
<asp:LinkButton ID="EditButton" Runat="server" OnClick="SwitchMode" />
<asp:LinkButton ID="CancelButton" Runat="server" OnClick="SwitchMode" />
<br />
<br />
<asp:Table runat="server" ID="ExtraFields">
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/editname" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="PageName" propertyname="PageName" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/firstname" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="FirstName" propertyname="FirstName" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/lastname" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="LastName" propertyname="LastName" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/editemail" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Email" propertyname="Email" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/edittelephone" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Telephone" propertyname="Telephone" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/editcompany" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Company" propertyname="Company" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/admin/secedit/title" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Title" propertyname="Title" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell VerticalAlign="Top"><episerver:Translate Text="/templates/profile/profile" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Profile" propertyname="Profile" runat="server" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><episerver:Translate Text="/templates/profile/image" runat="server" /></asp:TableCell>
		<asp:TableCell><episerver:property id="Image" propertyname="Image" runat="server" /></asp:TableCell>
	</asp:TableRow>
</asp:Table>
