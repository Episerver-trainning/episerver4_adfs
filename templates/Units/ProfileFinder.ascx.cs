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
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using EPiServer.Security;
using EPiServer.WebControls;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for ProfileFinder.
	/// </summary>
	public abstract class ProfileFinder : UserControlBase
	{
		protected TextBox				UserName, FirstName, LastName, Email, Company, ProfileTextBox, LimitAmountOfHits;
		protected PropertySearch		PropertySearchControl;
		protected PageList				PageListControl, DetailedList;
		protected LinkButton			EditProfileButton;
		protected Label					NumberOfResultsInfo;
		protected Panel					DetailedListPanel;
		protected HtmlTable				MyProfileLink;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				if(Request.QueryString["editdetails"] != null)
					RedirectToProfilePage();
				MyProfileLink.Visible = Page.User.Identity.IsAuthenticated;
			}
			else
				DoSearch();
		
			DetailedListPanel.Visible = false;
		}
		protected string ConcatEmailAdress(string fullAdress)
		{
			if(fullAdress == null)
				return string.Empty;
			else if(fullAdress.Length <= 13)
				return fullAdress;
			else 
				return fullAdress.Substring(0,10) + "...";
		}
		protected void DoSearch()
		{
			int pageTypeID = (int)CurrentPage["ProfilePageType"];
			AddPageTypeCriteria("PageTypeID", pageTypeID.ToString());

			if(UserName.Text.Length > 0)
				AddStringCriteria("PageName", UserName.Text);
			if(FirstName.Text.Length > 0)
				AddStringCriteria("FirstName", FirstName.Text);
			if(LastName.Text.Length > 0)
				AddStringCriteria("LastName", LastName.Text);
			if(Email.Text.Length > 0)
				AddStringCriteria("Email", Email.Text);
			if(Company.Text.Length > 0)
				AddStringCriteria("Company", Company.Text);
			if(ProfileTextBox.Text.Length > 0)
				AddStringCriteria("Profile", ProfileTextBox.Text);
			if(LimitAmountOfHits.Text.Length > 0)
			{
				try
				{
					PageListControl.MaxCount = Convert.ToInt32(LimitAmountOfHits.Text);
				}
				catch(Exception)
				{}
			}
			
			PropertySearchControl.DataBind();			
			PageListControl.DataBind();
			NumberOfResultsInfo.Text = Translate("/templates/common/numberofhits") + ": " + PropertySearchControl.DataCount;
		}

		private void AddStringCriteria(string name, string searchValue)
		{
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.StringCondition	= StringCompareMethod.Contained;
			criteria.Type				= PropertyDataType.String;
			criteria.Name				= name;
			criteria.Value				= searchValue;
			criteria.Required			= true;

			PropertySearchControl.Criterias.Add(criteria);
		}

		private void AddPageTypeCriteria(string name, string searchValue)
		{
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.Type				= PropertyDataType.PageType;
			criteria.Name				= name;
			criteria.Value				= searchValue;
			criteria.Required			= true;

			PropertySearchControl.Criterias.Add(criteria);
		}

		protected void EditDetails_Click(object sender, System.EventArgs e)
		{
			RedirectToProfilePage();
		}
		protected void RedirectToProfilePage()
		{
			if(!Page.User.Identity.IsAuthenticated)
				return;
			
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.Type				= PropertyDataType.Number;
			criteria.Name				= "Sid";
			criteria.Value				= UnifiedPrincipal.CurrentSid.ToString();
			criteria.Required			= true;

			PropertySearchControl.Criterias.Clear();
			PropertySearchControl.Criterias.Add(criteria);
			PropertySearchControl.DataBind();

			foreach(PageData page in PropertySearchControl)
			{
				//Should only be one page with the given Sid
				Response.Redirect(page.LinkURL);
			}

			PageType pageType = PageType.Load((int)CurrentPage["ProfilePageType"]);
			Response.Redirect(pageType.FileName + "?parent=" + ((TemplatePage)Page).CurrentPageLink.ID + "&type=" + pageType.ID);
		}
		protected void ViewDetailedList_Click(object sender, System.EventArgs e)
		{
			PageDataCollection usersToView = new PageDataCollection();
			foreach(string key in Request.Params)
			{
				if(key.StartsWith("ViewUser"))
				{
					PageReference userRef =  PageReference.Parse(key.Substring(8));
					PageData userToAdd = ((PageBase)Page).GetPage(userRef);
					usersToView.Add(userToAdd);
				}
			}

			DetailedList.DataSource = usersToView;
			DetailedListPanel.Visible = true;
			DetailedList.DataBind();
			Page.RegisterStartupScript("HideSearchPanel", "\n<script type='text/javascript'>\n<!--\nSwitchSearchVisibility();\n-->\n</script>");
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