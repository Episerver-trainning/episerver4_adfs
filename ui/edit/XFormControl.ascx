<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XFormControl.ascx.cs" Inherits="EPiServer.Edit.XFormControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="EPiServer.Core" %>

<table class="EditPage" cellspacing="1" cellpadding="0" width="100%">
	<tr>
		<td>
			<asp:ListBox id="AvailableXForms" 
				Rows="20"
				Width="300px"
				SelectionMode="Single" 
				runat="server" />

		</td>
	</tr>
	<tr>
		<td colspan="2"><br>
			<input type="submit" name="__formsave" translate="/edit/editxformdata/useformbutton" onclick="if(formValid())formPopulateForSubmit(this.form);" runat="server" id="SaveButton" />
			<input type="submit" CausesValidation="False" name="__formdelete" translate="/edit/editxformdata/editbutton" id="DeleteButton" runat="server" />
			<input type="submit" CausesValidation="False" name="__formcancel" translate="/button/cancel" id="CancelButton" runat="server" />
		</td>
	</tr>
</table>

