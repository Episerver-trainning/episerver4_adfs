<%@ Page language="c#" Codebehind="ConvertFormToXForm.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ConvertFormToXform" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Convert Form To XForm</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
	<EPiServerSys:SystemPrefix 
		id="PagePrefix" 
		runat="server" 
		Description="/admin/convertformtoxform/description"/>
		<form 
			id="ImportData" 
			encType="multipart/form-data" 
			method="post" 
			runat="server">
		<table>
			<tr>
				<td>
					<EPiServer:Translate	
						Text="/admin/convertformtoxform/availableforms" 
						runat="server" 
						ID="TranslateAvailableForms"/>
				</td>
				<td>	
					<EPiServer:Translate	
						Text="/admin/convertformtoxform/availablexforms" 
						runat="server" 
						ID="TranslateAvailableXForms"/>
				</td>
			</tr>
			<tr>
				<td>
					<asp:ListBox id="AvailableForms" 
						Rows="20"
						Width="200px"
						SelectionMode="Multiple" 
						runat="server" />
				</td>
				<td>
					<asp:ListBox id="AvailableXForms" 
						Rows="20"
						Width="200px"
						SelectionMode="Multiple" 
						
						runat="server" />
				</td>
			</tr>
		</table>
		<br>
   		<asp:Button 
   			runat="server" 
   			Translate="/admin/convertformtoxform/convert" 
   			id="ConvertButton"	
   			OnClick="Convert"/>			
     </form>
  </body>
</html>
