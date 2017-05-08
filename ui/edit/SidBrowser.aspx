<%@ Page language="c#" Codebehind="SidBrowser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.SidBrowser" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%=EPiServer.Global.EPLang.Translate("/edit/sidbrowser/heading")%></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/system.js"></script>
		<base target="_self">
	</HEAD>
	<body>
		<form id="SidBrowser" method="post" runat="server" onsubmit="return submitForm()" >
			<table>
				<tr>
					<td align="middle">
						<episerver:Translate Text="#orgsid" runat="server" id="Translate1" />
						<br>
						<select name="OrgSids" size="10" class="EPEdit-sidSelectList" ondblclick="SecMoveOption(document.all.OrgSids, document.all.AddSids)">
						<asp:Repeater ID="SidList" Runat="server" >
							<ItemTemplate>
								<option id="row_<%# DataBinder.Eval( Container.DataItem, "ID") %>" 
										value="<%# DataBinder.Eval( Container.DataItem, "ID" ) %>;<%# (int)DataBinder.Eval( Container.DataItem, "Type" ) %>">
									<%# DataBinder.Eval( Container.DataItem, "Name") %>
								</option>
							</ItemTemplate>
						</asp:Repeater>
						</select>
					</td>
					<td align="middle">
						<input class="EP-tinyButton" type="button" value=">" 
								onclick="SecMoveOption(document.all.OrgSids, document.all.AddSids)">
						<br>
						<input class="EP-tinyButton" type="button" value="<" 
								onclick="SecMoveOption(document.all.AddSids, document.all.OrgSids)">
					</td>
					<td align="middle">
						<episerver:Translate Text="#newsid" runat="server" id="Translate2" />
						<br>
						<select name="AddSids" <%=AllowMultiple ? "multiple" : ""%> size="<%=AllowMultiple ? "10" : "1"%>" 
								class="EPEdit-sidSelectList" ondblclick="SecMoveOption(document.all.AddSids, document.all.OrgSids)">
						</select>
					</td>
				</tr>
			</table>
			<p align="center">
				<input type="submit" name="SaveButton" class="EP-smallButton" value="     <%=Translate("/button/ok")%>     ">
				<input type="button" name="CancelButton" onclick="CancelForm()" class="EP-smallButton" value="   <%=Translate("/button/cancel")%>   ">
			</p>
		</form>
		<script type='text/javascript'>
		<!--
		function submitForm()
		{
			window.dialogArguments.addSids( document.all.AddSids );
			window.close();
		}
		function CancelForm()
		{
			window.close();
		}
		// -->
		</script>		
	</body>
</HTML>
