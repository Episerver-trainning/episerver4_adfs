<%@ Page language="c#" Codebehind="WorkflowItem.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Workflow.Admin.WorkflowItem" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerWorkflow" Namespace="EPiServer.Workflow.WebControls" Assembly="EPiServer.Workflow" %>
<%@ Register TagPrefix="WorkflowPlugIns" TagName="WorkflowLogView" Src="~/Util/PlugIns/WorkflowLogView.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title>WorkflowItem</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script language="JavaScript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
  </head>
  <body MS_POSITIONING="GridLayout" ondblclick="if(window.event.ctrlKey) for(var i=0;i<debugInfo.length;i++) debugInfo[i].style.display='';">
	
    <form id="WorkflowItem" method="post" runat="server">
    <EPiServerSys:SystemPrefix runat="server" ID="Systemprefix1"/>
	<br><br>
	<asp:Button Translate="/button/save" OnClick="SaveWorkflow" Runat="server" ID="Button1" NAME="Button1"/>
	<asp:Button Translate="/button/delete" CausesValidation="false" OnClick="DeleteWorkflow" Runat="server" ID="Button2"/>
	<asp:Button Translate="/button/cancel" CausesValidation="false" OnClick="Cancel" Runat="server" ID="Button3"/>
	<br><br>
    <EPiServerSys:TabStrip TargetID="TabView" AutoPostBack="False" runat="server">
		<EPiServerSys:Tab Text="#infotab" Sticky="True" runat="server" ID="Tab1"/>
		<EPiServerSys:Tab Text="#flowtab" Sticky="True" runat="server" ID="Tab2"/>
		<EPiServerSys:Tab Text="#autostarttab" Sticky="True" runat="server" ID="Tab3"/>
		<EPiServerSys:Tab Text="#logtab" Sticky="True" runat="server" ID="Tab4"/>
    </EPiServerSys:TabStrip>
    <br>
    <asp:Panel ID="TabView" Runat="server">
		<asp:Panel ID="tabbe1" Runat="server">
			<table>
				<tr>
					<td><episerver:translate runat="server" text="#name" ID="Translate2" NAME="Translate1"/></td>
					<td><asp:TextBox Width="200" Runat="server" ID="WorkflowName"/><asp:RequiredFieldValidator ID="RequiredCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="WorkflowName"
					Runat="server"/></td>
				</tr>
				<tr>
					<td><episerver:translate runat="server" text="#workflowowner" ID="Translate12" NAME="Translate1"/></td>
					<td><EPiServerSys:SidDropDownList id="OwnerSID" runat="server"/></td>
				</tr>
				<tr>
					<td><episerver:translate runat="server" text="#allowmanualstart" ID="Translate13" NAME="Translate1"/></td>
					<td><asp:CheckBox Width="200" Runat="server" ID="AllowManualStart"/></td>
				</tr>				
				<tr>
					<td><episerver:translate runat="server" text="#watchtype" ID="Translate5" NAME="Translate1"/></td>
					<td><asp:DropDownList Runat="server" ID="WatchType"/></td>
				</tr>
				<tr valign="top">
					<td><episerver:translate runat="server" text="#description" ID="Translate4" NAME="Translate1"/></td>
					<td><asp:TextBox Width="350" Height="200" TextMode=MultiLine Runat="server" ID="WorkflowDescription"/></td>
				</tr>
			</table>
		</asp:Panel>
		<asp:Panel ID="tabbe2" Runat=server>
			<asp:DataGrid AutoGenerateColumns="False" GridLines="None" BorderStyle="None" Cellpadding="2" Cellspacing="0" ID="WorkflowStep" Runat="server">
			<Columns>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						#<asp:label Style="display:none" Text='<%#(Index=1)==1 ? String.Empty : String.Empty%>' runat="server"/>
						<span id="debugInfo" style="display:none"/>
					</HeaderTemplate>
					<ItemTemplate>
							<asp:label Text='<%#(Index++).ToString()%>' runat="server"/>
							<input type="hidden" id="StepID" runat="server" Value='<%# Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %>'/>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						<episerver:translate runat="server" text="#name" ID="Translate1" NAME="Translate1"/>
					</HeaderTemplate>
					<ItemTemplate>
							<EPiServerWorkflow:UserName SID='<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "fkSID"))%>' runat="server"/>
							<nobr><span id="debugInfo" style="display: none">[ID:<%# DataBinder.Eval(Container.DataItem,"pkID")%> OnCompleted:<%# DataBinder.Eval(Container.DataItem,"OnCompleted")%> OnRejected:<%# DataBinder.Eval(Container.DataItem,"OnCompleted")%> SortIndex:<%# DataBinder.Eval(Container.DataItem,"SortIndex")%>]</span></nobr>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						<episerver:translate runat="server" text="#type" ID="Translate3" NAME="Translate1"/>
					</HeaderTemplate>
					<ItemTemplate>
							<EPiServerWorkflow:PlugInDropDownList ID="SelectedPlugIn" SelectedPlugInID=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "fkPlugInID"))%> runat="server"/>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						<episerver:translate runat="server" text="#timeout" ID="Translate3" NAME="Translate1"/>
					</HeaderTemplate>
					<ItemTemplate>
							<EPiServerWorkflow:TimeSpanInput TotalMinutes=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "TimeOut"))%> ID="TimeOut" runat="server"/>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						<episerver:translate runat="server" text="#onrejected" ID="Translate3" NAME="Translate1"/>
					</HeaderTemplate>
					<ItemTemplate>
							<EPiServerWorkflow:JumpDropDownList SelectedJump=<%#GetOnRejectValue(Container.DataItem)%> ID="OnRejected" runat="server"/>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<ItemTemplate>
							<nobr>
							<asp:ImageButton OnCommand="MoveDownClick" CommandName=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %> ImageUrl="~/Util/Images/DownToolSmall.gif" Runat="server" ID="Imagebutton1" NAME="Imagebutton1"/>
							<asp:ImageButton OnCommand="MoveUpClick" CommandName=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %> ImageUrl="~/Util/Images/UpToolSmall.gif" Runat="server" ID="Imagebutton2" NAME="Imagebutton1"/>
							<asp:ImageButton OnCommand="DeleteStep" CommandName=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %> ImageUrl="~/Util/Images/DelToolSmall.gif" Runat="server" ID="Imagebutton3" NAME="Imagebutton1"/>
							</nobr>
					</ItemTemplate>
				</asp:TemplateColumn>				
			</Columns>
		</asp:DataGrid>
			<br>
			<asp:Button OnClick="AddStep" Translate="#addstep" Runat="server" ID="Button4" NAME="Button4"/>
			<EPiServerSys:SidDropDownList ID="userSelector" Runat="server"/>
		</asp:Panel>
		<asp:Panel ID="tabbe3" Runat="server">
			<table>
				<tr>
					<td><EPiServer:Translate Text="#eventcheckin" runat="server" ID="Translate8"></EPiServer:Translate></td>
					<td><asp:CheckBox RepeatDirection="Horizontal" ID="EventCheckIn" Runat="server"/></td>
				</tr>
				<tr>
					<td><EPiServer:Translate Text="#eventpublish" runat="server" ID="Translate7"></EPiServer:Translate></td>
					<td><asp:CheckBox RepeatDirection="Horizontal" ID="EventPublish" Runat="server"/></td>
				</tr>
			</table>
			<asp:DataGrid AutoGenerateColumns="False" GridLines="None" BorderStyle="None" Cellpadding="2" Cellspacing="0" ID="WorkflowAutoStart" Runat="server">
			<Columns>
				<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<HeaderTemplate>
						<episerver:translate runat="server" text="#autostartpage" ID="Translate6" NAME="Translate1"/>
					</HeaderTemplate>
					<ItemTemplate>
							<EPiServerWorkflow:PageName PageID=<%# Convert.ToInt32(DataBinder.Eval(Container.DataItem, "fkPageID"))%> runat="server"/>
							&nbsp;
					</ItemTemplate>
				</asp:TemplateColumn>
			<asp:TemplateColumn>
					<HeaderStyle CssClass="EP-tableHeading">
					</HeaderStyle>
					<ItemTemplate>
							<asp:ImageButton OnCommand="DeletePage" CommandName=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "fkPageID")) %> ImageUrl="~/Util/Images/DelToolSmall.gif" Runat="server" ID="Imagebutton3" NAME="Imagebutton1"/>
					</ItemTemplate>
			</asp:TemplateColumn>
			</Columns>
		</asp:DataGrid>
		<br><EPiServerWorkflow:AddPageButton Translate="#addpage" OnClick="AddPage" ID="AddAutoStartPage" Runat="server"/>
		</asp:Panel>
		<asp:Panel ID="tabbe4" Runat="server">
			<episerver:translate runat="server" text="#logtabinfo" ID="Translate11" NAME="Translate1"/><br><br>
			<WorkflowPlugIns:WorkflowLogView ShowHeading="False" ID="LogView" runat="server"/>
		</asp:Panel>
	</asp:Panel>
	<br><br>
     </form>
	
  </body>
</html>
