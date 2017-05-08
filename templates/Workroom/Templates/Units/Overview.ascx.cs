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
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.WebControls;
using EPiServer.Util;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	///	The start tab for the work room.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/Overview.ascx",SortIndex=1000, 
				LanguagePath="/templates/workroom/plugins/overview")]
	public class Overview : WorkroomControlBase, ICustomPlugInLoader, IWorkroomPlugin
	{
		protected EPiServer.WebControls.Property MainBodyProperty;
		protected EPiServer.WebControls.NewsList NewsListControl;
		protected System.Web.UI.WebControls.Button EditMainBodyButton;
		protected EPiServer.WebControls.Property PageLinkProperty;
		protected System.Web.UI.WebControls.Button SaveMainBodyButton;
		protected System.Web.UI.WebControls.Button CancelMainBodyButton;
		protected System.Web.UI.HtmlControls.HtmlGenericControl ListPanel;
		protected System.Web.UI.WebControls.TextBox MainBodyTextBox;
		protected System.Web.UI.WebControls.Panel OverviewViewPanel;
		protected System.Web.UI.WebControls.Panel OverviewEditPanel;
		protected EPiServer.WebControls.Calendar calendarList;
			
		public void Page_Load(object sender, EventArgs e)
		{
			NewsListControl.DataBind();
			calendarList.DataBind();
			if (!IsPostBack)
			{
				SetViewMode();
			}

			ListPanel.Visible = !(NewsListControl.DataCount == 0 && calendarList.DataCount == 0);
		}

		private void SetViewMode()
		{
			OverviewViewPanel.Visible		= true;
			OverviewEditPanel.Visible		= false;
			EditMainBodyButton.Visible		= IsAdministrator;
			MainBodyProperty.DataBind();
		}

		private void SetEditMode()
		{
			OverviewViewPanel.Visible		= false;
			OverviewEditPanel.Visible		= true;
			MainBodyTextBox.Text			= CurrentPage["MainBody"] != null ? CurrentPage["MainBody"].ToString() : String.Empty;
		}

		protected void EditMainBodyButton_Click(object sender, EventArgs e)
		{
			SetEditMode();
		}

		protected void SaveMainBodyButton_Click(object sender, EventArgs e)
		{
			CurrentPage["MainBody"] = MainBodyTextBox.Text;
			CurrentWorkroom.Save();
			SetViewMode();
		}

		protected void CancelMainBodyButton_Click(object sender, EventArgs e)
		{
			SetViewMode();
		}

		protected string CreateNewsLink(PageData newsPage)
		{
			Tab tab = GetTab(Translate("plugins/news/displayname"));

			String url = CurrentPage.LinkURL;

			if (tab != null)
			{
				url = PageReference.AddQueryString(url,"SelectedWorkRoomTab",Page.Server.UrlEncode(tab.Text));
				url = PageReference.AddQueryString(url,"NewsID",newsPage.PageLink.ID.ToString());
			}

			return url;
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
				return CurrentPage["IsActiveOverview"] != null && (bool)CurrentPage["IsActiveOverview"] == true;
			}
			set 
			{ 
				CurrentPage["IsActiveOverview"] = value;
			}
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return true; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return true; }
		}
		#endregion

		public PlugInDescriptor[] List()
		{
			return GetPlugInDescriptor();
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
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.ID = "Overview";
			this.Page.Load += new EventHandler(Page_Load);
		}
		#endregion
	}
}