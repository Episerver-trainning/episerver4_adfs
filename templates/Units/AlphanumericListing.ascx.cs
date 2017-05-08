/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using EPiServer.Core;
using EPiServer.Filters;
using System;
using System.Collections;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.Templates.Units
{
	/// <summary>
	///	Alphanumeric pagelist
	///	
	///	The alphanumeric ranges are based on the page language. 
	///	A custom character set can be defined in a property with the name PageAlphanumericChars.
	///	The property can be dynamic or saved in the current page.
	/// </summary>
	public abstract class AlphanumericListing : UserControlBase
	{
		protected EPiServer.WebControls.PropertySearch	PropertySearchControl;
		protected System.Web.UI.WebControls.PlaceHolder AlphanumericLinks;
		protected EPiServer.WebControls.PageList		PageListControl;

		public PageReference StartingPoint
		{
			get 
			{
				if(!IsValue("IndexContainer"))
					return EPiServer.Global.EPConfig.StartPage;
				else
					return PageReference.Parse(CurrentPage["IndexContainer"].ToString());
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			BuildAlphanumericLinks();

			if(!IsPostBack)
			{
				PropertySearchControl.DataBind();
				PageListControl.DataBind();
			}
		}

		protected void BuildAlphanumericLinks()
		{
			string chars = (string) CurrentPage["PageAlphanumericChars"];

			if (chars == null)
			{
				switch(this.CurrentPage.LanguageID)
				{
					case "SV":
					case "FI":
						chars = "abcdefghijklmnopqrstuvwxyzåäö";
						break;
					case "NO":
					case "DK":
						chars = "abcdefghijklmnopqrstuvwxyzæøå";
						break;
					default:	// use English alphabet by default
						chars = "abcdefghijklmnopqrstuvwxyz";
						break;
				}
			}

			string[] ranges = CreateAlphanumericRanges(chars);

			foreach(string range in ranges)
				BuildAlphanumericLink(range);
		}

		protected string[] CreateAlphanumericRanges(string chars)
		{
			const int rangeStep = 5;
			const int minCharsInRange = 3;

			int maxPos = chars.Length;
			int rangeEndPos;
			ArrayList ranges = new ArrayList();

			for(int pos = 0; pos < maxPos; pos = rangeEndPos + 1)
			{
				rangeEndPos = pos + rangeStep - 1;
				if (rangeEndPos >= maxPos || (maxPos - rangeEndPos < minCharsInRange))
					rangeEndPos = maxPos - 1;
				ranges.Add(chars[pos].ToString() + "-" + chars[rangeEndPos].ToString());
			}
			return (string[]) ranges.ToArray(typeof(string));
		}

		protected void BuildAlphanumericLink(string range)
		{
			LinkButton link = new LinkButton();
			link.Text = range;
			link.Click += new EventHandler(ChangeLetters);
			link.CssClass = "heading2";
			AlphanumericLinks.Controls.Add(link);

			Literal space = new Literal();
			space.Text = "&nbsp;&nbsp;&nbsp;";
			AlphanumericLinks.Controls.Add(space);
		}

		protected char[] SplitAlphanumericRange(string range)
		{
			char lastChar = range[range.Length - 1];
			ArrayList chars = new ArrayList();

			for(char currentChar = range[0]; currentChar <= lastChar; currentChar++)
				chars.Add(currentChar);

			return (char[]) chars.ToArray(typeof(char));
		}

		protected void ChangeLetters(object sender, System.EventArgs e)
		{
			LinkButton link = (LinkButton)sender;
			foreach(char letter in SplitAlphanumericRange(link.Text))
				AddLetter(letter);

			DataBind();
		}

		protected void AddLetter(char letter)
		{
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.StringCondition = StringCompareMethod.StartsWith;
			criteria.Type = PropertyDataType.String;
			criteria.Value = letter.ToString().ToUpper();
			criteria.Name = "PageName";

			PropertySearchControl.LanguageBranch = CurrentPage.LanguageBranch;
			PropertySearchControl.Criterias.Add(criteria);
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
