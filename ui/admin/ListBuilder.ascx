<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ListBuilder.ascx.cs" Inherits="EPiServer.Admin.ListBuilder" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type='text/javascript'>
	var list = "<%=itemList.UniqueID%>";

	function SelectAllItems()
	{
		for (var i=0; i<document.all[list].length; i++)
			document.all[list].options(i).selected = true;
	}
	function CreateItem()
	{
		var newEntry = window.showModalDialog('<%=DialogUrl%>');
		if(newEntry != null && newEntry != "")
		{
			var newOption = new Option();
			newOption.text = newEntry;
			newOption.value = newEntry;
			document.all[list].options.add(newOption);
			document.all[list].options[document.all[list].options.length-1].selected = true;
			EnableButtons();
		}
	}
	function EditItem()
	{
		var currentEntry = document.all[list].options[document.all[list].selectedIndex].text;
		var newEntry = prompt("Edit entry \""+ currentEntry +"\":", currentEntry);
		if(newEntry != null && newEntry != "")
		{
			var index = document.all[list].selectedIndex;
			document.all[list].options[index].value = newEntry;
			document.all[list].options[index].text = newEntry;
			document.all[list].options[index].selected = true;
			EnableButtons();
		}
	}
	function RemoveItem()
	{
		document.all[list].options.remove(document.all[list].selectedIndex);
		EnableButtons();
	}
	function EnableButtons()
	{
		if(document.all[list].selectedIndex >= 0)
			document.all.removeButton.disabled = false;
		else
			document.all.removeButton.disabled = true;
	}
</script>
<table cellpadding="5" cellspacing="0">
<tr>
	<td>
		<asp:ListBox SelectionMode=Multiple id="itemList" Rows="4" Width=200 onchange="EnableButtons();" runat="server" NAME="itemList"/>
	</td>
	<td width="7"/>
	<td>
		<input id="addButton" type="button" value="<%=Translate("/button/add")%>" onclick="CreateItem();"><br>
		<input id="removeButton" type="button" value="<%=Translate("/button/delete")%>" onclick="RemoveItem();" disabled> 
	</td>
</tr>
</table>