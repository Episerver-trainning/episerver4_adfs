<%@ Page language="c#" Codebehind="NewPage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.NewPage" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>NewPage</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript'>
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		// -->
		</script>
	</HEAD>
	<body>
		<EPiServerSys:systemprefix id="PagePrefix" runat="server"/>
		<form id="NewPage" method="post" runat="server">
			<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/Cancel.gif"			ID="Cancel"			Name="Cancel"	Text="/button/cancel"	ToolTip="/edit/newpage/tooltipcancel" runat="server" OnClick="Cancel_Click" />
			<br />
			<br />
			<asp:DataGrid 
				id="PageTypeList" 
				AutoGenerateColumns="false" 
				runat="server"
				OnDataBinding="SetHeaders"
				CssClass="EP-tableGrid"
				HeaderStyle-CssClass="EP-tableHeadingGrid"
				ItemStyle-CssClass="EP-tableCellGrid">
				<Columns>
					<asp:BoundColumn DataField="Name" />
					<asp:BoundColumn DataField="Description" />
				</Columns>
			</asp:DataGrid>
		</form>
	</body>
</HTML>
