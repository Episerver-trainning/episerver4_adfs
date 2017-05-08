<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LinkGenericExternal.ascx.cs" Inherits="EPiServer.Util.LinkGenericExternal" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? " style='display:none'" : String.Empty%>>
		<td width="100%"><episerver:translate text="/util/linkeditor/textfieldcaption" runat="Server"/></td>
		<td><asp:textbox style="WIDTH:300px" CssClass="TextBox" ID="linkText" Runat="server" /></td>
	</tr>
	<tr<%=!((EPiServer.Util.LinkBase)Page).DisplayLinkTitle ? " style='display:none'" : String.Empty%>>
		<td><episerver:translate text="/util/linkeditor/linktitlefieldcaption" runat="Server"/></td>
		<td><asp:textbox style="WIDTH:300px" CssClass="TextBox" ID="titleText"  Runat="server"/></td>
	</tr>
	<tr>
		<td><episerver:translate text="/util/linkeditor/urlfieldcaption" runat="Server"/></td>
		<td><asp:textbox style="WIDTH:300px" CssClass="TextBox" ID="linkUrl" Runat="server" /></td>
	</tr>
	<tr<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? " style='display:none'" : String.Empty%>>
		<td><episerver:translate text="/util/linkeditor/targetfieldcaption" runat="Server"/></td>
		<td>
			<asp:DropDownList id="linkFrame" Runat="server" />
		</td>
	</tr>
</table>
