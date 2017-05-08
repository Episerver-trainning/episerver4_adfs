<%@ Page language="c#" Codebehind="ImportData.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Enterprise.Admin.ImportData" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>ImportData</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="ImportData" encType="multipart/form-data" method="post" runat="server">
			<EPiServerSys:SystemPrefix id="PagePrefix" runat="server"/>
			<br>&nbsp;<br>
			<asp:PlaceHolder id="UploadFileView" runat="server">
				<table>
					<tr>
						<td>
							<episerver:translate Text="#selectfile" runat="server"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="file" runat="server"/>
						</td>
					</tr>
				</table>
				<br>
				<asp:Button runat="server" Translate="#uploadfile" OnClick="UploadFile"/>
			</asp:PlaceHolder>
			<asp:PlaceHolder id="ImportFileView" runat="server">
				<table>
				<tr>
					<td><EPiServer:Translate Text="#selectpageroot" runat="server"/></td>
					<td colspan="2">
						<EPiServer:InputPageReference runat="Server" ID="PageRoot"/>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#pagecount" runat="server"/></td>
					<td valign="top"><asp:Label id="PageCount" runat="server"/> <a href="javascript:void(0);" OnClick="PageListTable.style.display=PageListTable.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a></td>
					<td valign="top">
						<table id="PageListTable" style="display:none;">
						<EPiServer:PageTree id="PageList" runat="server">
							<HeaderTemplate>
								<tr><td>
									<%#Container.CurrentPage.PageName%>
								</td></tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr><td>
									<span style="margin-left: <%#Container.CurrentPage.Indent%>0px"><%#Container.CurrentPage.PageName%></span>
								</td></tr>
							</ItemTemplate>
						</EPiServer:PageTree>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#pagetypecount" runat="server"/></td>
					<td valign="top">
						<asp:Label id="PageTypeCount" runat="server"/> <a href="javascript:void(0);" OnClick="PageTypeList.style.display=PageTypeList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a>
					</td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="PageTypeList">
							<Columns>
								<asp:BoundColumn DataField="Name"/>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#categorycount" runat="server"/></td>
					<td valign="top"><asp:Label id="CategoryCount" runat="server"/> <a href="javascript:void(0);" OnClick="CategoryList.style.display=CategoryList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a></td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="CategoryList">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<span style="margin-left: <%#DataBinder.Eval(Container.DataItem,"Indent")%>0px"><%#DataBinder.Eval(Container.DataItem,"Name")%></span>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#framecount" runat="server"/></td>
					<td valign="top"><asp:Label id="FrameCount" runat="server"/> <a href="javascript:void(0);" OnClick="FrameList.style.display=FrameList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a></td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="FrameList">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#DataBinder.Eval(Container.DataItem,"Name")%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#dynamicpropertydefinitioncount" runat="server"/></td>
					<td valign="top"><asp:Label id="DynamicPropertyDefinitionCount" runat="server"/> <a href="javascript:void(0);" OnClick="DynamicPropertyDefinitionList.style.display=DynamicPropertyDefinitionList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a></td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="DynamicPropertyDefinitionList">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#DataBinder.Eval(Container.DataItem,"Name")%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#tabdefinitioncount" runat="server"/></td>
					<td valign="top"><asp:Label id="TabDefinitionCount" runat="server"/> <a href="javascript:void(0);" OnClick="TabDefinitionList.style.display=TabDefinitionList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server"/></a></td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="TabDefinitionList">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#DataBinder.Eval(Container.DataItem,"Name")%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td valign="top"><episerver:translate Text="#filecount" runat="server" ID="Translate1" NAME="Translate1"/></td>
					<td valign="top"><asp:Label id="FileCount" runat="server"/> <a href="javascript:void(0);" OnClick="FileList.style.display=FileList.style.display=='none' ? '' : 'none';return false;"><episerver:translate text="#show" runat="server" ID="Translate2" NAME="Translate2"/></a></td>
					<td valign="top">
						<asp:DataGrid Border="0" Style="display:none;" AutoGenerateColumns="False" ShowHeader="False" runat="server" id="FileList">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#Container.DataItem%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				</table>
				<br>
				<asp:Button runat="server" Translate="#beginimport" id="ImportButton" OnClick="ImportFile"/>			
			</asp:PlaceHolder>
     </form>
	
  </body>
</html>
