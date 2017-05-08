<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpPortalTabControl.ascx.cs" Inherits="development.Templates.Units.WsrpPortalTabControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="toparea">
	<div class="paddingextra">
		<div class="fullwidth">
			<div class="navigationtabarea">
				<asp:Repeater id="TabStrip" runat="server">

					<ItemTemplate>
						<span class="tabOuterContainer">
							<div class="tabContainer">
								<div runat=server class='<%# ((bool) DataBinder.Eval( Container.DataItem, "Active" )) ? "tabactiveleft" : "tabinactiveleft" %>'></div>
								<div class='<%# ((bool) DataBinder.Eval( Container.DataItem, "Active" )) ? "tabactive" : "tabinactive" %>'>
									<asp:LinkButton Runat=server OnCommand="Tab_Command" CommandArgument='<%# DataBinder.Eval( Container.DataItem, "TabIndex" ) %>' Text='<%# DataBinder.Eval( Container.DataItem, "TabName" ) %>' />
								</div>
								<div runat=server class='<%# ((bool) DataBinder.Eval( Container.DataItem, "Active" )) ? "tabactiveright" : "tabinactiveright" %>' ID="Td1"></div>
							</div>
						</span>
					</ItemTemplate>
				</asp:Repeater>
			</div>
		</div>
	</div>
</div>
