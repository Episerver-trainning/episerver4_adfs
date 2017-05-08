<%@ Control Language="c#" AutoEventWireup="false" Codebehind="TimeSpanView.ascx.cs" Inherits="EPiServer.Edit.TimeSpanView" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:PlaceHolder ID="ErrorMsg" Visible="False" Runat="server" />
	<asp:panel ID="MainPanel" runat="server">
		<table><tr><td>
			<episerver:translate text="/edit/logservice/timespananalyzer/selectinterval" runat="Server" ID="Translate5"/></td><td align="right"></td><td><asp:DropDownList  AutoPostBack="True" ID="DropDownIntervall" Runat="server" />
		</tr></td></table>

	<asp:Repeater id="StatisticsRepeater" runat="server" >
	<HeaderTemplate>
		<table class="EP-tableGrid">
		<tr>
			<td class="EP-tableHeadingGrid"><episerver:translate text="/edit/logservice/timespananalyzer/statisticsdate" runat="Server" ID="Translate1"/></td>
			<td class="EP-tableHeadingGrid"><episerver:translate text="/edit/logservice/timespananalyzer/statisticshits" runat="Server" ID="Translate2"/></td>
		</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td class="EP-tableCellGrid"><%# DataBinder.Eval(Container.DataItem, "Start") %> </td>
			<td align="right" class="EP-tableCellGrid"><%# DataBinder.Eval(Container.DataItem, "Hits") %> </td>
		</tr>
	</ItemTemplate>
	</asp:Repeater>
	<tr><td  class="EP-tableHeadingGrid">
		<episerver:translate text="/edit/logservice/timespananalyzer/total" runat="Server" ID="Translate6"/>
	</td><td  class="EP-tableHeadingGrid" align="right">
		<asp:label ID="StatisticsTotal" Runat="server"></asp:label>
	</td></tr>
	</table>
</asp:panel>

<br/><br/>

<asp:Repeater id="ReferrerRepeater" runat="server" >
   <HeaderTemplate>
      <table class="EP-tableGrid">
      <tr>
         <td class="EP-tableHeadingGrid"><episerver:translate text="/edit/logservice/realtimeanalyzer/referrerurl" runat="Server" ID="Translate3"/></td>
         <td class="EP-tableHeadingGrid"><episerver:translate text="/edit/logservice/realtimeanalyzer/referrercount" runat="Server" ID="Translate4"/></td>
      </tr>
   </HeaderTemplate>
   <ItemTemplate>
      <tr>
         <td class="EP-tableCellGrid"><%# TranslateReferrer( (String)DataBinder.Eval(Container.DataItem, "Referrer") ) %> 
         </td>
         <td  class="EP-tableCellGrid" align="right"><%# DataBinder.Eval(Container.DataItem, "Count") %> 
         </td>
      </tr>
   </ItemTemplate>
   <FooterTemplate> </table> </FooterTemplate>
</asp:Repeater>






