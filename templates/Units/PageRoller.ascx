<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PageRoller.ascx.cs" Inherits="development.Templates.Units.NewsTicker" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<episerver:pagelist id="PageListControl" PageLinkProperty="ListingSlideContainer"  runat="server" MaxCount='<%#GetCount()%>'>
	<HeaderTemplate>
		<script type='text/javascript'>
		<!--
			var da = (document.all) ? 1 : 0;
			var pages = new Array();
			var activeDiv = 0;
			
			window.setInterval(switchDiv, 1000*<%=CurrentPage["RefreshRate"] == null ? "10" : CurrentPage["RefreshRate"]%>);
			
			function switchDiv()
			{
				var oldDiv,newDiv;
				
				if(da)
					oldDiv = document.all[pages[activeDiv]];
				else
					oldDiv = document.getElementById(pages[activeDiv]);
				oldDiv.className = 'hidden';
				
				activeDiv = activeDiv + 1;
				if (pages.length <= activeDiv)
					activeDiv = 0;
						
				if(da)
					newDiv = document.all[pages[activeDiv]];
				else
					newDiv = document.getElementById(pages[activeDiv]);
				newDiv.className = '';
			}
		-->
		</script>
	</HeaderTemplate>
	<ItemTemplate>
		<script type='text/javascript'>
			pages.push('newsid_<%#Container.CurrentPage.PageLink%>');
		</script>
		<div id="newsid_<%#Container.CurrentPage.PageLink%>" class="<%=GetClassName()%>">
			<br />
			<p>
				<episerver:property PropertyName="PageName" CssClass="heading1" runat="server" />
			</p>
			<episerver:property PropertyName="MainBody" runat="server" />
		</div>
	</ItemTemplate>
</episerver:pagelist>