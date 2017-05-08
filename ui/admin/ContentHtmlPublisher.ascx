<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ContentHtmlPublisher.ascx.cs" Inherits="EPiServer.Admin.ContentHtmlPublisher" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#targetdirectory" runat="server" ID="Translate3"/>
	</td>
	<td>
		<asp:TextBox ID="TargetDirectory" Runat="server"></asp:TextBox>
		<asp:RequiredFieldValidator ID="RequiredNameCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="TargetDirectory"
					EnableClientScript = "True"
					Runat="server"/>
		<asp:CustomValidator ID="ValidateTargetDir" Display="Static" Runat="server" Text="*" OnServerValidate="OnValidateTargetDir" ControlToValidate="TargetDirectory"/>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#rootdir" runat="server" ID="Translate5"/>
	</td>
	<td>
		<asp:TextBox Text="/" ID="RootDir" Runat="server"></asp:TextBox>
		<asp:RequiredFieldValidator ID="Requiredfieldvalidator1"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="RootDir"
					EnableClientScript = "True"
					Runat="server"/>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#defaultdocument" runat="server" ID="Translate2"/>
	</td>
	<td>
		<asp:TextBox Text="Default.htm" ID="DefaultDocument" Runat="server"></asp:TextBox>
		<asp:RequiredFieldValidator ID="Requiredfieldvalidator2"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="DefaultDocument"
					EnableClientScript = "True"
					Runat="server"/>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#pathnameproperty" runat="server" ID="Translate6"/>
	</td>
	<td>
		<asp:TextBox ID="PathNameProperty" Text="PageName" Runat="server"></asp:TextBox>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#verifychecksum" runat="server" ID="Translate1"/>
	</td>
	<td>
		<asp:CheckBox ID="VerifyChecksum" Checked="True" Runat="server"></asp:CheckBox>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#usedirectoryweblinks" runat="server" ID="Translate4"/>
	</td>
	<td>
		<asp:CheckBox ID="UseDirectoryWebLinks" Checked="True" Runat="server"></asp:CheckBox>
	</td>
</tr>
<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#applyfilterontemplates" runat="server" ID="Translate7"/>
	</td>
	<td>
		<asp:CheckBox ID="ApplyFilterOnTemplates" Checked="True" Runat="server"></asp:CheckBox>
	</td>
</tr>
