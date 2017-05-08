<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.DefaultPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<EPiServer:ContentFrameworkSelector runat="server" FrameworkKeyName="MyMode" ID="Contentframeworkselector" DefaultFramework="Default">
	<EPiServer:ControlLoader ID="Default"			runat="Server" Src="~/edit/Frameworks/EditFramework.ascx" />
	<EPiServer:ControlLoader ID="SimpleEditMode"	runat="Server" Src="~/edit/Frameworks/QuickEditFramework.ascx" />
	<EPiServer:ControlLoader ID="CreatePage"		runat="Server" Src="~/edit/Frameworks/CreatePageFramework.ascx" />
</EPiServer:ContentFrameworkSelector>