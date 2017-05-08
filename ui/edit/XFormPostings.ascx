<%@ Control Language="c#" AutoEventWireup="false" Codebehind="XFormPostings.ascx.cs" Inherits="EPiServer.Edit.XFormPostings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />
<table>
	<tr>
		<td>
			<episerver:Translate Text="/edit/editxformdata/selectform" runat="server" />
		</td>
		<td>
			<asp:dropdownlist id="SelectForm" runat="server" />
		</td>
	</tr>
	<tr>
		<td>
			<episerver:Translate Text="/edit/editxformdata/fromdate" runat="server" />
		</td>
		<td>
			<episerver:property id="BeginDate" runat="server" PropertyName="MainXForm" />
		</td>
	</tr>
	<tr>
		<td>
			<episerver:Translate Text="/edit/editxformdata/todate" runat="server" />
		</td>
		<td>
			<episerver:property id="EndDate" runat="server" PropertyName="MainXForm" />
		</td>
	</tr>
	<tr>
		<td>
			<episerver:Translate Text="/edit/editxformdata/allpages" runat="server" />
		</td>
		<td>
			<asp:CheckBox ID="ShowResultFromAllPages" Runat="server" />
		</td>
	</tr>
	<tr>
		<td>
			<episerver:Translate Text="/edit/editformdata/pagingsize" runat="server" />
		</td>
		<td>
			<asp:TextBox ID="PagingSize" Runat="server" Text="20" Columns="5" />
			<asp:RegularExpressionValidator ID="AssureNumberInput" Runat="server" ControlToValidate="PagingSize" ErrorMessage="*" ValidationExpression="\d{1,4}" />
			<asp:RangeValidator MinimumValue="1" MaximumValue="9999" Runat="server" ControlToValidate="PagingSize" ErrorMessage="*" />
			<asp:RequiredFieldValidator ID="RFV1" ControlToValidate="PagingSize" ErrorMessage="*" runat="server" />
		</td>
	</tr>
</table>
<asp:button id="GetData" runat="server" OnClick="GetPosts" Translate="/button/search" />
<br />
<br />
<asp:Literal ID="HitsCount" Runat="server" />
<br />&nbsp;
<asp:DataGrid 
	ID="Grid" 
	AllowSorting="True" 
	Runat="server" 
	AllowPaging="True"
	ShowFooter="False" 
	PageSize="20"
	CssClass="EP-tableGrid"
	HeaderStyle-CssClass="EP-tableHeadingGrid"
	ItemStyle-CssClass="EP-tableCellGrid"
	DataSource='<%#Statistics.Posts%>'
	OnSortCommand="Grid_Sort"
	OnPageIndexChanged="Grid_PageIndexChanged"
	AutoGenerateColumns="False">
	<PagerStyle Visible="False" Mode="NumericPages" NextPageText="" PrevPageText="">
	</PagerStyle>
</asp:DataGrid>
<br />
<asp:Button ID="DeleteButton" Runat="server" Enabled="false" Translate="/button/delete" />
<asp:Button ID="PreviousButton" Runat="server" OnClick="PreviousPage" Enabled="false" Translate="/button/prev" />
<asp:Button ID="NextButton" Runat="server" OnClick="NextPage" Enabled="false" Translate="/button/next" />
<asp:Button ID="ExportToExcelButton" CausesValidation="False" Enabled="false" Translate="/edit/editformdata/excelexport" runat="server" />
<episerver:xformpostings runat="server" id="Statistics" Visible="false" />
<object 
	id="ExcelTools" 
	width="0" 
	height="0" 
	classid="clsid:464A4945-DC7F-425E-8F2D-5E2FD03F622A" 
	codebase="<%=Configuration.RootDir%>Util/Activex/EPiServerClientComponents.cab#version=1,0,0,19" VIEWASTEXT>
</object>