<%@ Page language="c#" Codebehind="Tabs.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Tabs" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<script type='text/javascript'>
var button;
function handleKeyPressed()
{
	if(event.keyCode == 13 && event.srcElement.type != 'submit')
	{
		saveButton.click();
		return false;
	}
	return true;
}
</script>

<html>
  <head>
    <title>Edit frames</title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<LINK rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body onkeydown="return handleKeyPressed()">
	
    <form id="Tabs" method="post" runat="server">
		<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
		<p></p>
		<asp:Panel ID="TabListing" Runat="server">
			<asp:DataGrid 
				ID="Grid" 
				Runat="server" 
				AutoGenerateColumns="False" 
				OnEditCommand="EditTab"
				OnCancelCommand="CancelEditing"
				OnUpdateCommand="SaveTab"
				OnPreRender="SetButtonText"
				CssClass="EP-tableGrid"
				HeaderStyle-CssClass="EP-tableHeadingGrid"
				ItemStyle-CssClass="EP-tableCellGrid"
				OnDataBinding="SetHeaders"
			>
				<Columns>
					<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem, "Name")%>
						</ItemTemplate>
						<EditItemTemplate>
							<asp:TextBox ID="TabName" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>' ></asp:TextBox>
							<asp:RequiredFieldValidator ID="RFV_name" runat="server" ControlToValidate="TabName">*</asp:RequiredFieldValidator>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
						<ItemTemplate>
							<asp:Label Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SortIndex")%>' ID="Label1"></asp:Label>
						</ItemTemplate>
						<EditItemTemplate>
							<asp:TextBox ID="GroupOrder" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SortIndex")%>'></asp:TextBox>
							<asp:RequiredFieldValidator ID="RFV_order" runat="server" ControlToValidate="GroupOrder">*</asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="AssureNumberInput" Runat="server" ControlToValidate="GroupOrder" ErrorMessage="*" ValidationExpression="\d{1,4}"></asp:RegularExpressionValidator>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
						<ItemTemplate>
							<asp:Label Runat="server" Text='<%#GetAccessLevelName(DataBinder.Eval(Container.DataItem, "RequiredAccess"))%>'></asp:Label>
						</ItemTemplate>
						<EditItemTemplate>
							<asp:DropDownList Runat="server" ID="Access">
							</asp:DropDownList>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:EditCommandColumn ButtonType=PushButton HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid"></asp:EditCommandColumn>
					<asp:ButtonColumn CommandName="Delete" ButtonType=PushButton HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid"></asp:ButtonColumn>
				</Columns>
			</asp:DataGrid>
			<br><asp:Button ID="AddRowButton" Runat="Server" OnClick="AddNewRow" Translate="/button/add"></asp:Button>
		</asp:Panel>
		<asp:Panel Runat="server" ID="SelectReplacementTab" Visible="False">
			<asp:Repeater ID="DependentFields" Runat="server" OnPreRender="SetDependencyText">
			<ItemTemplate>
				<asp:Label Runat="server" ID="DepencencyText"></asp:Label><br />
			</ItemTemplate>
			</asp:Repeater>
			<br/>
			<p><episerver:Translate Text="/admin/saveheadings/referencedheadinghelp" runat="server" id="Translate2" /></p>
			<asp:DropDownList ID="ReplacementTab" Runat="server"></asp:DropDownList><br/>
			<asp:Button ID="ConfirmDelete" OnClick="ConfirmDeleteTab" Runat="server" Translate="/button/delete"></asp:Button>
			<asp:Button ID="Button1" Runat="server" Translate="/button/cancel"></asp:Button>
		</asp:Panel>
     </form>
  </body>
</html>
