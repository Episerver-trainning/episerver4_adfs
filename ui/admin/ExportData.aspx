<%@ Page language="c#" Codebehind="ExportData.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ExportData" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="UC" TagName="ListBuilder"	Src="ListBuilder.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>ExportData</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="ExportData" method="post" runat="server">
			<EPiServerSys:SystemPrefix id="PagePrefix" runat="server"/>
			<br>&nbsp;<br>
			<table>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportPages" /><EPiServer:Translate Text="#exportpages" runat="server"/>
						
						<div id="PageList" style="margin-left: 20px;display:none" runat="server">
						<table border="0">
							<tr>
								<td><EPiServer:Translate Text="#selectpage" runat="server" ID="Translate5" NAME="Translate2"/></td>
								<td><EPiServer:InputPageReference id="PageRoot" runat="server" /></td>
							</tr>
							<tr>
								<td><EPiServer:Translate Text="#exportpagefiles" runat="server" ID="Translate4" NAME="Translate2"/></td>
								<td><asp:CheckBox runat="server" Checked="True" ID="ExportPageFiles"/></td>
							</tr>
							<tr>
								<td><EPiServer:Translate Text="#exportpagelanguages" runat="server" ID="Translate2" NAME="Translate2"/></td>
								<td><asp:CheckBox runat="server" ID="ExportPageLanguages"/></td>
							</tr>
							<tr>
								<td><EPiServer:Translate Text="#exportpagedependencies" runat="server" ID="Translate3"/></td>
								<td><asp:CheckBox runat="server" ID="ExportPageDependencies"/></td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportPageTypes" /><EPiServer:Translate Text="#exportpagetypes" runat="server"/><br>
						<asp:CheckBoxList Style="margin-left: 20px;display:none;" RepeatColumns="4" RepeatDirection="Vertical" RepeatLayout="Table" Runat="server" ID="PageTypeList" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportFrames" /><EPiServer:Translate Text="#exportframes" runat="server"/><br>
						<asp:CheckBoxList Style="margin-left: 20px;display:none;" Runat="server" ID="FrameList" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportDynamicPropertyDefinitions" /><EPiServer:Translate Text="#exportdynamicpropertydefinitions" runat="server"/><br>
						<asp:CheckBoxList Style="margin-left: 20px;display:none;" Runat="server" ID="DynamicPropertyDefinitionList" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportTabDefinitions" /><EPiServer:Translate Text="#exporttabdefinitions" runat="server"/><br>
						<asp:CheckBoxList Style="margin-left: 20px;display:none;" Runat="server" ID="TabDefinitionList" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportCategories" /><EPiServer:Translate Text="#exportcategories" runat="server"/><br>
						<EPiServer:InputCategoryTree Style="margin-left: 20px;display: none" Runat="server" ID="CategoryTree" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:CheckBox Runat="server" ID="ExportFiles" /><EPiServer:Translate Text="#exportfiles" runat="server" ID="Translate1" NAME="Translate1"/><br>
						<div style="margin-left: 20px;display: none" id="FileTree" runat="server">
							<UC:ListBuilder DialogUrl="FileBrowser.aspx" id="FileInput" runat="Server"/>
						</div>
					</td>
				</tr>
			</table>
			<br>
			<asp:button Translate="#exportbutton" Text="Start export" id="exportButton" OnCommand="Export" CommandName="LiveExport" runat="server"/>
			<asp:button Translate="#testexportbutton" Text="Start export" id="testExportButton" OnCommand="Export" CommandName="TestExport" runat="server"/>
		</form>
	</body>
</html>
