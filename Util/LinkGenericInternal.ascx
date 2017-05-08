<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LinkGenericInternal.ascx.cs" Inherits="EPiServer.Util.LinkGenericInternal" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? " style='display:none'" : String.Empty%>>
		<td width="100%">
			<episerver:translate text="/util/linkeditor/textfieldcaption" runat="Server"/>
		</td>
		<td>
			<asp:textbox style="WIDTH:300px" CssClass="TextBox" ID="linkText" Runat="server" />
		</td>
	</tr>
	<tr<%=!((EPiServer.Util.LinkBase)Page).DisplayLinkTitle ? " style='display:none'" : String.Empty%>>
		<td>
			<episerver:translate text="/util/linkeditor/linktitlefieldcaption" runat="Server"/>
		</td>
		<td> 
			<asp:textbox style="WIDTH:300px" CssClass="TextBox" ID="titleText"  Runat="server"/>
		</td>
	</tr>
	<tr<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? " style='display:none'" : String.Empty%>>
		<td>
			<episerver:translate text="/util/linkeditor/targetfieldcaption" runat="Server"/>
		</td>
		<td>
			<asp:DropDownList id="linkFrame" Runat="server" />
		</td>
	</tr>
	<tr>
		<td colspan="2"><episerver:translate text="/util/linkeditor/selectpagecaption" runat="Server"/></td>
	</tr>
</table>
<div id="pageTree" style="width:448px;margin-left:2px;"  >
	<episerver:ExplorerTree EnableVisibleInMenu="False" ShowIcons="True" ShowRootPage="True" id="explorerTree" runat="server" />
	<input type="hidden" id="selectedPage" name="selectedPage" runat="server" />
</div>
