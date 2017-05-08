<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Header.ascx.cs" Inherits="development.Templates.Units.Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Literal ID="MetaTagGenerator" Runat="server"/>
<title><%=GetTitleString()%></title>
<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/structure.css" />
<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/editor.css" />
<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/units.css" />
<episerver:FriendlyUrlRegistration  runat="Server" />