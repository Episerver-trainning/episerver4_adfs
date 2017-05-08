<%@ Control EnableViewState="True" Language="c#" AutoEventWireup="false" Codebehind="Browse.ascx.cs" Inherits="EPiServer.Util.FileManager.Browse" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<table width="100%" cellspacing="0" id="mainTable" runat="server">
	<tr>
		<td class="FM-DirectoryToolbar">
			<asp:CheckBox Runat="server"
				ID="ShowThumbnails"
				Text="Show thumbnails"
				AutoPostBack="True"
				EnableViewState="True"
				OnCheckedChanged="ShowThumbnails_CheckedChanged"
			/>
		</td>
	</tr>
</table>
	
<div class="FM-ScrollingTableArea" id="browseArea">
	<asp:DataGrid EnableViewState="False" AllowSorting="True" AutoGenerateColumns="False" BorderWidth="0" Width="100%" Runat="server" ID="grid">
	<ItemStyle CssClass="FM-ItemRow"/>
	<Columns>
	<asp:TemplateColumn SortExpression="Name" HeaderText="/filemanager/browse/name" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle Width="50%" HorizontalAlign="Left" VerticalAlign="Middle"/>
		<ItemTemplate>
			<EPiServerSys:DragAndDropLinkButton OnLoadClick=<%#DataBinder.Eval(Container.DataItem,"IsSelectedFile")%> ImageSrc=<%#DataBinder.Eval(Container.DataItem,"ImageUrl")%> class="FM-FileLink" isFavorite=<%#DataBinder.Eval(Container.DataItem,"IsFavorite").ToString().ToLower()%> dhtmlType=<%#DataBinder.Eval(Container.DataItem,"Type")%> dhtmlPath=<%#Page.Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Path").ToString())%> Text=<%#DataBinder.Eval(Container.DataItem,"Name")%> runat="server" OnCommand="Link_Click" CommandName=<%#DataBinder.Eval(Container.DataItem,"Type")%> CommandArgument=<%#DataBinder.Eval(Container.DataItem,"Name")%>/>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn SortExpression="" HeaderText="/filemanager/browse/thumbnail" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle"/>
		<ItemTemplate>
			<EPiServer:ImageThumbnail ImageAlign="Middle" Visible=<%#DataBinder.Eval(Container.DataItem,"Type")=="File"%> ImageUrl=<%#DataBinder.Eval(Container.DataItem,"Path")%> EnablePreview="True" runat="server" />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:BoundColumn SortExpression="CheckedOutBy" HeaderText="/filemanager/browse/checkedoutby" DataField="CheckedOutBy" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	<asp:BoundColumn SortExpression="Size" HeaderText="/filemanager/browse/size" DataField="SizeString" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	<asp:BoundColumn SortExpression="Modified" HeaderText="/filemanager/browse/modified" DataField="Modified" HeaderStyle-CssClass="FM-ItemHeader">
		<ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
		<HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
	</asp:BoundColumn>
	</Columns>
	</asp:DataGrid>
	<asp:Label Text="Denna mapp är tom" runat="server" ID="FolderEmptyMessage" Visible="False" CssClass="FM-BreadCrumb" />
</div>
<asp:PlaceHolder id="multiUploadComponent" Runat="server">
	<object id="MultiUpload" VIEWASTEXT classid="clsid:10E782A8-54B3-4A8A-96A6-3E09D477EC20" width="0" height="0" VIEWASTEXT>
		<param name="Text" value="Upload files" >
		<param name="RegisterDropTargetId" value="browseArea" >
		<param name="EPiServerChunkedUpload" value="True" >
		<param name="ExpandFolders" value="True" >
		<param name="Url" value="<%=EPiServer.Global.EPConfig.HostUrl + EPiServer.Global.EPConfig.RootDir%>util/clienttools/HandleMultiUpload.aspx?dir=<%=Server.UrlEncode(CurrentFileManager.CurrentDirectory)%>" >
		<param name="AutoUpload" value="True" >
	</object>
</asp:PlaceHolder>