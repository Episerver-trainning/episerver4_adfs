<%@ Page CodeBehind="PdfForm.aspx.cs" Language="c#" AutoEventWireup="false" Inherits="development.Templates.PdfForm" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PdfForm"	Src="~/templates/Units/PdfForm.ascx"%>

<development:DefaultFramework ID="defaultframework" Runat="server">
	<EPiServer:Content Region="addRegion" Runat="server">		
		<development:PdfForm runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>