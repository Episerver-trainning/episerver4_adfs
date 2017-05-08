<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.DefaultPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN">
<html>
	<head>
		<title id="title" runat="server"></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
	</head>
	
	<body scroll="no" class="EPEdit-adminBody">
		<form runat="server" id="Default">
			<EPiServer:DynamicTable runat="server" NumberOfColumns="3" CellPadding="0" CellSpacing="0" ID="DynamicTable2" KeyName="EPAdminFramework">
				<EPiServer:DynamicRow runat="server" ID="DynamicRow3" Height="40" class="EPEdit-TitleFrame">
					<EPiServer:DynamicCell runat="server" width="400" ID="DynamicCell5" Colspan="3">
						<img src="<%=Configuration.RootDir%>util/images/titleBar_logo.gif">
					</EPiServer:DynamicCell>
				</EPiServer:DynamicRow>
				<EPiServer:DynamicRow runat="server" ID="DynamicRow4">
					<EPiServer:DynamicCell runat="server" width="270px" ID="Dynamiccell1" NAME="Dynamiccell1">
						<EPiServer:DynamicTable runat="server" NumberOfColumns="1" CellPadding="0" CellSpacing="0" style="border-right:solid 1px #000000;" ID="Dynamictable1" NAME="Dynamictable1">
							<EPiServer:DynamicRow runat="server" height="32" ID="Dynamicrow1" NAME="Dynamicrow1">
								<EPiServer:DynamicCell runat="server" style="border-bottom:solid 1px #000000;" ID="Dynamiccell2" NAME="Dynamiccell2">
									<iframe name="__epCommandFrame" id="__epCommandFrame" Width="100%" Height="100%" src="AdminCommand.aspx" runat="server"></iframe>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
							<EPiServer:DynamicRow runat="server" ID="Dynamicrow2" NAME="Dynamicrow2">
								<EPiServer:DynamicCell runat="server" style="border-bottom:solid 1px #000000;" ID="Dynamiccell3" NAME="Dynamiccell3">
									<iframe name="AdminMenu" id="Tree" class="EPEdit-treeFrame" src="menu.aspx" runat="server"></iframe>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>
							<EPiServer:DynamicRow height="43" runat="server" ID="Dynamicrow5" NAME="Dynamicrow5">
								<EPiServer:DynamicCell runat="server" ID="Dynamiccell4" NAME="Dynamiccell4">
									<asp:Panel Runat="server" CssClass="EPEdit-treeBody" ID="Panel1" NAME="Panel1">
										<episerversys:licenseinfo runat="server" ID="Licenseinfo1" NAME="Licenseinfo1"/>
									</asp:Panel>
								</EPiServer:DynamicCell>
							</EPiServer:DynamicRow>						
						</EPiServer:DynamicTable>
					</EPiServer:DynamicCell>
					<EPiServer:DynamicResizeCell Width="10" CssClass="EPEdit-CustomDrag" KeyName="ResizeCell1">
					</EPiServer:DynamicResizeCell>
					<EPiServer:DynamicCell runat="server" Floating="True" ID="Dynamiccell6" NAME="Dynamiccell6">
						<iframe name="ep_main" id="InfoFrame" class="EPEdit-panelFrame" src="siteinfo.aspx" runat="server"></iframe>
					</EPiServer:DynamicCell>
				</EPiServer:DynamicRow>
			</EPiServer:DynamicTable>
		</form>	
	</body>

</html>
