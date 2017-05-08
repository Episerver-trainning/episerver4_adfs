<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FileSelector.ascx.cs" Inherits="EPiServer.Admin.FileSelector" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Label id="ErrorMessage" runat="server" text='<%=Translate("#rootpatherror")%>' Visible="False"></asp:Label>
<table border="0" cellpadding="0" cellspacing="0" width="100%" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
<EPiServer:FileTree runat="server" ID="FileList" SortOrder="Name" RootPath="/" ExpansionMode="Manual" FilenamePattern="*.*" MaxDepth="10">
	<FileTemplate>
		<tr>
			<td valign="top"><%#CreateIndentStructure(Container.Indent)%><img align="absbottom" vspace="0" border="0" src="<%=Configuration.RootDir%>util/images/explorertree/<%#Container.IsLastInIndent?"L.gif":"T.gif"%>"><a href="#" onclick="window.returnValue='<%#Container.Path%>';window.close();"><img border="0" align="absbottom" vspace="0" src="<%#GetExtensionImage(Container.File.Extension)%>"><%#Container.Name%></a></td>
			<td align="right" valign="top"><%#Container.Size%>Kb&nbsp;&nbsp;</td>
			<td valign="top"><%#Container.File.LastWriteTime%></td>
		</tr>
	</FileTemplate>
	<DirectoryTemplate>
		<tr>
			<td valign="top"><%#CreateIndentStructure(Container.Indent)%><a href="#" onclick="<%#Container.ToggleOpenScript%>;"><img border="0" align="absbottom" vspace="0" src="<%#GetExpandImage(Container.HasChildren, Container.IsExpanded, Container.IsLastInIndent)%>"><img border="0" align="absbottom" vspace="0" src="<%#GetFolderImage(Container.IsExpanded)%>"><%#Container.Name%></a></td>
			<td valign="top"></td>
			<td valign="top"><%#Container.Directory.LastWriteTime%></td>
		</tr>
	</DirectoryTemplate>
</EPiServer:FileTree>
</table>
