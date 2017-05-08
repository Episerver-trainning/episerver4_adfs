<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PersonalSettings.ascx.cs" Inherits="development.Templates.Units.PersonalSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:Panel Runat="server" ID="SaveFailed" Visible="false">
	<h3><episerver:translate Text="/templates/register/couldnotsave" runat="server" /></h3>
	<asp:Label ID="ErrorMessage" Runat="server" />
</asp:Panel>
<asp:Panel Runat="server" ID="SaveSucceded" Visible="false">
	<h3><episerver:translate Text="/admin/edituser/usersaved" runat="server" /></h3>
	<asp:Label ID="SavedMessage" Runat="server" />
</asp:Panel>
<asp:Panel Runat="server" ID="DenyRegistring" Visible="false">
	<h3><episerver:translate Text="/templates/register/notallowed" runat="server" /></h3>
</asp:Panel>
<asp:Panel Runat="server" ID="CreateEditUser">
	<div class="tablerow" Runat="server" ID="NameRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editname" />
		</div>
		<div class="content">
			<asp:TextBox ID="Name" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="PasswordRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editpassword" />
		</div>
		<div class="content">
			<episerver:inputpassword ID="Password" Runat="server" InputCssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="DescriptionRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editdescription" />
		</div>
		<div class="content">
			<asp:TextBox ID="Description" Runat="server" CssClass="registerfield" />	
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="FirstnameRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/firstname" />
		</div>
		<div class="content">
			<asp:TextBox ID="Firstname" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="LastnameRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/lastname" />
		</div>
		<div class="content">
			<asp:TextBox ID="Lastname" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="EmailRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editemail" />
		</div>
		<div class="content">
			<asp:TextBox ID="Email" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="CompanyRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editcompany" />
		</div>
		<div class="content">
			<asp:TextBox ID="Company" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="TitleRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/title" />
		</div>
		<div class="content">
			<asp:TextBox ID="Title" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="AddressRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editaddress" />
		</div>
		<div class="content">
			<asp:TextBox ID="Address" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="PostalNumberRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editpostalnumber" />
		</div>
		<div class="content">
			<asp:TextBox ID="PostalNumber" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="PostalAddressRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editpostaladdress" />
		</div>
		<div class="content">
			<asp:TextBox ID="PostalAddress" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="TelephoneRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/edittelephone" />
		</div>
		<div class="content">
			<asp:TextBox ID="Telephone" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="MobileRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/mobile" />
		</div>
		<div class="content">
			<asp:TextBox ID="Mobile" Runat="server" CssClass="registerfield" />
		</div>
	</div>
	<div class="tablerow" Runat="server" ID="LanguageRow">
		<div class="description">
			<episerver:Translate Runat="server" text="/admin/secedit/editlanguage" />
		</div>
		<div class="content">
			<EPiServer:InputLanguage Runat="server" ID="Language" CssClass="registerfield" />
		</div>
	</div>
	<br />
	<asp:Button id="ApplyButton" Runat="server" translate="/button/save" OnClick="ApplyButton_Click" />
</asp:Panel>