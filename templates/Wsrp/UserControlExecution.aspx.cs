using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using ElektroPost.Wsrp.V1.Types;
using ElektroPost.Wsrp.Producer;

using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;

using development;

using development.Templates.Wsrp.Core;

namespace development
{
	/// <summary>
	/// Summary description for UserControlExecution.
	/// </summary>
	public class UserControlExecution : WsrpTemplatePage
	{
		private Boolean			_isViewstateInitialized;

		public override void ValidatePageTemplate()
		{
		}

		private void Page_Init(object sender, System.EventArgs e)
		{
			Context.User	= new EPiServer.Security.UnifiedPrincipal( Context.User, Server.MachineName );
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			String userControl = Context.Items["wsrpUserControl"] as String;
			if (userControl == null)
				return;
			Controls.Add(LoadControl(userControl));
		}

		public System.Web.UI.StateBag PersistentViewState
		{
			get
			{
				if (!_isViewstateInitialized)
				{
					_isViewstateInitialized = true;
					base.ViewState.Clear();
					IPortlet portlet = Context.Items["wsrpPortlet"] as IPortlet;
					foreach (String key in portlet.State.Keys)
					{
						base.ViewState.Add(key, portlet.State[key]);
					}
				}
				return base.ViewState;
			}
		}

		protected override void SavePageStateToPersistenceMedium(object viewState)
		{
			if (!_isViewstateInitialized)
				return;
			_isViewstateInitialized = false;

			IPortlet portlet = Context.Items["wsrpPortlet"] as IPortlet;
			if (portlet == null || portlet.State == null)
				return;

			if (portlet.State.IsDirty)
				throw new Exception("Portlet state has been modified both with ViewState changes and portlet.State changes. Use one method only.");

			if (viewState == null)
				viewState = base.ViewState;

			foreach (String key in ((StateBag)viewState).Keys)
			{
				portlet.State[key] = ((StateBag)viewState)[key];
			}
		}
	
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			// Is the portlet multilanguage-enabled?
			IPortlet portlet = Context.Items["wsrpPortlet"] as IPortlet;
			if (portlet != null && portlet.IsMultiLanguageEnabled)
			{
				// Get requested locales
				String[] locales = null;
				GetMarkup markup = Context.Items["wsrpMarkup"] as GetMarkup;
				if (markup != null && markup.markupParams != null)
				{
					locales = markup.markupParams.locales;
				}
				else
				{
					PerformBlockingInteraction interact = Context.Items["wsrpBlockingInteraction"] as PerformBlockingInteraction;
					if (interact != null && interact.markupParams != null)
					{
						locales = interact.markupParams.locales;
					}
				}

				String resultingBranch = LanguageContext.GetLanguageBranch(locales);
				if (resultingBranch != null)
				{
					LanguageContext.Current.CurrentLanguageBranch = resultingBranch;
				}
			}

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
			this.Init += new System.EventHandler(this.Page_Init);
			this.Unload += new EventHandler(Page_Unload);
			this.Error += new EventHandler(Page_Error);
		}
		#endregion

		private void Page_Unload(object sender, EventArgs e)
		{
			SavePageStateToPersistenceMedium(null);
		}

		private void Page_Error(object sender, EventArgs e)
		{
			HttpContext.Current.Items["wsrpException"] = Server.GetLastError();
			Server.ClearError();
		}
	}
}
