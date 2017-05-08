<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PdfForm.ascx.cs" Inherits="development.Templates.Units.PdfFormView" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Panel Runat="server" ID="SelectDocumentArea">
	<episerver:PageList Runat="server" ID="SelectDocumentList">
		<HeaderTemplate>
			<table border="0" width="100%" cellpadding="4" style="border-collapse:collapse;">
		</HeaderTemplate>
		<ItemTemplate>
			<tr>				
				<td>
					<episerver:Property Runat="server" PropertyName="PageLink" />
				</td>
				<td>
					<episerver:Property Runat="server" PropertyName="MainIntro" />
				</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate>
			</table>
		</FooterTemplate>
	</episerver:PageList>
</asp:Panel>
<asp:Panel Runat="server" ID="CreateFormArea">
	<asp:Datagrid 
			Runat="Server" 
			ID="DocumentFields"
			AutoGenerateColumns="False"
			ShowHeader="False" 
			BorderWidth="0"
			BorderColor="#ffffff"
			CellPadding="4">
		<Columns>
			<asp:TemplateColumn>
				<ItemTemplate><asp:label Runat="Server" Text='<%#DataBinder.Eval(Container.DataItem,"FieldName")%>' /></ItemTemplate>
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate><asp:textbox Runat="Server" /></ItemTemplate>
			</asp:TemplateColumn>
		</Columns>
	</asp:datagrid>
	<asp:button style="margin-top: 5px;" Runat="Server" ID="CreatePdf" Translate="/button/create" OnClick="Create_Click" />
</asp:Panel>