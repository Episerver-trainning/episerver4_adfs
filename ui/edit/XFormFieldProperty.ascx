<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XFormFieldProperty.ascx.cs" Inherits="EPiServer.Edit.XFormFieldProperty" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="EPiServer.Core" %>
<div id="id_propertiestext" class="EPEdit-formProperties" style="position:relative;display: none;" onpropertychange="ClearError( '___errortext' );">
	<div id="___errortext" class="EP-systemMessage">
		<table width='100%'>
			<tr>
				<td><img src='<% =EPiServer.Global.EPConfig.RootDir + "Util/images/warning.gif"%>' /></td>
				<td><span id='___errortext_text'></span></td>
			</tr>
		</table> 
	</div>
	
	<table>
		<tr>
			<td valign="top" colspan="2">
				<h3 class="compactheading"><%= EPiServer.Global.EPLang.Translate("/edit/editform/textinputproperties")%></h3>
			</td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textname"  /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/headingcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textlabel" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/tooltipcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__texttooltip" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/widthcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textsize" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
			<td><input type="checkbox" id="__textrequired" /></td>
		</tr>	
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textclass" maxlength="255" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/typecaption")%>:</td>
			<td><select Runat="server" id="InputType"></select></td>
		</tr>
	</table>
	<br>
	<button onclick="if( validateName( '__textname', '___errortext' ) ) fieldPropertiesTextSave() "><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
	&nbsp;<button onclick="ClearError( '___errortext' ); fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editxform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
	&nbsp;<button onclick="ClearError( '___errortext' ); fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>

<div id="id_propertiesmultiple" class="EPEdit-formProperties" style="position:relative;display: none;" onpropertychange="ClearError( '___errormultiple' );" >
	<div id="___errormultiple" class="EP-systemMessage">
		<table width='100%'>
			<tr>
				<td><img src='<% =EPiServer.Global.EPConfig.RootDir + "Util/images/warning.gif"%>' /></td>
				<td><span id='___errormultiple_text'></span></td>
			</tr>
		</table> 
	</div>
	
	<table>
		<tr>
			<td valign="top" colspan="2"><h3 class="compactheading" id="id_headingmultiple"><%= EPiServer.Global.EPLang.Translate("/edit/editform/checkboxproperties")%></h3></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%>:</td>
			<td><input type="text" class="inputtext" id="__multiplename" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/headingcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__multiplelabel" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/tooltipcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__multipletooltip" /></td>
		</tr>
		<tr id="id_verticallayout">
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/placementcaption")%>:</td>
			<td>
				<input type="radio" name="__multiplelayout" checked id="__multiplelayouthorizontal" /><%=EPiServer.Global.EPLang.Translate("/edit/editform/horizontal")%><br>
				<input type="radio" name="__multiplelayout" id="__multiplelayoutvertical" /><%=EPiServer.Global.EPLang.Translate("/edit/editform/vertical")%>
			</td>
		</tr>
		<tr>
			<td valign="top"><%= EPiServer.Global.EPLang.Translate("/edit/editform/optionscaption")%>:</td>
			<td><textarea class="inputtext" id="__multipleoptions" rows="4" cols="20"></textarea></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
			<td><input type="checkbox" id="__multiplerequired"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__multipleclass" maxlength="255" /></td>
		</tr>	
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/typecaption")%>:</td>
			<td><select Runat="server" id="MultipleType"></select></td>
		</tr>
	</table>
	<br>
	<button onclick="if( validateMultiple( '__multiplename', '___errormultiple' ) ) fieldPropertiesMultipleSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
	&nbsp;<button onclick="ClearError( '___errormultiple' ); fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
	&nbsp;<button onclick="ClearError( '___errormultiple' ); fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>

