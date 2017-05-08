<%@ Control Language="c#" AutoEventWireup="false" Codebehind="VersionListControl.ascx.cs" Inherits="EPiServer.Edit.VersionListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />
<asp:CheckBox AutoPostBack="True" id="showAllLanguageBranches" Runat="server" Text="Show all" />
<asp:datagrid 
	id="VersionList" 
	CssClass="EPEdit-pageVersionList" 
	Runat="server" 
	AutoGenerateColumns="False" 
	BorderStyle="None" 
	GridLines="None" 
	OnDataBinding="SetHeaders"
	OnItemCommand="VersionList_ItemCommand"
>
	<Columns>
		<asp:BoundColumn DataField="ID" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Version" />
		<asp:BoundColumn DataField="LanguageBranch" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Lang" />
		<asp:BoundColumn DataField="Name" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Name" />
		<asp:BoundColumn DataField="Status" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Status" />
		<asp:BoundColumn DataField="Saved" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Saved" />
		<asp:BoundColumn DataField="SavedBy" HeaderStyle-CssClass="EP-tableHeading" HeaderText="Saved by" />
		<asp:ButtonColumn CommandName="selectversion" Text="/button/select" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="deleteversion" Text="/button/delete" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="publishversion" Text="/button/publish" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="compareversion" Text="/button/compare" ButtonType="PushButton" />
		<asp:ButtonColumn CommandName="delaypublishversion" Text="/button/delaypublish" ButtonType="PushButton" />
		<asp:BoundColumn Visible="False" DataField="ID" />
	</Columns>
</asp:datagrid><asp:Table Runat="server" ID="CompareTable" Visible="False" Width="100%" Height="100%">
	<asp:TableRow runat="server">
		<asp:TableCell CssClass="EP-tableHeadingNoBorder" ColumnSpan="2" Runat="server"><asp:Button Translate="/edit/editpanel/showversionlist" Runat="server" ID="ShowVersionList" Visible="False" OnClick="ShowVersionList_Click" /></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow runat="server">
		<asp:TableCell CssClass="EP-tableHeadingNoBorder" Width="50%" Runat="server" ID="SelectedPageName" />
		<asp:TableCell CssClass="EP-tableHeadingNoBorder" Width="50%" Runat="server" ID="ComparePageName" />
	</asp:TableRow>
	<asp:TableRow runat="server">
		<asp:TableCell Width="50%" Runat="server" ID="SelectedVersionCell" />
		<asp:TableCell Width="50%" Runat="server" ID="CompareVersionCell" />
	</asp:TableRow>
</asp:Table>
<asp:Panel Runat="server" ID="DelayPublishPanel" Visible="False">
	<p>
		<b><episerver:translate runat="server" id="DelayInfo" text="/edit/editpanel/delayinfo" /></b>
	</p>
	<episerver:translate runat="server" id="StartPubInfo" text="/edit/editpanel/delaystartpublishinfo" />
	<episerver:property runat="server" id="StartPub" propertyname="PageStartPublish" editmode="True" />
	<br>
	<episerver:translate runat="server" id="DelayedPubInfo" text="/edit/editpanel/delaypublishinfo" />
	<episerver:property runat="server" id="DelayedPub" propertyname="PageDelayedPublish" editmode="True" />
	<br>
	<asp:Button Runat="server" ID="SaveDelayPublishButton" Text="/edit/editpanel/savedelaypublishbutton" OnClick="SaveDelayPublishButton_Click" />
	<asp:Button Runat="server" ID="CancelButton" Text="/button/cancel" OnClick="CancelDelayPublishButton_Click" />
</asp:Panel>
