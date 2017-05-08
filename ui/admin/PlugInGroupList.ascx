<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PlugInGroupList.ascx.cs" Inherits="EPiServer.Admin.PlugInGroupList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type="text/javascript">

function ShowLicensingInfo(s)
{
	var oPopup = window.createPopup();
	var oPopBody = oPopup.document.body;
    oPopBody.style.backgroundColor = "lightyellow";
    oPopBody.style.border = "solid black 1px";
    oPopBody.style.padding = "5px";
    oPopBody.innerHTML = s;
    oPopup.show(0,0, 200,0);
    var realHeight = oPopBody.scrollHeight;
    oPopup.hide();
    oPopup.show(event.x,event.y,200,realHeight,document.body);
}

</script>

<br>
<asp:DataGrid
	ID="assemblyGrid"
	Runat="server"
	AutoGenerateColumns="false"
	OnDataBinding="SetHeaders"
	CssClass="EP-tableGrid"
	>
<Columns>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<a href="PlugInEdit.aspx?group=<%# Server.UrlEncode(DataBinder.Eval(Container.DataItem,"AssemblyFullName").ToString()) %>"><%# DataBinder.Eval(Container.DataItem,"AssemblyName") %></a>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<%# DataBinder.Eval(Container.DataItem,"Description") %>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<%# DataBinder.Eval(Container.DataItem,"Version") %>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<%# DataBinder.Eval(Container.DataItem,"Company") %>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<%# DataBinder.Eval(Container.DataItem,"License") %>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="EP-tableHeadingGrid">
		</HeaderStyle>
		<ItemStyle CssClass="EP-tableCellGrid">
		</ItemStyle>
		<ItemTemplate>
			<a target="_blank" href="<%# DataBinder.Eval(Container.DataItem,"MoreInfo") %>"><%# DataBinder.Eval(Container.DataItem,"MoreInfo") %></a>
		</ItemTemplate>
	</asp:TemplateColumn>
</Columns>	
</asp:DataGrid>