<div id="id_propertiestextarea" class="EPEdit-formProperties" style="position:relative;display: none;" onpropertychange="ClearError( '___errortextarea' );">
	<div id="___errortextarea" class="EP-systemMessage">
		<table width='100%'>
			<tr>
				<td><img src='<% =EPiServer.Global.EPConfig.RootDir + "Util/images/warning.gif"%>' /></td>
				<td><span id='___errortextarea_text'></span></td>
			</tr>
		</table> 
	</div>
	<table>
		<tr>
			<td valign="top" colspan="2">
				<h3 class="compactheading"><%= EPiServer.Global.EPLang.Translate("/edit/editform/textareaproperties")%></h3>
			</td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/namecaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textareaname"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/headingcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textarealabel" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/tooltipcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textareatooltip" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/widthcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textareawidth"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/heightcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textareaheight"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/requiredcaption")%>:</td>
			<td><input type="checkbox" id="__textarearequired"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__textareaclass" maxlength="255"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/typecaption")%>:</td>
			<td><select Runat="server" id="TextareaType"></select></td>
		</tr>
	</table>
	<br>
	<button onclick="if( validateName( '__textareaname', '___errortextarea' ) ) fieldPropertiesTextareaSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
	&nbsp;<button onclick="ClearError( '___errortextarea' ); fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
	&nbsp;<button onclick="ClearError( '___errortextarea' ); fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>
<div id="id_propertiesspan" class="EPEdit-formProperties" style="position:relative;display: none;" onpropertychange="ClearError( '___errorspan' );">
	<div id="___errorspan" class="EP-systemMessage">
		<table width='100%'>
			<tr>
				<td><img src='<% =EPiServer.Global.EPConfig.RootDir + "Util/images/warning.gif"%>' /></td>
				<td><span id='___errorspan_text'></span></td>
			</tr>
		</table> 
	</div>
	<table>
		<tr>
			<td valign="top" colspan="2">
				<h3 class="compactheading"><%= EPiServer.Global.EPLang.Translate("/edit/editform/descriptionproperties")%></h3>
			</td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/textcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__spanvalue" maxlength="255"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__spanclass" maxlength="255"></td>
		</tr>	
	</table>
	<br>
	<button onclick="if( validateSpan( '__spanvalue', '___errorspan' ) ) fieldPropertiesSpanSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
	&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
	&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>
<div id="id_propertiesbutton" class="EPEdit-formProperties" style="position:relative;display: none;">
	<table>
		<tr>
			<td valign="top" colspan="2">
				<h3 class="compactheading"><%= EPiServer.Global.EPLang.Translate("/edit/editform/buttonproperties")%></h3>
			</td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/buttoncaption")%>:</td>
			<td><input type="text" class="inputtext" id="__buttonlabel" maxlength="255"></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/tooltipcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__buttontooltip" /></td>
		</tr>
		<tr>
			<td><%= EPiServer.Global.EPLang.Translate("/edit/editform/classcaption")%>:</td>
			<td><input type="text" class="inputtext" id="__buttonclass" maxlength="255"></td>
		</tr>
		<tr>
			<td><EPiServer:Translate text="/edit/editform/postresultcaption" runat="server" />:</td>
			<td>
				<select onchange="formActionChange(this)" id="SubmitAction" runat="server" class="inputtext" />
			</td>
		</tr>
		<tr id="EmailRecipientRow" runat="server">
			<td><EPiServer:Translate text="/edit/editform/sendemailtoadresscaption" runat="server" />:</td>
			<td><input type="text" id="FormEmailRecipient" class="inputtext" /><span id="requiredEmail1" style="color: red" /></td>
		</tr>
		<tr id="EmailSenderRow" runat="server">
			<td><EPiServer:Translate text="/edit/editform/sendemailfromadresscaption" runat="server" />:</td>
			<td><input type="text" id="FormEmailSender" class="inputtext" /><span id="requiredEmail2" style="color: red" /></td>
		</tr>
		<tr id="EmailSubjectRow" runat="server">
			<td><EPiServer:Translate text="/edit/editform/sendemailsubjectcaption" runat="server" />:</td>
			<td><input type="text" id="FormEmailSubject" class="inputtext" /><span id="requiredEmail3" style="color: red" /></td>
		</tr>
		<tr id="CustomUrlRow" runat="server">
			<td><EPiServer:Translate text="/edit/editform/sendformtourlcaption" runat="server" />:</td>
			<td><input type="text" id="FormCustomUrl" class="inputtext" /></td>
		</tr>
	</table>
	<br>
	<button onclick="fieldPropertiesSubmitSave()"><%= EPiServer.Global.EPLang.Translate("/button/save")%></button>
	&nbsp;<button onclick="fieldPropertiesDelete('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editform/confirmdelete")%>')"><%=EPiServer.Global.EPLang.Translate("/button/delete")%></button>
	&nbsp;<button onclick="fieldPropertiesHideAll()"><%= EPiServer.Global.EPLang.Translate("/button/cancel")%></button>
</div>