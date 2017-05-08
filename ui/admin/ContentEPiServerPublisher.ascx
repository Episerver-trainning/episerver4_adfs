<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ContentEPiServerPublisher.ascx.cs" Inherits="EPiServer.Admin.ContentEPiServerPublisher" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#remotesite" runat="server" ID="Translate4"/>
			</td>
			<td>
				<asp:DropDownList ID="RemoteSite" Runat="server"/>
				<asp:RequiredFieldValidator ID="Requiredfieldvalidator2"
							ErrorMessage="*"
							Display="Static"
							ControlToValidate="RemoteSite"
							EnableClientScript = "True"
							Runat="server"/>
			</td>
			</tr>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#topagelink" runat="server" ID="Translate3"/>
			</td>
			<td>
				<asp:TextBox ID="ToPageLink" Runat="server"></asp:TextBox>
				<asp:RequiredFieldValidator ID="Requiredfieldvalidator1"
					ErrorMessage="Must enter a target page"
					ControlToValidate="ToPageLink"
					EnableClientScript = "false"
					Display="None"
					Runat="server"/>
				<asp:RegularExpressionValidator id="RegularExpressionValidator1" 
						ControlToValidate="ToPageLink"
						ValidationExpression="\d+"
						ErrorMessage="Enter a Page ID"
						EnableClientScript = "false"
						Display="None"
						runat="server"/>
			</td>
			</tr>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#instantpublish" runat="server" ID="Translate1"/>
			</td>
			<td>
				<asp:CheckBox Checked="True" ID="InstantPublish" Runat="server"/>
			</td>
			</tr>
						<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#linktootherchannels" runat="server" ID="Translate2"/>
			</td>
			<td>
				<asp:CheckBox Checked="True" ID="LinkToOtherChannels" Runat="server"/>
			</td>
			</tr>