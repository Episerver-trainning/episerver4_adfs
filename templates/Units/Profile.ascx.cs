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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.Personalization;
using EPiServer.Security;
using EPiServer.WebControls;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for Profile.
	/// </summary>
	public abstract class Profile : UserControlBase
	{
		protected LinkButton	SaveButton, EditButton, CancelButton;
		protected Property		PageName, FirstName, LastName, Email, Telephone, Company;
		protected Table			ExtraFields;
		private String			_extraFieldKey = "AddedProp";

		private void Page_Load(object sender, System.EventArgs e)
		{
			InitializeExtraFields();

			if(!IsPostBack)
			{
				if(Request["parent"] != null)
					SwitchMode();
				else
				{
					SetupButtons();
					DataBind();
				}
			}
		}

		private void InitializeExtraFields()
		{
			foreach(string propertyKey in CurrentPage.Property)
			{
				if(propertyKey.StartsWith(_extraFieldKey))
				{
					TableCell headerCell	= new TableCell();
					headerCell.VerticalAlign = VerticalAlign.Top;
					headerCell.Text			= ((PropertyData)CurrentPage.Property[propertyKey]).DisplayName;

					TableCell propertyCell	= new TableCell();
					Property prop			= new Property((PropertyData)CurrentPage.Property[propertyKey]);
					propertyCell.Controls.Add(prop);

					TableRow row			= new TableRow();
					row.ID					= propertyKey;
					row.Cells.Add(headerCell);
					row.Cells.Add(propertyCell);
					ExtraFields.Rows.Add(row);
				}
			}
		}		
		protected void SwitchMode(object sender, System.EventArgs e)
		{
			SwitchMode();			
		}

		private void SwitchMode()
		{
			EditMode = !EditMode;
			
			foreach(TableRow row in ExtraFields.Rows)
			{
				Control control = row.Cells[1].Controls[0];
				Property prop = control as Property;
				if(prop != null && prop.ID != "PageName")
					prop.EditMode = EditMode;
			}
			SetupButtons();
			DataBind();
		}
		private void SetupButtons()
		{
			SaveButton.Visible	= EditMode;
			SaveButton.Text		= "[" + Translate("/button/save") + "]";
			EditButton.Visible	= AllowEditing && !EditMode;
			EditButton.Text		= "[" + Translate("/button/edit") + "]";
			CancelButton.Visible= EditMode;
			CancelButton.Text	= "[" + Translate("/button/cancel") + "]";
		}

		protected void SaveProfile(object sender, System.EventArgs e)
		{
			SavePage();
			PersonalizedData userData = PersonalizedData.Load((int)CurrentPage["SID"]);
			if(userData != null)
				SyncPersonalizedData(userData, false);
			SwitchMode();
		}

		private void Page_Init(object sender, System.EventArgs e)
		{			
			if(IsPostBack)
				return;
			int sid = 0;

			if(CurrentPage["SID"] != null)
				sid = (int)CurrentPage["SID"];
			else if(((EditPage)Page).IsNewPage)
				sid = UnifiedPrincipal.CurrentSid;

			if(sid != UnifiedPrincipal.CurrentSid)
				return;
			
			PersonalizedData userData = PersonalizedData.Load(sid);
			if(userData == null)
				return;
			
			if(CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Publish))
				SyncPersonalizedData(userData, true);
		}
		/// <summary>
		/// Method that is used to sync data betwen a personal profile page and a users personalized data.
		/// </summary>
		/// <param name="userData">The Personalized data of the user</param>
		/// <param name="fromUserData">Switch to declare what way the sync should be done</param>
		private void SyncPersonalizedData(PersonalizedData userData, bool fromPersonalization)
		{
			bool outOfSync = false;

			//TODO: Handle when the user changes UserName

			string[] syncProperties = new String[] {"FirstName","LastName","Email","Telephone","Company", "Title"};

			foreach(string syncProperty in syncProperties)
			{
				if(fromPersonalization)
					outOfSync |= SyncValueFromPersonalization(syncProperty, userData);
				else
					outOfSync |= SyncValueToPersonalization(syncProperty, userData);
			}

			if(fromPersonalization && outOfSync || ((EditPage)Page).IsNewPage)//If out of sync or new page - Save()
				SavePage();
			else if((!fromPersonalization && outOfSync))
				userData.Save();
			if(((EditPage)Page).IsNewPage)
				Response.Redirect("Profile.aspx?id=" + CurrentPage.PageLink.ID, true);
		}
		private bool SyncValueToPersonalization(string propertyName, PersonalizedData userData)
		{
			String userDataPropertyKey = "Personal" + propertyName;
			if(CurrentPage.Property[propertyName].IsNull || ((string)userData[userDataPropertyKey] == (string)CurrentPage[propertyName]))
				return false;
			
			userData[userDataPropertyKey] = (string)CurrentPage[propertyName];
			return true;
		}
		private bool SyncValueFromPersonalization(string propertyName, PersonalizedData userData)
		{
			String userDataPropertyKey = "Personal" + propertyName;
			if(userData[userDataPropertyKey] == null || ((string)userData[userDataPropertyKey] == (string)CurrentPage[propertyName]))
				return false;

			CurrentPage[propertyName] = (string)userData[userDataPropertyKey];
			return true;
		}
		private void SavePage()
		{		
			if(((EPiServer.EditPage)Page).IsNewPage)
			{
				CurrentPage["Sid"] = PageBase.CurrentUser.Sid;
				CurrentPage.PageName = PageBase.CurrentUser.Identity.Name;
				CurrentPage.VisibleInMenu = false;
			}
			Global.EPDataFactory.Save(CurrentPage, SaveAction.Publish);
		}


		#region Accessors
		public bool AllowEditing
		{
			get
			{
				return CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Publish);
			}
		}

		public bool EditMode
		{
			get { return ViewState["EditMode"] == null ? false : (bool)ViewState["EditMode"]; }
			set { ViewState["EditMode"] = value; }
		}

		#endregion
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
			this.Init += new System.EventHandler(this.Page_Init);
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}