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
using EPiServer.Security;
using EPiServer.WebControls;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for Conference.
	/// </summary>
	public abstract class Conference : UserControlBase
	{
		protected Property		WriterName,MainBody,PageName;
		protected LinkButton	DeleteButton, Change, Reply, CreateNew;
		private PageReference	_nextPage,_previousPage;
		protected Panel			ViewPanel, EditPanel, StartPage;
		protected HyperLink		PreviousPageLink, NextPageLink;
		protected ExplorerTree	ExplorerTree;

		private void Page_PreRender(object sender, System.EventArgs e)
		{	
			if(!IsPostBack)
				ExplorerTree.DataBind();
			
			if(EditMode)
			{
				EditPanel.Visible		= true;
				StartPage.Visible		= false;
				ViewPanel.Visible		= false;
				ExplorerTree.Visible	= false;
			}
			else if(IsRootPage())
			{
				StartPage.Visible = true;
				ViewPanel.Visible = false;
				EditPanel.Visible = false;
				CreateNew.Visible = CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Create) && CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Publish);	
			}			
			else
			{
				EditPanel.Visible = false;
				ViewPanel.Visible = true;
				StartPage.Visible = false;

				Change.Visible	= CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Edit) && CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Publish);
				Reply.Visible	= CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Create) && CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Publish);

				DeleteButton.Visible = CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Delete);
				if(DeleteButton.Visible)
					AddDeleteConfirmationScript();

				CreateParentTree();
				
				PreviousPageLink.NavigateUrl	= PreviousPageURL;
				PreviousPageLink.Visible		= _previousPage != PageReference.EmptyReference;
				NextPageLink.NavigateUrl		= NextPageURL;
				NextPageLink.Visible			= _nextPage != PageReference.EmptyReference;
			}			
		}
		protected PageReference TreeRoot
		{
			get
			{
				if(EditMode)
					return PageReference.EmptyReference;
				else
					return ((PageBase)Page).CurrentPageLink;
			}
		}
		protected void CreateParentTree()
		{
			_previousPage	= PageReference.EmptyReference;
			_nextPage		= PageReference.EmptyReference;
			bool passedCurrentPage = false;

			PageDataCollection siblings = GetChildren(CurrentPage.ParentLink);		
			foreach(PageData sibling in siblings)
			{	
				if(CurrentPage.PageLink.ID == sibling.PageLink.ID)
				{
					passedCurrentPage = true;
					continue;
				}
				else if(!passedCurrentPage)
					_previousPage = sibling.PageLink;
				else
				{
					_nextPage = sibling.PageLink;	
					break;
				}
			}
		}

		protected string NextPageURL
		{
			get
			{
				if(_nextPage != PageReference.EmptyReference)
					return GetPage(_nextPage).LinkURL;
				return string.Empty;
			}
		}

		protected string PreviousPageURL
		{
			get
			{
				if(_previousPage != PageReference.EmptyReference)
					return GetPage(_previousPage).LinkURL;
				return string.Empty;
			}
		}

		protected void DeletePost(object sender, System.EventArgs e)
		{
			PageReference parentPage = CurrentPage.ParentLink;
			Global.EPDataFactory.Delete( PageBase.CurrentPageLink, true );

			PageData parentData = GetPage(parentPage);

			Response.Redirect(parentData.LinkURL,true);
		}	

		protected bool IsRootPage()
		{
			if(CurrentPage["ConferenceContainer"] != null &&((PageReference)CurrentPage["ConferenceContainer"]) == CurrentPage.PageLink)
				return true;
			else
				return false;
		}
		private void AddDeleteConfirmationScript()
		{
			Page.RegisterStartupScript("DeleteConfirmation",@"
			<script type='text/javascript'>
			<!--
				function OnDelete()
				{
					return confirm('" + ((PageBase)Page).TranslateForScript("/templates/conference/deleteconfirm") + @"');
				}
				document.all['" + DeleteButton.ClientID + @"'].attachEvent('onclick',OnDelete);
			// -->
			</script>");
		}
		protected void SavePost(object sender, System.EventArgs e)
		{
			if(IsNewPost)
			{
				Page.Validate();
				if(!Page.IsValid)
				{
					DataBind();
					return;
				}
				PageData newPage		= Global.EPDataFactory.GetDefaultPageData(CurrentPage.PageLink, CurrentPage.PageTypeID);
				newPage.PageName		= PageName.InnerProperty.Value.ToString();
				if(!MainBody.InnerProperty.IsNull)
					newPage["MainBody"]		= MainBody.InnerProperty.Value;
				if(!WriterName.InnerProperty.IsNull)
					newPage["WriterName"]	= WriterName.InnerProperty.Value;

				Global.EPDataFactory.Save(newPage, EPiServer.DataAccess.SaveAction.Publish);
				Response.Redirect("Conference.aspx?id=" + newPage.PageLink.ID);
			}
			else
			{
				Global.EPDataFactory.Save(CurrentPage, EPiServer.DataAccess.SaveAction.Publish);
				Response.Redirect("Conference.aspx?id=" + PageBase.CurrentPageLink.ID);
			}
		}

		protected void CreatePost(object sender, System.EventArgs e)
		{
			IsNewPost	= true;
			EditMode	= true;
			PageName.InnerProperty.IsRequired	= false;
			if(!IsRootPage())
				PageName.InnerProperty.Value = "Re: " + CurrentPage.PageName;
			else
				PageName.InnerProperty.Value = string.Empty;
			if(Page.User.Identity.IsAuthenticated)
			{
				string name = string.Empty;
				if(UnifiedPrincipal.Current.UserData.FirstName != null)
					name = UnifiedPrincipal.Current.UserData.FirstName;
				if(UnifiedPrincipal.Current.UserData.LastName != null)
				{
					if(name != string.Empty)
						name += " ";
					name += UnifiedPrincipal.Current.UserData.LastName;
				}
				WriterName.InnerProperty.Value	= name;
			}
			MainBody.InnerProperty.Value		= string.Empty;
			PageName.InnerProperty.IsRequired	= true;
		}
		protected void ChangePost(object sender, System.EventArgs e)
		{
			IsNewPost	= false;
			EditMode	= true;
			PageName.InnerProperty.IsRequired = true;
		}
		protected void CancelEdit(object sender, System.EventArgs e)
		{
			IsNewPost = false;
			EditMode  = false;
		}

		#region Accessors
		protected bool IsNewPost
		{
			get{return ViewState["IsNewPost"] == null ? false : (bool)ViewState["IsNewPost"];}
			set{ViewState["IsNewPost"] = value;}
		}
		protected bool EditMode
		{
			get{return ViewState["EditMode"] == null ? false : (bool)ViewState["EditMode"];}
			set{ViewState["EditMode"] = value;}
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
			this.PreRender += new System.EventHandler(this.Page_PreRender);

		}
		#endregion
	}
}
