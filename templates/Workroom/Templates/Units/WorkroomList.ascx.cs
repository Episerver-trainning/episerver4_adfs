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
using EPiServer.Filters;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;
using EPiServer.WebControls;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	public class WorkroomList : Workrooms.Core.WorkroomControlBase
	{
		protected CheckBox	ShowOnlyActiveWorkroomsCheckBox;
		protected Property	PageNameProperty;
		protected PageList	WorkroomPageList;
		protected Panel		WorkroomListPanel;
		protected Button	CreateWorkroomButton;

		protected int RowIndex = 0;

		private void Page_Load(object sender, System.EventArgs e)
		{
			CreateWorkroomButton.Visible = CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Create) && CurrentPage.ACL.QueryDistinctAccess(AccessLevel.Publish);	
			ShowOnlyActiveWorkroomsCheckBox.Text = Translate("common/showonlyactive");

			if (!IsPostBack)
				WorkroomPageList.DataBind();		
		}

		protected PageDataCollection GetValidPages()
		{
			int workRoomPageTypeID = PageType.Load("Workroom").ID;

			PageDataCollection pages = Global.EPDataFactory.GetChildren(CurrentPage.PageLink);

			for(int index = pages.Count - 1; index >= 0; index--)
			{
				if(pages[index].PageTypeID != workRoomPageTypeID)
				{
					pages.RemoveAt(index);
					continue;
				}
				if (ShowOnlyActiveWorkroomsCheckBox.Checked)
				{
					Workroom workroom = new Workroom(pages[index]);
					if (!workroom.IsActiveWorkroom)
						pages.RemoveAt(index);
				}
			}

			return pages;
		}

		protected string GetRowCSS(int rowIndex)
		{
			return RowIndex % 2 == 0 ? "ListRowEven" : "ListRowUneven";
		}

		protected void CreateWorkroomButton_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("CreateWorkroom.aspx?id=" + CurrentPage.PageLink.ID.ToString());
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
			this.ShowOnlyActiveWorkroomsCheckBox.CheckedChanged += new System.EventHandler(this.ShowOnlyActiveWorkroomsCheckBox_CheckedChanged);
			this.ID = "WorkroomPageList";
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void ShowOnlyActiveWorkroomsCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			WorkroomPageList.DataBind();
		}
	}
}