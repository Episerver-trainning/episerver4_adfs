<%@ Control language="c#" Codebehind="PublishTask.ascx.cs" AutoEventWireup="false" Inherits="EPiServer.Workflow.Util.PlugIns.PublishTask" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiW" TagName="ApprovalTask" Src="ApprovalTask.ascx"%>
<EPiW:ApprovalTask id="approvalTask" DisplayActivity="True" runat="server"/>
