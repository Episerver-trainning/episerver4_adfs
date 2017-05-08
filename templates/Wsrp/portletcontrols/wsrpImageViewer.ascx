<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpImageViewer.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.wsrpImageViewer" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:PlaceHolder runat="server" ID="View">
	<div style="text-align: center; width: 500px;">
		<img id="currentImage<%= UniquePrefix %>" style="height: 300px" src="<%= EPiServer.Util.UrlUtility.ResolveUrl( "~" + SelectedImage.Path, EPiServer.Util.UrlTypes.Absolute) %>" />
		<img id="nextImage<%= UniquePrefix %>" style="display: none" src="<%= EPiServer.Util.UrlUtility.ResolveUrl( "~" + NextImage.Path, EPiServer.Util.UrlTypes.Absolute) %>" />
		<div style="width: 300px; height:<%= this.ThumbnailSize %>px;overflow-x: scroll;">
			<table border=0><tr>
			<asp:Repeater runat="server" ID="ImageList">
				<ItemTemplate>
					<td><a href="<%# ((EPiServer.FileSystem.UnifiedFile) Container.DataItem).Path %>">
						<img 
							NAME="thumb<%# UniquePrefix %>"
							src="<%# EPiServer.Util.UrlUtility.ResolveUrl( "~" + ((EPiServer.FileSystem.UnifiedFile) Container.DataItem).Path, EPiServer.Util.UrlTypes.Absolute ) %>" 
							style="height: <%= this.ThumbnailSize %>px; border: <%# ((EPiServer.FileSystem.UnifiedFile) Container.DataItem).Path == SelectedImage.Path ? "1px solid black" : "none" %>"/></a>
					</td>
				</ItemTemplate>
			</asp:Repeater>
			</tr></table>
		</div>
		<input type="button" id="playButton" onclick="toggleAutoShow<%= UniquePrefix %> (this,'<%= UniquePrefix %>')" value="Play" />
	</div>

	<script type="text/javascript" >
		function getImageIdx(src, images) {
			for (i = 0; i < images.length; i++ ) {
				if (src == images[i].src) return i;
			}
			return -1;
		}
		function getNextImageIdx(src, prefix) {
			var images = document.getElementsByName('thumb' + prefix);
			var idx = getImageIdx(src, images);
			if (idx >= 0 ) {
				return (idx + 1) % images.length;
			}
			return -1;
		}
		function setCurrentImage(idx, prefix) {
			var images = document.getElementsByName('thumb' + prefix);
			for (i = 0; i < images.length; i++) images[i].style.border = 'none';
			images[idx].style.border = '1px solid black';
			document.getElementById('currentImage' + prefix).src = images[idx].src;
		}
		
		var intervalId<%= UniquePrefix %> = null;
		function toggleAutoShow<%= UniquePrefix %> (button, prefix) {
			if (!intervalId<%= UniquePrefix %>)
				intervalId<%= UniquePrefix %> = window.setInterval(
				    "var currImage = document.getElementById('currentImage" + prefix + "').src; " +
				    "var nextIdx = getNextImageIdx(currImage, '" + prefix + "'); " + 
				    "setCurrentImage(nextIdx, '" + prefix + "');", 
				    5000);
			else 
			{
				window.clearInterval(intervalId<%= UniquePrefix %>);
				intervalId<%= UniquePrefix %> = null;
			}
			button.value = intervalId<%= UniquePrefix %> ? 'Stop' : 'Play';
		}
	</script>
</asp:PlaceHolder>

<asp:PlaceHolder runat="server" ID="Edit">
	<form action="page.aspx" method="post">
		<p>
			<div class="portlet-form-label">Image path</div>
			<input type="text" name="path" id="path" value="<%= this.SelectedPath %>" />
			<div class="portlet-form-label">Thumbnail size</div>
			<input type="text" name="thumbSize" id="thumbSize" value="<%= this.ThumbnailSize %>" />
		</p>
		<input type="submit" name="submit" id="submit" value="Save" />
	</form>
</asp:PlaceHolder>
