<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XFormToolbox.ascx.cs" Inherits="EPiServer.Edit.XFormToolbox" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="EPiServer.Core" %>
<table class="EPEdit-tableColumn" id="Toolbox" style="POSITION: relative">
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Text.gif" id="__imagetext" type="text" style="cursor: move;" id="id_text" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputtext")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Textarea.gif" id="__imagetextarea" type="textarea" style="cursor: move;" id="id_textarea" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputtextarea")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Select.gif" id="__imageselect" type="select" style="cursor: move;" id="id_select" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputselectbox")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Radio.gif" id="__imageradio" type="radio" style="cursor: move;" id="id_radio" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputradiobutton")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Checkbox.gif" id="__imagecheckbox" type="checkbox" style="cursor: move;" id="id_checkbox" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputcheckbox")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Button.gif" id="__imagesubmit" type="submit" style="cursor: move;" id="id_span" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputsubmit")%></td>
	</tr>
	<tr>
		<td valign="top"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/xform/Caption.gif" id="__imagespan" type="span" style="cursor: move;" id="id_span" onmousedown="fieldStartDrag(this)"></td>
		<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/inputdescription")%></td>
	</tr>
</table>
<script type='text/javascript'>
<!--
window.onscroll = positionToolbox;
var __tooboxOrgPosTop = null;

function positionToolbox()
{
	var sTop = document.body.scrollTop;
	if (__tooboxOrgPosTop == null)
		__tooboxOrgPosTop = Toolbox.offsetTop;
	if (sTop <= __tooboxOrgPosTop)
	{
		Toolbox.style.posTop = 0;
		return;
	}
	Toolbox.style.posTop = sTop - __tooboxOrgPosTop;
	id_propertiestext.style.posTop = Toolbox.style.posTop + Toolbox.style.height;
	id_propertiesmultiple.style.posTop = Toolbox.style.posTop + Toolbox.style.height;
	id_propertiestextarea.style.posTop = Toolbox.style.posTop + Toolbox.style.height;
	id_propertiesspan.style.posTop = Toolbox.style.posTop + Toolbox.style.height;
	id_propertiesbutton.style.posTop = Toolbox.style.posTop + Toolbox.style.height;
}
// -->
</script>
