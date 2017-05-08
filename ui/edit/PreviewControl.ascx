<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PreviewControl.ascx.cs" Inherits="EPiServer.Edit.PreviewControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%
/*
	Ignore the 2 first onreadystatechange-events, because: event #1 is triggered after the iframe has been
	loaded, event #2 is triggered when the iframe preview contents has been loaded. Both these events are
	uninteresting when we are in edit mode. The 3rd event is the one we are interested in, since it is the
	event triggered by the preview control inside the iframe in edit.
*/
%>
<div Runat="server" ID="FirstLanguageDiv">
	<iframe id="PreviewFrame" SkipReadyStateEvents="2" width="100%" height="100%" Name="PreviewFrame" runat="server" 
		onreadystatechange="this.SkipReadyStateEvents > 0 ? this.SkipReadyStateEvents-- : previewNavigate(this)" />
</div>	
<div Runat="server" ID="SecondLanguageDiv" />