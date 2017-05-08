<%@ Page language="c#" Codebehind="ConflictEditor.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.ConflictEditor" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>ConflictEditor</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
	<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js" type="text/javascript"></script>
  </head>
  <body MS_POSITIONING="FlowLayout">
	
    <form id="Form1" method="post" runat="server">
    <EPiServerSys:SystemPrefix runat="server" id="SystemPrefix" />
    <table>
		<tr>
			<td colspan="2">
				&nbsp;
			</td>
		</tr>
   		<tr>
			<td colspan="2">
				<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SaveShowTool.gif"		ID="Save"			Text="/button/saveandview"	ToolTip="/edit/editpanel/tooltipsave"		runat="server" />
				<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SavePublishTool.gif"	ID="SaveAndPublish" Name="Publish"	Text="/button/saveandpublish"	ToolTip="/edit/editpanel/tooltipapprove"	RequiredAccess="Publish" runat="server" />
				<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/Cancel.gif"				ID="Cancel"			Name="Cancel"	Text="/button/cancel"	ToolTip="/edit/editpanel/tooltipcancel" runat="server"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				&nbsp;
			</td>
		</tr>
		<tr>
		<td>
			<EPiServerSys:PropertyDataForm id="myForm" AutoLoadTabs="False" runat="server">
				<CaptionTemplate>
					<input type="radio" checked="checked" name="resolve_<%#Container.Property.Name%>" value="myChanges" /> <%#Container.Property.DisplayName%>
				</CaptionTemplate>
			</EPiServerSys:PropertyDataForm>
		</td>
		<td>
			<EPiServerSys:PropertyDataForm id="publishedForm" AutoLoadTabs="False" runat="server">
				<CaptionTemplate>
					<input type="radio" name="resolve_<%#Container.Property.Name%>" value="publishedChanges" /> <%#Container.Property.DisplayName%>
				</CaptionTemplate>
			</EPiServerSys:PropertyDataForm>
		</td>
		</tr>
	</table>

     </form>
	
  </body>
</html>
