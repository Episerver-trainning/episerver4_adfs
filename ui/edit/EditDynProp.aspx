<%@ Page language="c#" Codebehind="EditDynProp.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditDynProp" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditDynProp</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
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
	</head>
	<body>
		<form id="EditDynProp" method="post" runat="server">
			<EPiServerSys:systemprefix id="FormPrefix" runat="server" />
			<EPiServerSys:propertydataform EditDynamicProperties="True" AutoLoadTabs="true" runat="server" id="EditForm">
				<CaptionTemplate>
					<EPiServerSys:DynamicPropertyCaption DynamicProperty="<%#DynProp[Container.Property.Name]%>" runat="server"/>
				</CaptionTemplate>
			</EPiServerSys:propertydataform>
			<br />
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save" />
		</form>
	</body>
</html>
