<%@ Page language="c#" Codebehind="XFormSelect.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.XFormSelectPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerEdit" TagName="XFormSelect" Src="XFormSelect.ascx"%>
<%@ Import Namespace="EPiServer.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
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
		<table>
			<tr>
				<td valign="top" colspan="2">
					<form id="EditForm" runat="server">
						<EPiServerEdit:XFormSelect id="XFormSelect" runat="server" />
					</form>
				</td>
			</tr>
		</table>
	</body>
</html> 

