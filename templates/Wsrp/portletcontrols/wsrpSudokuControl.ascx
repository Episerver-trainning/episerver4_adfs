<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpSudokuControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.wsrpSudokuControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Sudoku" Namespace="development.Templates.Wsrp.PortletControls.Util" Assembly="EPiServerSample" %>
<asp:PlaceHolder runat="server" ID="View">
	<form action="thispage.aspx" method="post">
		<p>
			<a href="<%= CurrentPage.LinkURL %>&action=generate">Generate a new one</a><br>
		</p>
		<Sudoku:SudokuControl runat="server" ID="SudokuControl" />
		<p>
			<input type="submit" id="check" name="check" value="Check" />
		</p>
	</form>
</asp:PlaceHolder>
