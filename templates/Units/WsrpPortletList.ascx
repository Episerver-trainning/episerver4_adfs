<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpPortletList.ascx.cs" Inherits="development.Templates.Units.WsrpPortletList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="portletlist">
	<asp:Repeater Runat=server ID=ProducerList DataSource=<%# this.AvailableProducers %> >
		<ItemTemplate>
			<div ProducerId='<%# Container.DataItem %>' >
				<div class="settingstitle"><%# Container.DataItem %></div>
				<asp:Repeater Runat=server ID=PortletList DataSource=<%# this.GetPortlets( (string) Container.DataItem ) %> >
					<ItemTemplate>
						<div class="portletlistitem" 
							onmousemove="onItemMouseMove(this)"
							onmouseover="toggleItem(this, document.getElementsByName('<%# "img_" + ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).portletHandle  %>')[0], true);"
							onmouseout="toggleItem(this, document.getElementsByName('<%# "img_" + ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).portletHandle  %>')[0], false);"
							onclick="selectPortlet(this)" 
							Title='<%# ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).title.value %>' 
							PortletId='<%# ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).portletHandle %>'>
							<nobr><img align="absmiddle" name='<%# "img_" + ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).portletHandle %>' runat=server src="~/images/wsrp/maximize_gray.gif" />&nbsp;<%# ((ElektroPost.Wsrp.V1.Types.PortletDescription) Container.DataItem).title.value %></nobr>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</ItemTemplate>
	</asp:Repeater>
	<script type="text/javascript" >
		function toggleItem(item, image, highlight) {
			item.className= highlight ? 'portletlistitemhover' : 'portletlistitem'; 
			if (image) {
				image.src = highlight ? '../images/wsrp/maximize.gif' : '../images/wsrp/maximize_gray.gif' ;
			}
		}
	
		function selectPortlet(item) {
			var portletId = item.getAttribute('PortletId');
			var title = item.getAttribute('Title');
			var producerElement = findElementWithAttribute(item, 'ProducerId');
			
			if (producerElement && portletId) {
				document.getElementsByName('_PROD')[0].value = producerElement.getAttribute('ProducerId');
				document.getElementsByName('_PORTLET')[0].value = portletId;
				document.getElementsByName('_PORTLETTITLE')[0].value = title;
				document.getElementsByName('_ACTION')[0].value = '_ADDPORTLET';
				document.getElementsByName('_AREA')[0].value = '0';
				document.getElementsByName('_POS')[0].value = '0';
			}
		}
	</script>
</div>
