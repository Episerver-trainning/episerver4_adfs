<%@ Page language="c#" Codebehind="LinkImage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.LinkImage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerUtil" TagName="LinkToolbar" Src="~/Util/LinkToolbar.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>LinkImage</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/linkeditor.css">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="LinkImage" encType="multipart/form-data" method="post" runat="server">

		<div id="titleBar">
			<episerver:translate text="#heading" runat="Server"/>
		</div>

		<div style="padding-left:5px;width:550px;overflow:hidden;">

			<div style="width:99%;height:150px;">
				<div style="width:99%;">
					<EPiServerUtil:LinkToolbar id="linkToolbar" runat="server"/>
				</div>
				<div id="linkTree" style="float:left;width:180px;">
					<EPiServerSys:directoryexplorer TargetFileList='<%#fileLister%>' runat="server" id="directoryExplorer" />
				</div>
				<div id="fileList" style="width:354px;">
					<EPiServerSys:filelist EnableImagePreview="True" runat="server" id="fileLister" Extensions='<%#DefaultImageExtensions%>' />
				</div>
			</div>
			
			<div style="padding-bottom:3px;padding-top:5px;<%=((EPiServer.Util.LinkBase)Page).OnlyDisplayUrl ? "display:none;" : String.Empty%>">
					<div style="float:left;width:130px;">
						<episerver:translate text="/util/linkeditor/alttextfieldcaption" runat="Server"/>
					</div>
					<div style="float:left;">
						<asp:textbox CssClass="TextBox" Width="407px" ID="linkText" Runat="server"/>
					</div>
				</div>
		
			<fieldset id="uploadArea" runat="Server">
				<legend style="color: black"><episerver:translate text="/util/linkeditor/douploadcaption" runat="Server"/>&nbsp;(<%=RenderMaxUploadSize()%>)&nbsp;</legend>
				<div style="padding-top:2px; padding-bottom:3px;">
					<div style="width:127px;float:left;">
						<episerver:translate text="/util/linkeditor/filefieldcaption" runat="Server"/>
					</div>
					<div style="width:96%;">
						<input type="file" Class="TextBox" runat="server" ID="UploadFile" NAME="UploadFile"/>
					</div>
				</div>
			</fieldset>			
		</div>

		<div id="LinkToolButtonArea">
			<asp:button ID="insertButton" NAME="insertButton" CssClass="accept" Translate="/button/insert" Runat="server" />
			<input type="button" ID="clearButton" class="neutral" Translate="/button/clear" Runat="server" onclick='returnValue="|";window.close()'/>
			<asp:button ID="cancelButton" CssClass="decline" Translate="/button/cancel" Runat="server"/>
		</div>

     </form>
	
  </body>
</html>
