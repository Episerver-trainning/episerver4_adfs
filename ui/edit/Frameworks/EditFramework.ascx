<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditFramework.ascx.cs" Inherits="EPiServer.Edit.EditFramework" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
		<script type="text/javascript" src="<%=Configuration.RootDir%>util/javascript/edit.js"></script>
		<script type="text/javascript">registerDefaultPage('EditPanel','EditPanel.aspx');</script>
		<title runat="server" id="title"></title>
	</head>	
	<body bgcolor="#FFFFFF" text="#000000" XmlNs:EPiServer="http://schemas.episerver.com/WebControls" scroll="no" class="EPEdit-editBody">
		<form runat="server" id="Default">
			<EPiServer:DynamicTable runat="server" NumberOfColumns="5" CellPadding="0" CellSpacing="0" ID="DynamicTable2" KeyName="EPEditFramework">
				<EPiServer:DynamicRow runat="server" ID="DynamicRow3" Height="40" class="EPEdit-TitleFrame">
					<EPiServer:DynamicCell runat="server" width="400" ID="DynamicCell5" Colspan="5">
						<img src="<%=Configuration.RootDir%>Util/images/titleBar_logo.gif">
					</EPiServer:DynamicCell>
				</EPiServer:DynamicRow>
				<EPiServer:DynamicRow runat="server" ID="DynamicRow4">
					<EPiServer:DynamicCell runat="server" width="270px">
						<EPiServer:DynamicTable runat="server" NumberOfColumns="1" CellPadding="0" CellSpacing="0" style="border-right:solid 1px #000000;">
							<EPiServer:DynamicRow ID="ToolbarRow" runat="server" height="62">
								<EPiServer:DynamicCell runat="server" style="border-bottom:solid 1px #000000;">
									<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "EditCommand.aspx?mode=" + Request["mode"] + "&id=" + Request["id"]%>" Width="100%" Height="100%" Name="EditCommand" scrolling="No"></IFrame>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
							<EPiServer:DynamicRow runat="server">
								<EPiServer:DynamicCell runat="server">
									<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "EditTree.aspx?mode=" + Request["mode"] + "&id=" + Request["id"]%>" Width="100%" Height="100%" Name="EditTree"></IFrame>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
							<EPiServer:DynamicRow height="30" ID="LanguageSelectorRow" runat="server">
								<EPiServer:DynamicCell runat="server">
									<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "LanguageSelection.aspx?mode=" + Request["mode"] + "&id=" + Request["id"]%>" Width="100%" Height="100%" Name="LanguageSelectionDropDown" scrolling="No"></IFrame>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
							<EPiServer:DynamicRow height="43" runat="server">
								<EPiServer:DynamicCell runat="server" style="border-top:solid 1px #000000;">
									<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "QuickSearch.aspx?mode=" + Request["mode"] + "&id=" + Request["id"]%>" Width="100%" Height="100%" Name="QuickSearch" scrolling="No"></IFrame>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
						</EPiServer:DynamicTable>
					</EPiServer:DynamicCell>
					<EPiServer:DynamicResizeCell Width="10" CssClass="EPEdit-CustomDrag" KeyName="ResizeCell1">
					</EPiServer:DynamicResizeCell>
					<EPiServer:DynamicCell runat="server" Floating="True">
						<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + GetWorkspaceUrl() + "?mode=" + Request["mode"] + "&id=" + ( Request["id"] != null ? Request["id"] : EPiServer.Global.EPConfig.RootPage.ID.ToString() )  + "&selectedtabname=" + Request["selectedtabname"]%>" Width="100%" Height="100%" Name="EditPanel"></IFrame>
					</EPiServer:DynamicCell>
					<EPiServer:DynamicResizeCell Width="10" CssClass="EPEdit-CustomDrag" KeyName="ResizeCell2">
					</EPiServer:DynamicResizeCell>
					<EPiServer:DynamicCell runat="server" Width="200" Expanded="False">
						<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "ActionWindowFrame.aspx?mode=" + Request["mode"] + "&id=" + Request["id"] + "&plugin=" + Request["plugin"] + "&task=" + Request["task"]%>" Width="100%" Height="100%" Name="epCustomDIV"></IFrame>
					</EPiServer:DynamicCell>
				</EPiServer:DynamicRow>
			</EPiServer:DynamicTable>
		</form>
	</body>
</html>
