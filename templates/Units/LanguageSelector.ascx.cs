namespace development.templates.Units
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using EPiServer.Core;
	using EPiServer.DataAbstraction;
	using EPiServer.WebControls;

	/// <summary>
	///		Summary description for LanguageSelector.
	/// </summary>
	public class LanguageSelector : EPiServer.UserControlBase
	{
		protected PageList languageList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(Configuration.EnableGlobalizationSupport && CurrentPage.PageLink.IsValue())
			{
				languageList.DataSource = Global.EPDataFactory.GetLanguageBranches(CurrentPage.PageLink);
				languageList.DataBind();
			}
			else
				Visible = false;
		}

		protected string GetIcon(PageData pageLang)
		{
			LanguageBranch lb = LanguageBranch.Load(pageLang.LanguageBranch);
			if(lb.IconPath==null)
				return String.Empty;
			if(lb.IconPath.StartsWith("/"))
				return lb.IconPath;
			
			return ResolveUrl( "~/" + lb.IconPath );
		}

		protected string GetAlt(PageData pageLang)
		{
			LanguageBranch lb = LanguageBranch.Load(pageLang.LanguageBranch);
			return String.Format(Translate("/templates/common/changelanguage"),lb.Name);
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
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
