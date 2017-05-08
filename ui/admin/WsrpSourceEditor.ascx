<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpSourceEditor.ascx.cs" Inherits="EPiServer.Admin.WsrpSourceEditor" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div id="_sourceeditor">
	
	<table width="100%">
		<tr>
			<td colspan="2"><asp:Label runat="server" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/sourcename") %>' id=Label1 /></td>
			<td>
				<asp:TextBox Runat="server" ID="SourceName" Size="50" />
				<asp:RequiredFieldValidator 
					Runat="server" 
					ID="RequireNameValidator"
					ControlToValidate="SourceName" 
					ErrorMessage="Must enter a source name" 
					EnableClientScript="False" Text="*" />
			</td>
		</tr>
		<tr><td colspan="3"><asp:RadioButton Runat="server" ID="UseWsdlRadio" AutoPostBack="True" OnCheckedChanged="Radio_CheckedChanged" Name="useWsdlRadio" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/usewsdlradio") %>' GroupName="type" onclick="setDisabled();" ></asp:RadioButton></td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><asp:Label runat="server" Translate="/templates/wsrpfx/admin/wsdlurl" /></td>
			<td><asp:TextBox runat="server" ID="WsdlUrl" Size="50" />
				<asp:RequiredFieldValidator 
					Runat="server" 
					ID="RequireWsdlValidator" 
					ControlToValidate="WsdlUrl" 
					ErrorMessage="Must enter a WSDL URL" 
					EnableClientScript="False" Text="*" />
			</td>
		</tr>
		<tr><td colspan="3"><asp:RadioButton Runat="server" ID="UseServicesRadio" AutoPostBack="True" OnCheckedChanged="Radio_CheckedChanged" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/useservicesradio") %>' GroupName="type" onclick="setDisabled();"></asp:RadioButton></td></tr>
		<tr><td></td>
			<td><asp:Label runat="server" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/markupurl") %>' id=Label2 /></td>
			<td>
				<asp:TextBox Runat="server" ID="MarkupUrl" Size="50" />
				<asp:RequiredFieldValidator 
					Runat="server"
					ID="RequireMarkupValidator" 
					ControlToValidate="MarkupUrl"
					ErrorMessage="Must enter a markup service URL" 
					EnableClientScript="false" Text="*" />
			</td>
		</tr>
		<tr><td></td>
			<td><asp:Label runat="server" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/servicedescriptionurl") %>' id=Label3 /></td>
			<td>
				<asp:TextBox Runat="server" ID="ServiceDescriptionUrl" Size="50" />
				<asp:RequiredFieldValidator 
					Runat="server" 
					ID="RequireServiceDescriptionValidator" 
					ControlToValidate=ServiceDescriptionUrl 
					ErrorMessage="Must enter a service description URL" 
					EnableClientScript="False" Text="*" />
			</td>
		</tr>
		<tr><td></td>
			<td><asp:Label runat="server" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/registrationurl") %>' id=Label4 /></td>
			<td>
				<asp:TextBox Runat="server" ID="RegistrationUrl" Size="50" />
			</td>
		</tr>
		<tr><td></td>
			<td><asp:Label runat="server" Text='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/admin/portletmanagementurl") %>' id=Label5 /></td>
			<td>
				<asp:TextBox Runat="server" ID="PortletManagementUrl" Size="50" />
			</td>
		</tr>
	</table>
	
	<asp:Button Runat=server Text='<%# EPiServer.Global.EPLang.Translate("/button/save") %>' OnClick="Save_Click" id=Button1></asp:Button>
	<input type=button onclick="document.all._sourceeditor.style.display='none';" value='<%= EPiServer.Global.EPLang.Translate("/button/cancel") %>' >
	<script type="text/javascript">
		function setDisabled() {
			var useWsdlRadio				= document.getElementById('<%= UseWsdlRadio.ClientID %>');
			var wsdlUrl						= document.getElementById('<%= WsdlUrl.ClientID %>');
			var markupUrl					= document.getElementById('<%= MarkupUrl.ClientID %>');
			var serviceDescriptionUrl		= document.getElementById('<%= ServiceDescriptionUrl.ClientID %>');
			var registrationUrl				= document.getElementById('<%= RegistrationUrl.ClientID %>');
			var PortletManagementUrl		= document.getElementById('<%= PortletManagementUrl.ClientID %>');
			
			wsdlUrl.disabled				= !useWsdlRadio.checked;
			
			markupUrl.disabled				= useWsdlRadio.checked;
			serviceDescriptionUrl.disabled	= useWsdlRadio.checked;
			registrationUrl.disabled		= useWsdlRadio.checked;
			PortletManagementUrl.disabled	= useWsdlRadio.checked;
		}
		
		document.body.onload = setDisabled;
	</script>
</div>
