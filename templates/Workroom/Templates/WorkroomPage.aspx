<%@ Page language="c#" Codebehind="WorkroomPage.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Workrooms.Templates.WorkroomPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>

<development:DefaultFramework ID="DefaultFramework" runat="server">		
	<EPiServer:Content Region="fullRegion" runat="server" ID="Content1">

		<asp:Panel runat="server" CssClass="WorkroomContainer" ID="WorkroomPanel">
			<h1>
				<EPiServer:Property PropertyName="PageName" runat="server" ID="Property1"/>
			</h1>

			<p/>
			<style type="text/css">
			.EPEdit-CommandTool
			{
				behavior:url(<%=EPiServer.Global.EPConfig.RootDir%>Util/javascript/mouseover.htc);
				margin:1px;
			}
			</style>
			<EPiServer:tabstrip id="WorkRoomTabStrip" runat="server" AutoPostBack="true" 
				TargetID="WorkRoomTabView" SupportedPlugInArea="WorkRoom" SelectedTabQueryString="SelectedWorkRoomTab">
			</EPiServer:tabstrip>

			<div id="WorkRoomTabView" runat="server">
			</div>

		</asp:panel>
	</EPiServer:Content>
</development:DefaultFramework>