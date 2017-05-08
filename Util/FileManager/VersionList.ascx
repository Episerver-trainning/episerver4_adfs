<%@ Control Language="c#" AutoEventWireup="false" Codebehind="VersionList.ascx.cs" Inherits="EPiServer.Util.FileManager.VersionList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<div class="FM-ScrollingTableArea" id="versionArea">
<asp:DataGrid EnableViewState="True" AllowSorting="True" AutoGenerateColumns="False" BorderWidth="0" Width="100%" Runat="server" ID="versionList">
	<ItemStyle CssClass="FM-ItemRow"/>
	<Columns>
	<asp:TemplateColumn SortExpression="Name" HeaderText="/filemanager/versionlist/version" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle Width="1%" HorizontalAlign="Left" VerticalAlign="Middle"/>
		<ItemTemplate>
			<%#DataBinder.Eval(Container.DataItem,"Name")%>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:BoundColumn SortExpression="Comments" HeaderText="/filemanager/versionlist/comments" DataField="Comments" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle Width="50%" HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	<asp:BoundColumn SortExpression="Size" HeaderText="/filemanager/versionlist/size" DataField="SizeString" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	<asp:BoundColumn SortExpression="CreatedBy" HeaderText="/filemanager/versionlist/createdby" DataField="CreatedBy" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	<asp:BoundColumn SortExpression="Created" HeaderText="/filemanager/versionlist/created" DataField="Created" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	</Columns>
</asp:DataGrid>
</div>
