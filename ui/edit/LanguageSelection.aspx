<%@ Page language="c#" Codebehind="LanguageSelection.aspx.cs" AutoEventWireup="false" Inherits="EPiServerGUI.Edit.LanguageSelection" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>LanguageSelection</title>
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body class="EPEdit-languageSelectionBody">
    <form id="Form1" method="post" runat="server">
		<EPiServerSys:LanguageDropDownList AutoSelectLanguage="True" JavascriptCallback="parent.SelectNewLanguage" RenderTopAligned="True" id="languageDropDrop" runat="server" />
     </form>
  </body>
</html>