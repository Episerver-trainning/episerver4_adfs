<%@ Page language="c#" Codebehind="Languages.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Languages" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
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
   <title><episerver:Translate runat="server" text="#header" /></title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  
  <body onkeydown="return handleKeyPressed()">
	
    <form id="Frames" method="post" runat="server">
		<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
		<p></p>
		<asp:DataGrid 
			ID="Grid"			
			Runat="server" 
			AutoGenerateColumns="False" 
			OnEditCommand="EditGrid"
			OnCancelCommand="CancelEditing"
			OnUpdateCommand="SaveGrid"
			OnPreRender="ItemCreated"
			OnDataBinding="SetHeaders"
			OnDeleteCommand="DeleteRow"			
			CssClass="EP-tableGrid"
		>
			<Columns>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#DataBinder.Eval(Container.DataItem, "ID")%>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:TextBox ID="LanguageID" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ID")%>' ></asp:TextBox>
						<asp:RequiredFieldValidator ID="RFV_LanguageID" runat="server" ControlToValidate="LanguageID">*</asp:RequiredFieldValidator>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#DataBinder.Eval(Container.DataItem, "Name")%>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:TextBox ID="Name" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>' ></asp:TextBox>
						<asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="Name">*</asp:RequiredFieldValidator>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetLocaleName((int)DataBinder.Eval(Container.DataItem, "Locale"))%>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:DropDownList Runat="server" ID="Locale" />
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:EditCommandColumn ButtonType=PushButton HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid"></asp:EditCommandColumn>
				<asp:ButtonColumn CommandName="Delete" ButtonType=PushButton HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid"></asp:ButtonColumn>
			</Columns>
		</asp:DataGrid>
		<br><asp:Button ID="AddRowButton" Runat="Server" OnClick="AddNewRow" Translate="/button/add"></asp:Button>
     </form>
  </body>
</html>
