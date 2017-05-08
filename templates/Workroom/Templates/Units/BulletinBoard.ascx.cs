using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAccess;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;
using EPiServer.WebControls;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	///	The BulletinBoard tab.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/BulletinBoard.ascx",SortIndex=6000, 
				LanguagePath="/templates/workroom/plugins/bulletinboard")]
	public class BulletinBoard : WorkroomControlBase, ICustomPlugInLoader, ICustomPlugInDataLoader, IWorkroomPlugin
	{
		protected PageList	PageList;
		protected Panel		DetailsView;
		protected Panel		EditView;
		protected TextBox	PageName;
		protected TextBox	MainIntro;
		protected TextBox	MainBody;
		protected Button	CreateButton;
		protected Button	EditButton;
		protected Button	SaveButton;
		protected Button	CancelButton;
		protected Label		EditLabel;
		protected Panel		DetailsViewButtonPanel;
		protected Button	DeleteButton;

		public void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.QueryString["BulletinID"] != null)
				{
					SelectItem(Request.QueryString["BulletinID"]);
				}
			}
		}
		private void SelectItem(string pageID)
		{
			PageReference selectedPage = PageReference.Parse(pageID);
			ActivePage = Global.EPDataFactory.GetPage(selectedPage);
			SetViewMode();
		}

		public void SelectItem_Click(object sender, CommandEventArgs e)
		{
			SelectItem(e.CommandArgument.ToString());
		}

		public void Data_Load(object sender, EventArgs e)
		{
			SetupData();
		}

		protected void SetupData()
		{
			PageList.DataBind();
			if(ActivePage == null)
			{
				IEnumerator enumerator = PageList.GetEnumerator();
				if (enumerator.MoveNext())
					ActivePage = enumerator.Current as PageData;
			}
			SetViewMode();
		}

		private void SetViewMode()
		{
			DetailsView.Visible				= true;
			DetailsViewButtonPanel.Visible	= true;
			EditView.Visible				= false;
			CreateButton.Visible			= CanEdit;
			EditButton.Visible				= ActivePage != null && CanEdit;
			DeleteButton.Visible			= ActivePage != null && CanDelete;
		}

		private void SetEditMode()
		{
			if (!CanEdit)
			{
				SetViewMode();
				return;
			}

			DetailsView.Visible				= false;
			DetailsViewButtonPanel.Visible	= false;
			EditView.Visible				= true;

			if (ActivePage == null)
			{
				EditLabel.Text				= Translate("/button/create");
				DeleteButton.Visible		= false;
			}
			else
			{
				EditLabel.Text				= Translate("/button/edit");
				DeleteButton.Visible		= CanDelete;
			}

			FocusToInput(PageName);
		}

		protected void DeleteButton_Click(object sender, EventArgs e)
		{
			EPiServer.Global.EPDataFactory.Delete(ActivePageLink, true);
			ActivePage = null;
			SetupData();
		}

		protected void CreateButton_Click(object sender, EventArgs e)
		{
			ActivePage = null;
			SetEditMode();
			PageName.Text	= String.Empty;
			MainIntro.Text	= String.Empty;
			MainBody.Text	= String.Empty;
		}

		protected void EditButton_Click(object sender, EventArgs e)
		{
			SetEditMode();
			PageName.Text	= ActivePage.PageName;
			MainIntro.Text	= (ActivePage["MainIntro"] != null) ? ActivePage["MainIntro"].ToString() : String.Empty;
			MainBody.Text	= ActivePage["MainBody"].ToString();
		}

		protected void CancelButton_Click(object sender, EventArgs e)
		{
			SetViewMode();
		}

		protected void SaveButton_Click(object sender, EventArgs e)
		{
			if (!CanEdit)
				return;

			PageData page;

			if (ActivePage == null)
			{
				PageType pageType = PageType.Load("Ordinary web page");
				page = Global.EPDataFactory.GetDefaultPageData(CurrentWorkroom.BulletinBoardRoot, pageType.ID);
			}
			else
			{
				page = ActivePage;
			}

			page.PageName		= PageName.Text;
			page["MainIntro"]	= MainIntro.Text;
			page["MainBody"]	= MainBody.Text;

			PageReference pageLink = Global.EPDataFactory.Save(page, SaveAction.Publish);

			ActivePageLink = pageLink;
			SetupData();
		}

		protected String HeaderText
		{
			get
			{
				return Global.EPDataFactory.GetPage(CurrentWorkroom.BulletinBoardRoot).PageName;
			}
		}

		public PlugInDescriptor[] List()
		{
			return GetPlugInDescriptor();
		}


		#region IWorkroomPlugin implementation
		string IWorkroomPlugin.Name
		{
			get { return DisplayName; }
		}

		Boolean IWorkroomPlugin.IsActive
		{
			get 
			{ 
				return CurrentPage["IsActiveBulletinBoard"] != null && (bool)CurrentPage["IsActiveBulletinBoard"] == true;
			}
			set 
			{ 
				CurrentPage["IsActiveBulletinBoard"] = value;
			}
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return true; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return IsPageRefInitialized("BulletinBoardContainer"); }
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
		
		/// <summary>
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