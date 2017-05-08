<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FileListing.ascx.cs" Inherits="development.Templates.Units.FileListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Label id="ErrorMessage" runat="server" text='<%=Translate("/templates/filelisting/rootpatherror")%>' Visible="False"></asp:Label>
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns:episerver="http://schemas.episerver.com">
<EPiServer:UnifiedFileTree runat="server" ID="FileList" SortOrder='<%#GetSortOrder()%>' RootPath='<%#CurrentPage["WebBaseURL"]%>' ExpansionMode="Manual" FilenamePattern="*.*" MaxDepth="3">
	<FileTemplate>
		<tr>
			<td valign="top"><%#CreateIndentStructure(Container.Indent)%><img align="absbottom" vspace="0" border="0" src="<%=Configuration.RootDir%>util/images/filetree/<%#Container.IsLastInIndent?"L.gif":"T.gif"%>" alt="" /><a href="<%#Container.Path%>" class="linklist" target="_blank"><img border="0" align="absbottom" vspace="0" src="<%#GetExtensionImage(Container.UnifiedFile.Extension)%>" alt=""><%#Container.Name%></a></td>
			<td align="right" valign="top"><%#Container.Size%>Kb&nbsp;&nbsp;</td>
			<td valign="top"><span class="datelistingtext"><%#Container.UnifiedFile.Changed%></span></td>
		</tr>
	</FileTemplate>
	<DirectoryTemplate>
		<tr>
			<td valign="top"><%#CreateIndentStructure(Container.Indent)%><a href="javascript:<%#Container.ToggleOpenScript%>;" class="linklist"><img class="borderless" align="absbottom" vspace="0" src="<%#GetExpandImage(Container.HasChildren, Container.IsExpanded, Container.IsLastInIndent)%>" alt="" /><img border="0" align="absbottom" vspace="0" src="<%#GetFolderImage(Container.IsExpanded)%>" alt=""><%#Container.Name%></a></td>
			<td valign="top"></td>
			<td valign="top"></td>
		</tr>
	</DirectoryTemplate>
</EPiServer:UnifiedFileTree>
</table>
