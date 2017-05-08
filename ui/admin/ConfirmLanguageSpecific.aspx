<%@ Page language="c#" Codebehind="ConfirmLanguageSpecific.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ConfirmLanguageSpecific" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title><%=Translate("#title")%></title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type="text/javascript">

		window.returnValue=false;
		
		function CheckStatus()
		{
			if(<%=foundProps ? "true" : "false"%>)
			{
				warningGui.style.display='';
				checkingGui.style.display='none';
			}
			else
			{
				window.returnValue=true;
				window.close();
			}
			
		}		
		
		</script>
</HEAD>
	<body onload="CheckStatus();">
		<form id="RemoveLanguageSpecific" method="post" runat="server">
		
			<div id="checkingGui">
				<h1><EPiServer:Translate Text="/pleasewait" runat="server"/>..</h1>
			</div>
			<div id="warningGui" style="display: none">
				<EPiServerSys:systemprefix id="pagePrefix" runat="server"/>
				<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server"/></p>
				
						    
				<input type="button" onclick="window.returnValue=true;window.close();" Translate="/button/continue" Runat="server" ID="Button1"></asp:Button>
				<input type="button" onclick="window.returnValue=false;window.close();" Translate="/button/cancel" Runat="server" ID="Button2"></asp:Button>

				<h2><EPiServer:Translate Text="#pagelist" runat="server" ID="pageListText"/></h2>
				<asp:Repeater Runat="server" ID="referenceListPublished">
			    
					<ItemTemplate>
						<div>
							<a target="_blank" href="<%#Configuration.RootDir + Configuration.EditDir + "Default.aspx?id=" + DataBinder.Eval(Container.DataItem,"PageID")%>"><%#DataBinder.Eval(Container.DataItem,"Name")%> (<%#DataBinder.Eval(Container.DataItem,"LanguageBranchName")%>) [<%#DataBinder.Eval(Container.DataItem,"PageID")%>]</a>
						</div>
					</ItemTemplate>
			    
				</asp:Repeater>
			    
			</div>
     </form>
	
  </body>
</html>
