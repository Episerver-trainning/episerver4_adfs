<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpUserSettingsControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.WsrpUserSettingsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@	Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!-- "wsrp:view"-markup below -->

<asp:PlaceHolder id="mainview" runat="server">
	<div class="padding">
		<div class="tablerow" Runat="server" ID="NameRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editname" />
			</div>
			<div class="content">
				<%=	User.Name %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="DescriptionRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editdescription" />
			</div>
			<div class="content">
				<%=	User.Description %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="FirstnameRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/firstname"	/>
			</div>
			<div class="content">
				<%=	User.FirstName %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="LastnameRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/lastname" />
			</div>
			<div class="content">
				<%=	User.LastName %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="EmailRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editemail"	/>
			</div>
			<div class="content">
				<%=	User.Email %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="CompanyRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editcompany" />
			</div>
			<div class="content">
				<%=	User.Company %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="TitleRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/title"	/>
			</div>
			<div class="content">
			<%=	User.Title %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="AddressRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editaddress" />
			</div>
			<div class="content">
				<%=	User.Address %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="PostalNumberRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editpostalnumber" />
			</div>
			<div class="content">
				<%=	User.PostalNumber %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="PostalAddressRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/editpostaladdress"	/>
			</div>
			<div class="content">
				<%=	User.PostalAddress %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="TelephoneRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/edittelephone"	/>
			</div>
			<div class="content">
				<%=	User.Telephone %>&nbsp;<br>
			</div>
		</div>
		<div class="tablerow" Runat="server" ID="MobileRowView">
			<div class="description">
				<episerver:Translate Runat="server"	text="/admin/secedit/mobile" />
			</div>
			<div class="content">
				<%=	User.Mobile	%>&nbsp;<br>
			</div>
		</div>
	</div>
</asp:PlaceHolder>


<!-- "wsrp:edit"-markup below -->

<asp:PlaceHolder id="configurationview"	runat="server">
	<div class="portlet-section-header"><EPiServer:Translate Text="/templates/wsrp/common/configuration" runat="server" /></div>
	<form action="thispage.aspx" method="post">
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/usersettingscontrol/selecttitle" runat="server" /></div>
		<input class="portlet-form-input-field"	type="text"	size="40" name="thetitle" value="<%= PortletState["thetitle"] %>"><br />

		<hr />
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
					<input disabled readonly class="portlet-form-input-field" type="text"	size="30" name="Name" value="<%= User.Name %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="DescriptionRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editdescription" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="40" name="Description" value="<%= User.Description %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="FirstnameRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/firstname" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="30" name="Firstname" value="<%= User.FirstName %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="LastnameRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/lastname" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="30" name="Lastname" value="<%= User.LastName %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="EmailRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editemail" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="40" name="Email" value="<%= User.Email %>"><br />
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="CompanyRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editcompany" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="40" name="Company" value="<%= User.Company %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="TitleRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/title" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="30" name="Title" value="<%= User.Title %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="AddressRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editaddress" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="40" name="Address" value="<%= User.Address %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="PostalNumberRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editpostalnumber" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="20" name="PostalNumber" value="<%= User.PostalNumber %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="PostalAddressRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editpostaladdress" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="40" name="PostalAddress" value="<%= User.PostalAddress %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="TelephoneRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/edittelephone" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="30" name="Telephone" value="<%= User.Telephone %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="MobileRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/mobile" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="30" name="Mobile" value="<%= User.Mobile %>"><br>
				</div>
			</div>
			<div class="tablerow" Runat="server" ID="LanguageRow">
				<div class="description">
					<episerver:Translate Runat="server" text="/admin/secedit/editlanguage" />
				</div>
				<div class="content">
					<input class="portlet-form-input-field"	type="text"	size="20" name="Language" value="<%= User.Language %>"><br>
				</div>
			</div>
			<br />
			<input class="portlet-form-button" type="submit" name="submit" value=" <EPiServer:Translate Text="/templates/wsrp/rsscontrol/save" runat="server" />">

		</asp:Panel>
	</form>
</asp:PlaceHolder>