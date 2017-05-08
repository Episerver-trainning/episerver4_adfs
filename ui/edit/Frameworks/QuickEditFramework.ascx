<%@ Control Language="c#" AutoEventWireup="false" Codebehind="QuickEditFramework.ascx.cs" Inherits="EPiServer.Edit.QuickEditFramework" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
		<script type="text/javascript" src="<%=Configuration.RootDir%>util/javascript/edit.js"></script>
		<title runat="server" id="title"></title>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" XmlNs:EPiServer="http://schemas.episerver.com/WebControls" scroll="no" class="EPEdit-editBody">
		<form runat="server" id="Default">
			<table CellPadding="0" CellSpacing="0" width="100%" height="100%">
				<tr Height="40" class="EPEdit-TitleFrame">
					<td>
						<img src="<%=Configuration.RootDir%>Util/images/titleBar_logo.gif">
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">
						<IFrame src="<%=Configuration.RootDir + Configuration.EditDir + "EditPanel.aspx?mode=" + Request["mode"] + "&id=" + Request["id"] + "&amp;returnUrl=" + HttpContext.Current.Server.UrlEncode(Request["returnUrl"]) + "&amp;epslanguage=" + Request["epslanguage"]%>" Width="100%" Height="100%" Name="EditPanel"></IFrame>
					<td>
				</tr>
			</table>
		</form>
	</body>
</html>