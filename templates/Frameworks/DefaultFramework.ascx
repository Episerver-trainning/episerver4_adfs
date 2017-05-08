<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DefaultFramework.ascx.cs" Inherits="development.Frameworks.DefaultFramework" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header"		Src="~/templates/Units/Header.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing"		Src="~/templates/Units/Listing.ascx"%>
<%@ Register TagPrefix="development" TagName="TopMenu"		Src="~/templates/Units/TopMenu.ascx"%>
<%@ Register TagPrefix="development" TagName="LeftMenu"		Src="~/templates/Units/Menu.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"		Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="PageHeader"	Src="~/templates/Units/PageHeader.ascx"%>
<%@ Register TagPrefix="development" TagName="Print"		Src="~/templates/Units/PrintFunctions.ascx"%>
<%@ Register TagPrefix="development" TagName="QuickBar"		Src="~/templates/Units/QuickBar.ascx"%>
<%@ Register TagPrefix="development" TagName="RightListing"	Src="~/templates/Units/RightListing.ascx"%>
<%@ Register TagPrefix="development" TagName="WriterInfo"	Src="~/templates/Units/WriterInfo.ascx"%>
<%@ Register TagPrefix="development" TagName="BreadCrumbs"	Src="~/templates/Units/BreadCrumbs.ascx"%>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head runat="server">
		<development:header ID="Header" runat="server" />
		<development:print	ID="Print" runat="server" />
	</head>
	<body class="normalpage" xmlns:EPiServer="http://schemas.episerver.com">
		<form Runat="server" ID="Default" enctype="multipart/form-data" class="centered">
			<div id="containerdiv">
			
				<div id="headerdiv">
					<a href="#content" accesskey="S" />
					<a href="<%=EPiServer.Global.EPConfig.RootDir%>" accesskey="1"><img src="<%=HeaderImage%>" width="100%" alt="<%=HeaderImageDescription%>" /></a>
					<div id="quickbardiv">
						<development:quickbar runat="server" />
					</div>
				</div>
				
				<div id="topmenudiv">
					<development:TopMenu runat="server" ID="TopMenu" />
				</div>
				
				<div id="maincontainerdiv">									
					<div>
						<EPiServer:Region ID="fullRegion" runat="server">
							
							<div id="leftmenudiv">
								<EPiServer:Region ID="menuRegion" runat="server">
									<development:LeftMenu runat="server" ID="LeftMenu" />								
								</EPiServer:Region>
							</div>
							
							<div id="contentdiv">
								<development:BreadCrumbs StartPageName="/templates/common/startpage" runat="server" /><br/><br/>
								<EPiServer:Region ID="mainAndRightRegion" runat="server">		
									
									<div id="mainareadiv" class="normalwidth">
										<a id="content"></a>
										<EPiServer:Region ID="mainRegion" runat="server">
											<div>
												<div id="voicearea">
													<development:PageHeader ID=pageheader runat="server" />
													<development:PageBody ID=pagebody runat="server" />
													<br />
													<EPiServer:Region ID="addRegion" runat="server" />
												</div>
												<development:listing ID="Listing" runat="server" />
											</div>
										</EPiServer:Region>
									</div>

									<div id="rightmenudiv">
										<EPiServer:Region ID="rightColumnRegion" runat="server">
											<EPiServer:Region ID="RightListingArea" runat="server">
												<development:rightlisting ID="RightListing" runat="server" />
											</EPiServer:Region>
										</EPiServer:Region>
									</div>
									
								</EPiServer:Region>						
							</div>
							
						</EPiServer:Region>
					</div>
				</div>
								
				<div id="footerdiv">
					<div class="footerleftcornerdiv"></div>
					<div id="footermaindiv">
					<EPiServer:Region ID="footerRegion" runat="server">
						<div id="footerleftdiv">
							Copyright &copy; <%=DateTime.Now.Year%> EPiServer AB
						</div>
						<div id="footermiddlediv">
							<a href="http://www.episerver.com" class="linklist">www.episerver.com</a>
						</div>
						<div id="footerrightdiv">
							<EPiServer:Region ID="footerRightColumnRegion" runat="server">
								<development:WriterInfo ID="WriterInfo" runat="server" />
							</EPiServer:Region>
						</div>
					</EPiServer:Region>
					</div>
					<div class="footerrightcornerdiv"></div>
				</div>
				
			</div>
			<EPiServer:LogGenerator runat="server" ID="PixelImg" />
		</form>
	</body>
</html>