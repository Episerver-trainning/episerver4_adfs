<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LanguageVersionList.ascx.cs" Inherits="EPiServer.Edit.LanguageVersionList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:datagrid 
	id="VersionList" 
	CssClass="EPEdit-pageVersionList" 
	Runat="server" 
	AutoGenerateColumns="False" 
	BorderStyle="None" 
	GridLines="None" 
	OnDataBinding="SetHeaders"
	OnItemCommand="LanguageVersionList_ItemCommand"
	OnItemDataBound="LanguageVersionList_ItemDataBound"
>
	<Columns>
		<asp:BoundColumn DataField="ID" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Version" />
		<asp:BoundColumn DataField="LanguageID" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Lang" />
		<asp:BoundColumn DataField="Name" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Name" />
		<asp:BoundColumn DataField="Status" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Status" />
		<asp:BoundColumn DataField="Saved" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Saved" />
		<asp:BoundColumn DataField="SavedBy" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Saved by" />
		<asp:ButtonColumn CommandName="selectversion" Text="/button/select" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="deleteversion" Text="/button/delete" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="publishversion" Text="/button/publish" ButtonType="PushButton" Visible="False" />
		<asp:ButtonColumn CommandName="compareversion" Text="/button/compare" ButtonType="PushButton" Visible="False" />
		<asp:ButtonColumn CommandName="delaypublishversion" Text="/button/delaypublish" ButtonType="PushButton" Visible="False" />		
		<asp:BoundColumn Visible="False" DataField="ID" />
		<asp:ButtonColumn CommandName="unpublishlanguage" Text="/button/unpublish" ButtonType="PushButton" Visible="True" />
	</Columns>
</asp:datagrid><asp:Table Runat="server" ID="CompareTable" Visible="False" Width="100%" Height="100%">
	<asp:TableRow runat="server">
		<asp:TableCell CssClass="EP-tableRow" ColumnSpan="2" Runat="server">
			<asp:Button Text="#showversionlist" Runat="server" ID="ShowVersionList" Visible="False" />
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow runat="server">
		<asp:TableCell CssClass="EP-tableHeading" Width="50%" Runat="server" ID="SelectedPageName" />
		<asp:TableCell CssClass="EP-tableHeading" Width="50%" Runat="server" ID="ComparePageName" />
	</asp:TableRow>
	<asp:TableRow runat="server">
		<asp:TableCell Width="50%" Runat="server" ID="SelectedVersionCell" />
		<asp:TableCell Width="50%" Runat="server" ID="CompareVersionCell" />
	</asp:TableRow>
</asp:Table>