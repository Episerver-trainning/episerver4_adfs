<%@ Page language="c#" Codebehind="Categories.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Categories" %>
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
    <title>Edit Categories</title>
    <script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
  </head>
  <body onkeydown="return handleKeyPressed()">
	<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
	<p></p>
    <form id="Categories" method="post" runat="server">
		<asp:DataGrid 
			ID="Grid" 
			Runat="server"
			AutoGenerateColumns="false"
			OnPreRender="PreRendering"
			OnDataBinding="SetHeaders"
			OnEditCommand="Edit_Clicked"
			OnCancelCommand="CancelEditing"
			OnUpdateCommand="Save_Click"
			OnItemCommand="HandleButtons"
			CssClass="EP-tableGrid"
			>
			<Columns>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeadingGrid">
					</HeaderStyle>
					<ItemStyle CssClass="EP-tableCellGrid">
					</ItemStyle>
					<ItemTemplate>
						<nobr>
							<img src="<%=Configuration.RootDir%>images/os.gif" width='<%#((int)DataBinder.Eval(Container.DataItem, "Indent"))*15%>' height="5" runat="server"/>
							<%#DataBinder.Eval(Container.DataItem, "Name")%>
						</nobr>
					</ItemTemplate>
					<EditItemTemplate>
						<img src="<%=Configuration.RootDir%>images/os.gif" width='<%#((int)DataBinder.Eval(Container.DataItem, "Indent"))*15%>' height="5" runat="server"/>
						<asp:TextBox ID="CategoryName" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>' ></asp:TextBox>
						<asp:RequiredFieldValidator ID="RFV_name" runat="server" ControlToValidate="CategoryName">*</asp:RequiredFieldValidator>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle Width=300 CssClass="EP-tableHeadingGrid">
					</HeaderStyle>
					<ItemStyle Width=300 CssClass="EP-tableCellGrid"/>
					<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem, "Description")%>
					</ItemTemplate>
					<EditItemTemplate>
							<img src="<%=Configuration.RootDir%>images/os.gif" width=1 height="5" runat="server" ID="Img2"/>
						<asp:TextBox Columns="60" ID="CategoryDescription" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Description")%>' ></asp:TextBox>
						<asp:RequiredFieldValidator runat="server" ControlToValidate="CategoryDescription">*</asp:RequiredFieldValidator>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeadingGrid">
					</HeaderStyle>
					<ItemTemplate>
						<%#(bool)DataBinder.Eval(Container.DataItem, "Available") ? "x" : ""%>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:CheckBox runat="server" Checked='<%#(bool)DataBinder.Eval(Container.DataItem, "Available") ? true : false%>'></asp:CheckBox>
					</EditItemTemplate>			
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeadingGrid">
					</HeaderStyle>
					<ItemTemplate>
						<%#(bool)DataBinder.Eval(Container.DataItem, "Selectable") ? "x" : ""%>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:CheckBox runat="server" Checked='<%#(bool)DataBinder.Eval(Container.DataItem, "Selectable") ? true : false%>'></asp:CheckBox>
					</EditItemTemplate>					
				</asp:TemplateColumn>
			</Columns>
		</asp:DataGrid>
		<br />
		<asp:Button Runat="server" ID="AddRootCategory" OnClick="InsertRootCategory" Translate="/button/add"></asp:Button>
		<p>
			<img src="<%=Configuration.RootDir%>util/images/UpToolSmall.gif" border="0">
			<episerver:Translate Text="#helpmoveup" runat="server" />
			<br/>
			<img src="<%=Configuration.RootDir%>util/images/DownToolSmall.gif" border="0">
			<episerver:Translate Text="#helpmovedown" runat="server"  />
			<br/>
			<img src="<%=Configuration.RootDir%>util/images/AddToolSmall.gif" border="0">
			<episerver:Translate Text="#helpadd" runat="server" />
			<br/>
			<img src="<%=Configuration.RootDir%>util/images/DelToolSmall.gif" border="0">
			<episerver:Translate Text="#helpdelete" runat="server" />
		</p>
     </form>
  </body>
</html>
