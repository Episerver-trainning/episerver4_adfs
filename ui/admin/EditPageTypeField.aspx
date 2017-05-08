<%@ Page language="c#" Codebehind="EditPageTypeField.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditPageTypeField" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>EditPageTypeField</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript'>
		
		var propertyToTypeLookup = new Array();
		var lookupCount = 0;
		
		<%=RenderPropertyToTypeLookup()%>
		
		function OnPageDefinitionTypeChange(obj)
		{
			var isLongString = propertyToTypeLookup[obj[obj.selectedIndex].value]==7;
			var isString = propertyToTypeLookup[obj[obj.selectedIndex].value]==6 || isLongString;
			LongStringSettingsRow1.style.display = isLongString ? '' : 'none';
			LongStringSettingsRow2.style.display = isLongString ? '' : 'none';
			if(document.forms[0]["Searchable"])
    			document.forms[0]["Searchable"].checked = isString;
    		if (document.forms[0]["DefaultValue"])
    		    document.forms[0]["DefaultValue"].maxLength = isLongString ? 300 : 100;
		}
				
		function ConfirmLanguageSpecific()
		{		
			if(<%=PageDefinitionData.LanguageSpecific ? "true" : "false"%> && !document.forms[0]['<%=LanguageSpecific.UniqueID%>'].checked)
				if(<%=PageDefinitionData.IsDynamicProperty ? "true" : "false"%>)
					return window.showModalDialog('ConfirmLanguageSpecific.aspx?id=<%=PageDefinitionData.ID%>&isDynamic=true','','dialogHeight:800px;dialogWidth:500px;');
				else
					return window.showModalDialog('ConfirmLanguageSpecific.aspx?id=<%=PageDefinitionData.ID%>','','dialogHeight:800px;dialogWidth:500px;');
			else
				return true;
		}
		
		</script>
</HEAD>
	<body>
		<form id="EditPageTypeField" method="post" runat="server">
			<EPiServerSys:systemprefix id="pagePrefix" runat="server"/>
			<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server"/></p>
			
			<episerversys:tabstrip TargetID="TabView" runat="server" id=Tabstrip1>
				<episerver:tab text="#info"/>
			</episerversys:tabstrip>
			<asp:Label ID="TabView" Runat="server">
			<asp:label Runat="server">			
			<table>
			<tr>
				<td>
					<episerver:translate Text="#namecaption" runat="server"/></td>
				<td>
					<asp:TextBox MaxLength="100" Size="50" ID="Name" CssClass="EPEdit-inputString" runat="server"/>
					<asp:RequiredFieldValidator ControlToValidate="Name" ErrorMessage="*" Runat="server"/>
					<EPiServer:XmlNameValidator ControlToValidate="Name" Runat="server" DisplayName="#namecaption" />
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#editcaption" runat="server"/></td>
				<td>
					<asp:TextBox MaxLength="255" Size="50" ID="EditCaption" CssClass="EPEdit-inputString" runat="server"/>
					<asp:RequiredFieldValidator ControlToValidate="EditCaption" ErrorMessage="*" Runat="server"/>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#helpcaption" runat="server"/></td>
				<td>
					<asp:TextBox MaxLength="2000" Size="50" ID="HelpText" CssClass="EPEdit-inputString" runat="server"/>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#typecaption" runat="server"/></td>
				<td>
					<EPiServer:InputPageDefinitionType id="PageDefinitionType" runat="server"/>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#advancedcaption" runat="server"/></td>
				<td>
					<EPiServer:InputTab id="Advanced" runat="server"/>
				</td>
			</tr>
			<asp:PlaceHolder id="PageTypeOnly" runat="server">
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>	
			<tr>
				<td>
					<episerver:translate Text="#defaultcaption" runat="server"/></td>
				<td>
					<input type="radio" ID="radioNoDefault" Name="DefaultValueType" Runat="server"/>
					<episerver:translate Text="#nodefaultcaption" runat="server"/><br>
					<input type="radio" ID="radioInherit" Name="DefaultValueType" Runat="server"/>
					<episerver:translate Text="#inheritcaption" runat="server"/><br>
					<input type="radio" ID="radioDefault" Name="DefaultValueType" Runat="server"/>
					<asp:TextBox MaxLength="100" Size="50" ID="DefaultValue" CssClass="EPEdit-inputString" runat="server"/>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#requiredcaption" runat="server"/></td>
				<td>
					<asp:CheckBox ID="Required" CssClass="EPEdit-inputBoolean" runat="server"/>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#searchablecaption" runat="server"/></td>
				<td>
					<asp:CheckBox ID="Searchable" CssClass="EPEdit-inputBoolean" runat="server"/>
				</td>
			</tr>
			</asp:PlaceHolder>		
			<tr>
				<td>
					<episerver:translate Text="#languagespecificcaption" runat="server"/></td>
				<td>
					<asp:CheckBox ID="LanguageSpecific" CssClass="EPEdit-inputBoolean" runat="server"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>	
			<tr id="LongStringSettingsRow1" runat="server">
				<td colspan="2">
					<episerver:translate Text="#editorhelp" runat="server"/>
				</td>
			</tr>
			<tr id="LongStringSettingsRow2" runat="server">
				<td colspan="2">
					<EPiServer:InputEditorOptions id="LongStringSettings" runat="server"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>	
			</table>
			</asp:label>
			</asp:Label>
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save" />
			<asp:Button id="DeleteButton" CausesValidation="False" Runat="server" translate="/button/delete" />
			<asp:Button id="CancelButton" CausesValidation="False" Runat="server" translate="/button/cancel" />
		</form>
	</body>
</HTML>
