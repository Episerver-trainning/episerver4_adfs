<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FormControl.ascx.cs" Inherits="EPiServer.Edit.FormControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="EPiServer.Core" %>
<input type="hidden" name="__formid" id="FormID" runat="server" />
<input type="hidden" name="__forminfofield" id="FormInfoField" runat="server" />
<input type="hidden" name="__formvaluefield" id="FormValueField" runat="server" />
<input type="hidden" name="__newver" id="NewVersion" runat="server" />

<table class="EditPage" cellspacing="1" cellpadding="0" width="100%">
	<tr>
		<td><EPiServer:Translate text="/edit/editform/formnamecaption"  runat="server"/></td>
		<td><input type="text" name="__formname" id="FormName" runat="server">
					<asp:RequiredFieldValidator ID="RequiredCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="FormName"
					Runat="server"/>
		</td>
	</tr>
	<tr>
		<td><EPiServer:Translate text="/edit/editform/postresultcaption" runat="server" /></td>
		<td>
			<select name="__formaction" onchange="formActionChange(this)" id="FormAction" runat="server">
			</select>
		</td>
	</tr>
	<tr id="__cellemailrecipient" runat="server">
		<td><EPiServer:Translate text="/edit/editform/sendemailtoadresscaption" runat="server"/></td>
		<td><input type="text" name="__formemailrecipient" id="FormEmailRecipient" runat="server" /><span id="requiredEmail1" style="color: red"></span></td>
	</tr>
	<tr id="__cellemailsender" runat="server">
		<td><EPiServer:Translate text="/edit/editform/sendemailfromadresscaption" runat="server" /></td>
		<td><input type="text" name="__formemailsender" id="FormEmailSender" runat="server" /><span id="requiredEmail2" style="color: red"></span></td>
	</tr>
	<tr id="__cellcustomurl" runat="server">
		<td><EPiServer:Translate text="/edit/editform/sendformtourlcaption" runat="server" ID="Translate1" NAME="Translate1"/></td>
		<td><input type="text" name="__formcustomurl" id="FormCustomUrl" runat="server" /></td>
	</tr>
	<tr id="__cellpageafterpost" runat="server">
		<td><EPiServer:Translate text="/edit/editform/pageafterpost" runat="server" ID="Translate2" NAME="Translate2"/></td>
		<td><EPiServer:Property id="FormPageAfterPost" runat="server" /></td>
	</tr>
	<tr>
		<td><EPiServer:Translate text="/edit/editform/allowanonymouspostcaption" runat="server" /></td>
		<td><input type="checkbox" name="__formanonymouspost" value="1" id="FormAnonymousPost" runat="server" /></td>
	</tr>
	<tr>
		<td><EPiServer:Translate text="/edit/editform/allowmultiplepostcaption" runat="server" /></td>
		<td><input type="checkbox" name="__formmultiplepost" value="1" id="FormMultiplePost" runat="server" /></td>
	</tr>
	<tr>
		<td colspan="2"><br>
			<input type="submit" name="__formsave" translate="/button/save" onclick="if(formValid())formPopulateForSubmit(this.form);" runat="server" id="SaveButton" />
			<input type="submit" CausesValidation="False" name="__formdelete" translate="/button/delete" id="DeleteButton" runat="server" />
			<input type="submit" CausesValidation="False" name="__formcancel" translate="/button/cancel" id="CancelButton" runat="server" />
		</td>
	</tr>
</table>
