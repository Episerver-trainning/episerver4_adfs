<%-- @(#) $Id: EditListing.ascx,v 1.1.2.2 2006/02/28 11:02:43 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditListing.ascx.cs" Inherits="development.Templates.Blog.Units.EditList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Blog" TagName="EditorBlog" Src="~/templates/Blog/Units/EditorBlog.ascx"%>
<asp:Panel ID="pnlList" Runat="server" Visible="True">
	<p>
		<asp:LinkButton ID="btnShowXForm" Runat="server" Visible="True" Translate="/templates/blog/createnewpost" />
    </p>
    <asp:DataList Runat="server" id="blogEntryList" Width="100%">
    <HeaderTemplate>
        <table Width="100%">
			<tr>
				<th><%= EPiServer.Global.EPLang.Translate("/templates/blog/post") %></th>
				<th><%= EPiServer.Global.EPLang.Translate("/templates/blog/date") %></th>
				<th><%= EPiServer.Global.EPLang.Translate("/templates/blog/changestatus") %></th>
			</tr>
			<tr><td colspan="3"><hr/></td></tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>
                <asp:LinkButton ID="btnEditBlogEntry" CommandName="btnEditBlogEntry" CommandArgument='<%# DataBinder.GetPropertyValue(Container.DataItem, "FormDataId") %>' Runat="server" Text='<%# DataBinder.GetPropertyValue(Container.DataItem, "Title") %>' />
            </td>
            <td><%# DataBinder.GetPropertyValue(Container.DataItem, "FormattedPostedDate") %></td>
            <td>
                <asp:LinkButton ID="btnChangePostPublishStatusComment" CommandName="btnChangePostPublishStatusComment" CommandArgument='<%# DataBinder.GetPropertyValue(Container.DataItem, "FormDataId") %>' Runat="server" Text='<%# DataBinder.GetPropertyValue(Container.DataItem, "ChangePublishStatusText") %>' />
            </td>
        </tr>        
        <tr>
			<td colspan="3">
                <asp:LinkButton ID="btnToggleComment" CommandName="btnToggleComment" CommandArgument='<%# DataBinder.GetPropertyValue(Container.DataItem, "FormDataId") %>' Runat="server" Text='<%# DataBinder.GetPropertyValue(Container.DataItem, "CommentsHeadingForEdit") %>' />
            </td>
		</tr>
            <div id='<%# DataBinder.GetPropertyValue(Container.DataItem, "FormDataId") %>' >
                <asp:Repeater ID="commentEntryList" DataSource='<%# ((EditBlogEntry)Container.DataItem).CommentEntriesForEdit %>' Visible="False" Runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# DataBinder.GetPropertyValue(Container.DataItem, "Email") %>
                            </td>
                            <td>
                                <%# DataBinder.GetPropertyValue(Container.DataItem, "FormattedPostedDate") %>
                            </td>
                            <td>
				                <asp:LinkButton ID="btnChangeCommentPublishStatusComment" CommandName='<%# DataBinder.GetPropertyValue(Container.DataItem, "FormDataId") %>' Runat="server" Text='<%# DataBinder.GetPropertyValue(Container.DataItem, "ChangePublishStatusText") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td></tr>
    </ItemTemplate>
    <SeparatorTemplate>
        <tr><td colspan="3"><hr/></td></tr>
    </SeparatorTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
    </asp:DataList>
</asp:Panel>
<asp:Panel ID="pnlXForm" Runat="server" Visible="False">
    <Blog:EditorBlog runat="server" id="editorBlog" EnableViewState="True" />
</asp:Panel>
