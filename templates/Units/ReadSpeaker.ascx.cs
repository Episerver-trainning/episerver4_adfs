using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development.Templates.Units
{
	public abstract class ReadSpeaker : UserControlBase
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!Page.IsClientScriptBlockRegistered("readspeaker"))
				Page.RegisterClientScriptBlock("readspeaker", GetScript());
		}
		/// <remarks>There is currently(2005-07-28) a known issue in Opera 8 that does not set a closed window to null or the closed attribute
		/// which means the call to closed may result in an javascript error</remarks>
		private String GetScript()
		{
			String language		= CurrentPage["ReadspeakerLanguage"] == null ? CurrentPage.LanguageID : (String)CurrentPage["ReadspeakerLanguage"];
			String audioFormat	= CurrentPage["AudioFormat"] == null ? "2" : CurrentPage["AudioFormat"].ToString();
			return @"<script type='text/javascript'>
<!--

var readSpeakerWindow;
function getInnerText(node)
{ 
	var innerText = ''; 
	if (node.nodeType == 3)
	{
		innerText = node.nodeValue;
		if(innerText != null && innerText != '')
			innerText = innerText + '\n';
	}
	else 
	{
		for (var c = 0; c < node.childNodes.length; c++) 
			innerText += getInnerText(node.childNodes[c]);
	} 
	return innerText; 
}
function readPage() 
{
	var da = (document.all) ? 1 : 0;
	var customerID = 77;
	var customerDirectory = 'epirsone';	
	var language = '" + language + @"';
	var audioFormat = '" + audioFormat + @"';
	var voiceArea = document.getElementById('voicearea');
	
	if(voiceArea == null && da) 
		voiceArea = document.all.voicearea;
	
	if(voiceArea)
	{
		var rstextValue;
		if(da)
			rstextValue = document.selection.createRange().text;
		else
			rstextValue = window.getSelection();
		if(rstextValue == '')
			rstextValue = getInnerText(voiceArea);
		
		var urlValue = '';
		if(false) 
			urlValue = wdoc.all.url;
		if(urlValue == '')
			urlValue = document.location.href;


		var sStart = '<html><head><script type=""text/javascript"">\nfunction submitForm()\n{\nvar formToSubmit = document.getElementById(""rs_form"");\nformToSubmit.submit();\n}\nif( window.attachEvent )\nwindow.attachEvent(""onload"", submitForm);\nelse\nwindow.addEventListener(""load"", submitForm, false);\n<\/script></head><body><form class=""ISI_REMOVE"" id=""rs_form"" name=""rs_form"" action=""http://isi.phoneticom.com/cgi-bin/' + customerDirectory + '"" method=""POST"">';
		var innerHtml =	'<input type=""hidden"" id=""rstext"" name=""rstext"" value=""' + rstextValue + '""/><input type=""hidden"" id=""customerid"" value=""' + customerID + '"" name=""customerid"" /><input type=""hidden"" id=""url"" name=""url"" value=""' + urlValue + '""><input type=""hidden"" id=""type"" value=""' + audioFormat + '"" name=""type"" /><input type=""hidden"" id=""lang"" value=""' + language + '"" name=""lang"" />';
		var sStop = '</form></body></html>';

		if(readSpeakerWindow != null && !readSpeakerWindow.closed)
			readSpeakerWindow.close();
					
		readSpeakerWindow = window.open('about:blank','ReadSpeakerWindow','width=240,height=160,scrollbars=yes');
		var wdoc = readSpeakerWindow.document;

		wdoc.open();
		wdoc.write( sStart + innerHtml ) ;
		wdoc.writeln( sStop );
		wdoc.close();
	}
}
//-->
</script>";
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}