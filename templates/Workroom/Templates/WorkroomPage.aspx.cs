using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Security;
using EPiServer.WebControls;
using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates
{
	/// <summary>
	/// Summary description for Workroom.
	/// </summary>
	public class WorkroomPage : TemplatePage
	{
		public TabStrip		WorkRoomTabStrip;
		public Panel WorkroomPanel;

		private void Page_Load(object sender, System.EventArgs e)
		{
			RegisterCssFile(Global.EPConfig.RootDir + "templates/Workroom/Styles/Workroom.css");
			RegisterScriptFile("util/javascript/system.js");

			// Only workroom users should have access to the workroom
			Workroom workroom = new Workroom(CurrentPage);

			WorkroomPanel.Visible = (workroom.GetMemberStatus(UnifiedPrincipal.CurrentSid) != MemberStatus.None);
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}