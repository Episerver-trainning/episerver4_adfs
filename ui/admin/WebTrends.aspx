<%@ Page language="c#" Codebehind="WebTrends.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.WebTrends" contentType="text/plain" enableViewState="False" EnableSessionState="False" %>
<asp:repeater id="DataList1" runat="server" EnableViewState="False"><ItemTemplate ><%#DataBinder.Eval(Container.DataItem,"pkid")%>,<%#DataBinder.Eval(Container.DataItem,"Name")%>
</ItemTemplate></asp:repeater>

