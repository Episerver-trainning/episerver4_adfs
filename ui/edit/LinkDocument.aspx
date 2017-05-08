<%@ Page language="c#" Codebehind="LinkDocument.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.LinkDocument" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerUtil" TagName="LinkToolbar" Src="~/Util/LinkToolbar.ascx"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>LinkDocument</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/linkeditor.css">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script> 
  </head>
  <body MS_POSITIONING="GridLayout" XmlNs:EPiServer="http://schemas.episerver.com/WebControls" onloadx="document.body.innerText = document.body.innerHTML;">

    <form id="LinkDocument" encType="multipart/form-data" method="post" runat="server">

		<div id="titleBar">
			<episerver:translate text="#heading" runat="Server"/>
		</div>

		<div style="padding-left:5px;width:550px;overflow:hidden;">

			<div style="width:99%;height:150px;">
				<div style="width:99%;">
					<EPiServerUtil:LinkToolbar id="linkToolbar" runat="server"/>
				</div>
				<div id="linkTree" style="float:left;width:180px;">
					<EPiServerSys:directoryexplorer runat="server" id="directoryExplorer" />
				</div>
				<div id="fileList" style="width:354px;">
					<EPiServerSys:filelist runat="server" id="fileLister" />
				</div>
			</div>
		
			<div style="padding-bottom:3px;padding-top:5px;<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? "display:none;" : String.Empty%>">
				<div style="float:left;width:133px;">
					<episerver:translate text="/util/linkeditor/textfieldcaption" runat="Server"/>
				</div>
				<div>
					<asp:textbox id="linkText" CssClass="TextBox" runat="server"/>
				</div>
			</div>

			<div style="padding-bottom:3px;<%=!((EPiServer.Util.LinkBase)Page).DisplayLinkTitle ? "display:none" : String.Empty%>">
				<div style="float:left;width:133px;">
					<episerver:translate text="/util/linkeditor/linktitlefieldcaption" runat="Server"/>
				</div>
				<div>
					<asp:textbox id="titleText" CssClass="TextBox" runat="server"/>
				</div>
			</div>
			<div<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? " style='display:none'" : String.Empty%>>
					<div style="float:left;width:133px;">
						<episerver:translate text="/util/linkeditor/targetfieldcaption" runat="Server"/>
					</div>
					<div>
						<asp:DropDownList id="linkFrame" Runat="server"/>
					</div>
				</div>

			<fieldset id="uploadArea" runat="Server">
				<legend style="color: black"><episerver:translate text="/util/linkeditor/douploadcaption" runat="Server"/>&nbsp;(<%=RenderMaxUploadSize()%>)&nbsp;</legend>
				<div style="padding-top:2px; padding-bottom:3px;">
					<div style="width:127px;float:left;">
						<episerver:translate text="/util/linkeditor/filefieldcaption" runat="Server"/>
					</div>
					<div style="width:98%;">
						<input type="file" Class="TextBox" runat="server" ID="UploadFile" NAME="UploadFile"/>
					</div>
				</div>
			</fieldset>			

		</div>

		<div id="LinkToolButtonArea">
			<asp:button ID="insertButton" Translate="/button/insert" Runat="server" />
			<input type="button" ID="clearButton" Translate="/button/clear" Runat="Server" onclick="returnValue='|';window.close();" />
			<input type="button" ID="cancelButton" Translate="/button/cancel" Runat="Server" onclick="window.close()" />
		</div>

     </form>

  </body>
</html>
