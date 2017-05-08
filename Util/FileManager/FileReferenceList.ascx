<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="FileReferenceList.ascx.cs" Inherits="EPiServer.Util.FileManager.FileReferenceList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script>

function GoToPage(id,path)
{
	var wnd = window;
	if(wnd.parent!=null && wnd.parent.parent!=null)
		wnd = window.parent.parent;
		
	if(wnd.navigateEvent)
		wnd.navigateEvent(window.parent,id);
	else
		wnd.open(path);
		
}


</script>
<asp:Panel ID="contentPanel" Runat="server">
<asp:Repeater ID="linkedPagesList" Runat="server">
	<ItemTemplate>
		<div>
		<EPiServer:Translate 
			Text="/filemanager/filereferencelist/xlinkstoy" 
			StringFormatObjects = <%#new System.Object[]{GetDisplayName(DataBinder.Eval(Container.DataItem,"OwnerPageLink")),DataBinder.Eval(Container.DataItem,"Url")}%>
			runat="server"/>
		</div>
	</ItemTemplate>
</asp:Repeater>
</asp:Panel>
