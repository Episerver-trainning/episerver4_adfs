<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditPageControl.ascx.cs" Inherits="EPiServer.Edit.EditPageControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
		<br />
		<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SaveTool.gif"			ID="SaveOnly"		Text="/button/saveonly"	ToolTip="/edit/editpanel/tooltipsaveonly"		runat="server" />
		<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SaveShowTool.gif"		ID="Save"			Text="/button/saveandview"	ToolTip="/edit/editpanel/tooltipsave"		runat="server" />
		<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SavePublishTool.gif"	ID="SaveAndPublish" Name="Publish"	Text="/button/saveandpublish"	ToolTip="/edit/editpanel/tooltipapprove"	RequiredAccess="Publish" runat="server" />
		<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/Cancel.gif"				ID="Cancel"			Name="Cancel"	Text="/button/cancel"	ToolTip="/edit/editpanel/tooltipcancel" runat="server"/>
		<br />
		<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server" DisplayMode="BulletList" /></p>
		<div id="editformarea">
			<EPiServerSys:propertydataform id="EditForm" runat="server" AutoLoadTabs="true" ShowLanguageIndication="true" />
		</div>
		<script type="text/javascript">
			function leavePage()
			{
				var eventTarget = document.all['__EVENTTARGET'];

				if (eventTarget != null && eventTarget.value!='')
				{
					if (eventTarget.value != 'Cancel' && eventTarget.value.indexOf('actionTab:')<0)
						return;
					else
						window.onerror = HidePostbackError;	
				}

				// window.confirmNavigateMessage holds translated text, defined in edit/EditPanel.aspx.
				event.returnValue = window.confirmNavigateMessage;
			}
			
			function SetFocus()
			{
				if(<%= IsNewPage ? "true" : "false" %>)
				{
					var editFormArea = document.getElementById('editformarea');
					if(editFormArea)
					{
						var firstField = editFormArea.getElementsByTagName('INPUT')[0];
						if(firstField)
						{
							try
							{
								firstField.focus();
							}
							catch(e)
							{
							}
						}
					}
				}
			}

			window.attachEvent('onload', SetFocus);

		</script>