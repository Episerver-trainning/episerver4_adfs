<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ContentMirroringAdmin.ascx.cs" Inherits="EPiServer.Edit.ContentMirroringAdmin" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<br>
<EPiServerSys:SystemPrefix id="PagePrefix" runat="server"/>

<br><br><br>
<asp:Repeater id="syncList" Runat="server">
	<ItemTemplate>
		<div style="padding: 2px;"></div>
		<div style="background: #ECEFF3; border: 1px solid #6D8CA8;padding: 5px;">
			<a href="#" style="font-size: 1.2em;display: block;spacing: 100px;" onclick="if(this.parentElement.children[1].style.display=='none'){this.parentElement.children[1].style.display='';}else{this.parentElement.children[1].style.display='none';}return false;"><%#DataBinder.Eval(Container.DataItem,"Name")%> (<%#GetChangesForList(Container.DataItem).Length%>)</a>
			<div style="display: none;padding-top: 10px;">
				<table class="EP-tableGrid" cellspacing="0" rules="all" border="1" id="PageTypeList" style="border-collapse:collapse;">
				<tr class="EP-tableHeadingGrid">
					<td>Page name</td>
					<td align="center">Type</td>
					<td align="center">Saved by</td>
					<td align="center">Saved</td>
				</tr>
				<asp:Repeater id="changesList" DataSource=<%#GetChangesForList(Container.DataItem)%> Runat="server">
					<ItemTemplate>
					<tr class="EP-tableCellGrid">
						<%#RenderDiffInfo(Container.DataItem)%>
					</tr>
					</ItemTemplate>
				</asp:Repeater>
				</table>
				<br>
				<div>
					<asp:Button Enabled=<%#!(System.Boolean)DataBinder.Eval(Container.DataItem,"AutomaticApproval")%> Translate="/button/publish" CommandName=<%#DataBinder.Eval(Container.DataItem,"ID")%> OnCommand="SyncChanges" Runat="server" ID="Button1" NAME="Button1"></asp:Button>
				</div>
			</div>
		</div>
	</ItemTemplate>
</asp:Repeater>

<br>
