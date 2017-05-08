<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FormFieldProperty.ascx.cs" Inherits="EPiServer.Edit.FormFieldProperty" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="EPiServer.Core" %>
<div id="id_propertiestext" class="EPEdit-formProperties" style="position:relative;display: none;">
<table class="EditPage" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top" colspan="2" class="EPEdit-formPropertyTitle"><b><%= EPiServer.Global.EPLang.Translate("/edit/editform/textinputproperties")%></b></td>
	</tr>
	<tr class="EPEdit-row">
		<td style="width: 100px" class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%></td>
		<td style="width: 150px" class="EPEdit-columnValue"><input type="text" name="__textname" value=""></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/widthcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__textsize" value=""></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="checkbox" id="__textrequired" value=""></td>
	</tr>	
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__textclass" value="" maxlength="255"></td>
	</tr>	
</table>
<br>
<button onclick="fieldPropertiesTextSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>

<div id="id_propertiesmultiple" class="EPEdit-formProperties" style="position:relative;display: none;">
<table class="EditPage" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top" colspan="2" class="EPEdit-formPropertyTitle"><b><div id="id_headingmultiple"><%= EPiServer.Global.EPLang.Translate("/edit/editform/checkboxproperties")%></div></b></td>
	</tr>
	<tr class="EPEdit-row">
		<td style="width: 100px" class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%>:</td>
		<td style="width: 150px" class="EPEdit-columnValue"><input type="text" id="__multiplename" value></td>
	</tr>
	<tr class="EPEdit-row" id="id_verticallayout">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/placementcaption")%>:</td>
		<td class="EPEdit-columnValue">
					<input type="radio" name="__multiplelayout" checked id="__multiplelayouthorizontal"><%=EPiServer.Global.EPLang.Translate("/edit/editform/horizontal")%><br>
					<input type="radio" name="__multiplelayout" id="__multiplelayoutvertical"><%=EPiServer.Global.EPLang.Translate("/edit/editform/vertical")%>
		</td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/optionscaption")%></td>
		<td class="EPEdit-columnValue"><textarea name="__multipleoptions" rows="4" cols="20"></textarea>
	</tr>
	<tr class="EPEdit-row" style="display:none">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="checkbox" id="__multiplerequired" value></td>
	</tr>	
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__multipleclass" value="" maxlength="255"></td>
	</tr>	

</table>
<br>
<button onclick="fieldPropertiesMultipleSave()" id=button1 name=button1><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>

<div id="id_propertiestextarea" class="EPEdit-formProperties" style="position:relative;display: none;">
<table class="EditPage" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top" colspan="2" class="EPEdit-formPropertyTitle"><b><%= EPiServer.Global.EPLang.Translate("/edit/editform/textareaproperties")%></b></td>
	</tr>
	<tr class="EPEdit-row">
		<td style="width: 100px" class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%>:</td>
		<td style="width: 150px" class="EPEdit-columnValue"><input type="text" id="__textareaname" value></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/widthcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__textareawidth" value></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/heightcaption")%></td>
		<td class="EPEdit-columnValue"><input type="text" id="__textareaheight" value></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="checkbox" id="__textarearequired" value></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__textareaclass" value="" maxlength="255"></td>
	</tr>	
</table>
<br>
<button onclick="fieldPropertiesTextareaSave()" id="button7" name="button7"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>
<div id="id_propertiesspan" class="EPEdit-formProperties" style="position:relative;display: none;">
<table class="EditPage" cellspacing="0" cellpadding="2">
	<tr>
		<td valign="top" colspan="2" class="EPEdit-formPropertyTitle"><b><%= EPiServer.Global.EPLang.Translate("/edit/editform/descriptionproperties")%></b></td>
	</tr>
	<tr class="EPEdit-row">
		<td style="width: 100px" class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/textcaption")%>:</td>
		<td style="width: 150px" class="EPEdit-columnValue"><input type="text" name="__spanvalue" value maxlength="255"></td>
	</tr>
	<tr class="EPEdit-row">
		<td class="EPEdit-columnCaption"><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
		<td class="EPEdit-columnValue"><input type="text" id="__spanclass" value="" maxlength="255"></td>
	</tr>	
</table>
<br>
<button onclick="fieldPropertiesSpanSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>
