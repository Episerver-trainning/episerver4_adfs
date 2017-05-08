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

using EPiServer.BaseLibrary;
using EPiServer.Util;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.Consumer;
using ElektroPost.Wsrp.Consumer.WebControls;
using ElektroPost.Wsrp.V1.Types;

using development.Templates.Wsrp.Consumer;


namespace development.Templates
{
	/// <summary>
	/// Summary description for WsrpPortal.
	/// </summary>
	public class WsrpPortal : EPiServer.TemplatePage
	{
		readonly log4net.ILog log = log4net.LogManager.GetLogger( typeof( WsrpPortal ) ); 

		static WsrpPortal() 
		{
			
		}

		protected Label	ErrorMsg;
		protected Panel MainPanel;
		protected DropDownList ModeSelector;
		protected HtmlGenericControl AdminActions;
		protected PortletArea LayoutContainer;
		protected Units.WsrpPortalTabControl TabControl;
		protected TextBox TabName;
		protected System.Web.UI.HtmlControls.HtmlGenericControl SettingsPanel;
		protected Units.WsrpPortletList PortletList;
		protected DropDownList LayoutList;
		protected System.Web.UI.WebControls.Button Button1;
		protected LinkButton LinkButton1;
		protected LinkButton LinkButton2;
		protected LinkButton LinkButton3;
		protected HtmlSelect AreaSelect;

		protected IPortalLayout _portalLayout;

		public static String CHANGE_MODE = "change.mode";
		public static String CHANGE_STATE = "change.state";
		public static String CLONE_PORTLET = "clone.portlet";
		public static String VIEW_PROP = "view.properties";

		private const string FORM_TAB				= "_TAB";
		private const string FORM_PORTLETAREA		= "_AREA";
		private const string FORM_POSITION			= "_POS";
		private const string FORM_PRODUCERID		= "_PROD";
		private const string FORM_PORTLETHANDLE		= "_PORTLET";
		private const string FORM_ACTION			= "_ACTION";

		private const string ACTION_ADDPORTLET		= "_ADDPORTLET";
		private const string ACTION_REMOVEPORTLET	= "_REMOVEPORTLET";
		private const string ACTION_RESET			= "_RESETUSERSETTINGS";

		/// <summary>
		/// RW implementation fields
		/// </summary>
		protected int Column;
		public string DesignMode { get { return ModeSelector.SelectedItem.Value; } }
		public string ViewMode { get { return ModeSelector.SelectedItem.Value; } }
		protected int WidthNum = 100;
		protected string Master = "master";
		protected string Tab = "tab";
		protected int PageNo = 0;

		protected string PageId { get { return this.CurrentPageLink.ID.ToString(); } }

		private WsrpPortalPageSession _session;
		protected WsrpPortalPageSession PersistentSession 
		{
			get 
			{
				if (_session == null) 
				{
					try 
					{
						_session = ConsumerContext.StorageSession.LoadPath( WsrpPortalPageSession.STORAGE_KEY, ConsumerContext.User ) as WsrpPortalPageSession;
					}
					catch (Exception x) 
					{
						System.Diagnostics.Debug.WriteLine( x.ToString() );
					}
				}
				if (_session == null) 
				{
					_session = new WsrpPortalPageSession();
					ConsumerContext.StorageSession.Save( _session );
					ConsumerContext.StorageSession.AddRelation( ConsumerContext.User.Id, _session.Id );
				}
				return _session;
			}
		}

		protected int GetRowNo() { return 0; }
		// End RW implementation fields

		#region PortalInfo handling

		private WsrpPortalInfo _commonPortalInfo;

		private const string PROP_COMMON_PORTALINFO = @"_wsrpCommonPortalInfo";
		private const string PROP_LAYOUT_CONTROLS = @"_wsrpLayoutControls";
		private const string PERS_USER_PORTALINFO = @"_wsrpUserPortalInfo";

		protected WsrpPortalInfo UserPortalInfo 
		{
			get 
			{ 
				return (WsrpPortalInfo) ConsumerContext.ConsumerState;
			}
			set 
			{
				ConsumerContext.ConsumerState = value;
			}
		}

		protected WsrpPortalInfo CommonPortalInfo 
		{
			get 
			{ 
				if (_commonPortalInfo == null) 
				{
					if ( this.CurrentPage[PROP_COMMON_PORTALINFO] != null )
					{
						try
						{
							_commonPortalInfo = WsrpPortalInfo.Load( (string) this.CurrentPage[PROP_COMMON_PORTALINFO] );
						}
						catch 
						{
							System.Diagnostics.Debug.WriteLine("Portal info could not be read");
						}
					}
				}
				// still null or invalid in some way?
				if (_commonPortalInfo == null || _commonPortalInfo.Tabs.Length == 0) 
				{
					// recreate a minimum portal data
					_commonPortalInfo = new WsrpPortalInfo();
					TabInfo tab = new TabInfo();
					tab.Name = "Main tab";
					tab.UserControlName = null;
					_commonPortalInfo.Tabs = new TabInfo[] { tab };

					PersistCommonPortalInfo();
				}
				return _commonPortalInfo;
			}
			set 
			{
				_commonPortalInfo = value;
				this.PersistCommonPortalInfo();
			}
		}


		protected void PersistCommonPortalInfo() 
		{
			try 
			{
				this.CurrentPage[PROP_COMMON_PORTALINFO] = this._commonPortalInfo.ToXml();
				Global.EPDataFactory.Save( this.CurrentPage, EPiServer.DataAccess.SaveAction.Publish );
			}
			catch (Exception x)
			{
				System.Diagnostics.Debug.WriteLine("Could not persist portal info.\r\n" + x.ToString());
			}
		}
		#endregion


		private void Page_Load(object sender, System.EventArgs e)
		{
			SetupConsumerContext();

			if(!IsPostBack) 
			{
				try 
				{
					this.UserPortalInfo = this.CommonPortalInfo.Merge( this.UserPortalInfo );

					object o = this.CurrentPage[PROP_LAYOUT_CONTROLS];
					string[] layoutControls = ((string) o).Split(',');
					string activeControlName = this.UserPortalInfo.Tabs[this.TabControl.CurrentTabIndex].UserControlName;
					foreach(string ctrl in layoutControls) 
					{
						IPortalLayout temp = this.LoadControl("~" + ctrl) as IPortalLayout;
						ListItem newItem = new ListItem( temp.LayoutName, ctrl );
						if ( activeControlName != null 
							&& ctrl.ToLower().TrimStart('~').Equals( activeControlName.ToLower().TrimStart('~') ) )
							newItem.Selected = true;

						this.LayoutList.Items.Add( newItem );
					}
				} 
				catch( HttpException ex ) 
				{
					ErrorMsg.Text = EPiServer.Global.EPLang.Translate( "/templates/wsrpfx/portal/errorlayoutcontrolls" );
					log.Error( "Problem getting Layout controls for the WSRP consumer", ex );
					MainPanel.Visible = false;
				}
			}

			if ( ! IsPostBack ) 
			{
				this.ModeSelector.Items.Add( new ListItem(EPiServer.Global.EPLang.Translate("/templates/wsrpfx/portal/viewmode/view"),"View") );
				this.ModeSelector.Items.Add( new ListItem(EPiServer.Global.EPLang.Translate("/templates/wsrpfx/portal/viewmode/viewanduse"),"ViewAndUse") );
				if (this.CurrentUser.Identity.IsAuthenticated) { this.ModeSelector.Items.Add( new ListItem(EPiServer.Global.EPLang.Translate("/templates/wsrpfx/portal/viewmode/design"),"Design") ); }
			}
			if (!IsPostBack 
				&& Session["ModeSelector_SelectedIndex"] != null) 
			{
				try 
				{
					this.ModeSelector.SelectedIndex = (int) Session["ModeSelector_SelectedIndex"];
				} 
				catch 
				{
					Session["ModeSelector_SelectedIndex"] = this.ModeSelector.SelectedIndex;
				}
			}
			else 
			{
				Session["ModeSelector_SelectedIndex"] = this.ModeSelector.SelectedIndex;
			}

			// Handle Drag and drop actions etc.
			if (Request.Form[FORM_ACTION] != null) 
			{
				HandleClientActions();
			}

			// setup button state according 
			this.LinkButton1.Visible = this.CurrentUser.Identity.IsAuthenticated;
			this.LinkButton2.Visible = this.CurrentUser.Identity.IsAuthenticated && this.UserPortalInfo.Tabs.Length > 1;
			this.LinkButton3.Visible = this.Configuration.HasAdminAccess;
			this.SettingsPanel.Visible = this.DesignMode == "Design";
			this.TabControl.PortalInfo = this.UserPortalInfo;

			if (!IsPostBack)
			{
				HandleWsrpClick(Request.QueryString, Request.Form);
			}

			// Setup Portlet Control
			SetupLayout();

			// Perform Databinding wherever needed
			if (SettingsPanel.Visible) { PortletList.DataBind(); }
			LayoutContainer.DataBind();
			if ( !IsPostBack ) { TabName.DataBind(); }

			if ( FindSoloPortlet(this) != null ) 
			{
				// hide server form elements
				RegisterStartupScript("hideForm", @"<script type=""text/javascript"">hideForm();</script>");
			}
		}

		private void SetupLayout() 
		{
			LayoutContainer.Controls.Clear();
			
			string controlName = this.UserPortalInfo.Tabs[this.TabControl.CurrentTabIndex].UserControlName;
			if (controlName == null) { controlName = "~/templates/Units/WsrpSingleColumnLayout.ascx"; }
			Control ctrl = this.LoadControl( controlName );
			_portalLayout = (IPortalLayout) ctrl;
			_portalLayout.ViewMode = ModeSelector.SelectedItem.Value;
			int areaCount = _portalLayout.PortletAreas.Length;
			AreaSelect.Items.Clear();
			for (int i = 0; i < areaCount; i++) { AreaSelect.Items.Add(new ListItem((i+1).ToString(), i.ToString())); }
			
			LayoutContainer.Controls.Add( ctrl );

			RenderAvailablePortlets();
			
			PlacePortlets();
		}

		/// <summary>
		/// Operates on clientscript initiated requests
		/// </summary>
		private void HandleClientActions() 
		{
			switch (Request.Form[FORM_ACTION])
			{
				case ACTION_ADDPORTLET:
					IPortletKey key = ConsumerFactory.CreatePortletKey( Request.Form[FORM_PRODUCERID], Request.Form[FORM_PORTLETHANDLE] );
					string windowId = Guid.NewGuid().ToString();
					ConsumerContext.ClientPage.AddPortlet(key, windowId);
					this.UserPortalInfo.AddPortlet(
						this.TabControl.CurrentTabIndex, 
						Int32.Parse( Request.Form[FORM_POSITION] ), 
						Int32.Parse(Request.Form[FORM_PORTLETAREA]), 
						Request.Form[FORM_PRODUCERID], 
						Request.Form[FORM_PORTLETHANDLE], 
						windowId);
					break;

				case ACTION_REMOVEPORTLET:
					this.UserPortalInfo.RemovePortlet(this.TabControl.CurrentTabIndex, Int32.Parse( Request.Form[FORM_PORTLETAREA] ) , Request.Form[FORM_PORTLETHANDLE]);
					ConsumerContext.ClientPage.RemovePortlet(Request.Form[FORM_PORTLETHANDLE]);
					break;

				case ACTION_RESET:
					this.UserPortalInfo = this.CommonPortalInfo;
					IList list = ConsumerContext.StorageSession.ListRelationsFrom( ConsumerContext.User.Id );
					foreach ( IItem item in list ) 
					{
						ConsumerContext.StorageSession.Delete( item.Id );
					}
					this.TabControl.CurrentTabIndex = 0;
					ConsumerContext.ClientPage = GetClientPage( this.PageId );
					break;

				default:
					System.Diagnostics.Debug.WriteLine("Action '" + Request.Form[FORM_ACTION] + "' not supported");
					break;
			}
		}


		#region EventHandlers

		protected void Tab_Changed(object sender, EventArgs e) 
		{
			ConsumerContext.ClientPage = GetClientPage(this.PageId);
			SetupLayout();
			TabName.DataBind();
			this.DataBind();
		}

		protected void SaveTabSettings_Click(object sender, EventArgs e) 
		{
			this.UserPortalInfo.Tabs[TabControl.CurrentTabIndex].Name = TabName.Text;
			this.UserPortalInfo.Tabs[TabControl.CurrentTabIndex].UserControlName = "~" + LayoutList.Items[LayoutList.SelectedIndex].Value;
			this.TabControl.PortalInfo = this.UserPortalInfo;
			SetupLayout();
		}

		protected void AddTab_Click(object sender, EventArgs e) 
		{
			int idx = this.UserPortalInfo.AddTab("New tab");
			this.TabControl.CurrentTabIndex = idx;
		}
		protected void RemoveTab_Click(object sender, EventArgs e) 
		{
			if ( this.UserPortalInfo.Tabs.Length == 1 || 
				!this.UserPortalInfo.Tabs[TabControl.CurrentTabIndex].AllowRemove ) { return; }

			this.UserPortalInfo.RemoveTab(this.TabControl.CurrentTabIndex);
			this.TabControl.CurrentTabIndex = 0;
		}


		protected void SaveMaster_Click(object sender, EventArgs e) 
		{
			this.CommonPortalInfo = this.UserPortalInfo;
		}

		protected void ResetMaster_Click(object sender, EventArgs e) 
		{
			this.CommonPortalInfo = new WsrpPortalInfo();
		}

		bool _error = false;
		private void Page_Error(object sender, EventArgs e)
		{
			ConsumerContext.StorageSession.RollbackTransaction();
			_error = true;
		}

		private void Page_Unload(object sender, EventArgs e)
		{
			if (!_error) 
			{
				ConsumerContext.StorageSession.Save( (IItem) ConsumerContext.ClientPage );
				ConsumerContext.StorageSession.Save( (IItem) ConsumerContext.ConsumerState );
				ConsumerContext.StorageSession.Save( (IItem) this.PersistentSession );
			}
			ConsumerContext.StorageSession.Close();
		}

		#endregion

		private const string WsrpPortalPage = "wsrpportalpage";

		public void SetupConsumerContext()
		{
			// provide the consumer url so that UrlRewrite can be performed
			// ConsumerUrl must be on the form: http://hostname/path/page.aspx for the rewrite to work correctly
			Uri url = new Uri(EPiServer.Global.EPConfig.HostUrl + CurrentPage.LinkURL + 
				((bool)Global.EPConfig["EPfEnableFriendlyURL"] ? "Post.aspx" : String.Empty));
			ConsumerContext.ConsumerUrl	= url.AbsolutePath;
			ConsumerContext.UserAgent	= Request.UserAgent;
			ConsumerContext.ProxyUrl	= "Resource.aspx";

			// Set new list of supported locales with the current UI locale as the first entry
			ArrayList locales = new ArrayList();
			locales.Add(EPiServer.Core.LanguageContext.Current.CurrentUILanguageID);
			foreach (string locale in ConsumerContext.ConsumerEnvironment.SupportedLocales)
			{
				if (!locales.Contains(locale))
					locales.Add(locale);
			}
			ConsumerContext.ConsumerEnvironment.SupportedLocales = (string[])locales.ToArray(typeof(string));

			// Get user
			IUser user = ConsumerContext.ConsumerEnvironment.UserRegistry[Context.User.Identity.Name];
			if (user == null)
			{
				user = ConsumerFactory.CreateUser(Context.User.Identity.Name, Context.User.Identity.IsAuthenticated ? Constants.AuthenticationPassword : Constants.AuthenticationNone);
				ConsumerContext.ConsumerEnvironment.UserRegistry.Add( user );
			}
			else
			{
				if (user.UserContext.userContextKey == null)
					user.UserContext.userContextKey = Context.User.Identity.Name;
			}
			ConsumerContext.User = user;

			if (ConsumerContext.User.UserAuthentication != Constants.AuthenticationNone)
			{

				// Get consumer state
				IItem consumerState = ConsumerContext.StorageSession.LoadPath(Constants.ConsumerStateItem, user);
				if (consumerState == null) 
				{
					consumerState = CreateConsumerState( user );
				}
				ConsumerContext.ConsumerState = consumerState;
			}
			else 
			{
				ConsumerContext.ConsumerState = this.CommonPortalInfo;
			}

			// Get client page
			ConsumerContext.ClientPage = GetClientPage(this.PageId);

			// Force consumer framework to append the episerver pageid to the query variables
			ConsumerContext.GlobalParameters.Add("id", CurrentPageLink.ToString());

			// Force consumer framework to append the episerver language id to the query variables
			ConsumerContext.GlobalParameters.Add("epslanguage", EPiServer.Core.LanguageContext.Current.CurrentUILanguageID);

			if (Context.Session != null)
				ConsumerContext.ClientSessionId = Context.Session.SessionID;
		}

		protected IClientPage GetClientPage(string pageName) 
		{
			String clientPageName = GetClientPageName(pageName);
			IClientPage clientPage = ConsumerContext.StorageSession.LoadPath(clientPageName, ConsumerContext.User) as IClientPage;
			if (clientPage == null) 
			{
				clientPage = CreateClientPage(clientPageName, ConsumerContext.User);
			}
			return clientPage;
		}

		protected IItem CreateConsumerState(IItem parent)
		{
			IItem consumerState = this.CommonPortalInfo; // implement IItem, set Id to unique id and Name=Constants.ConsumerStateItem
			ConsumerContext.StorageSession.Save(consumerState);
			ConsumerContext.StorageSession.AddRelation(parent.Id, consumerState.Id);

			return consumerState;
		}

		protected String GetClientPageName(String name)
		{
			return name + this.UserPortalInfo.Tabs[this.TabControl.CurrentTabIndex].Id;		// Should probably add tab name from ConsumerContext.ConsumerState
		}

		protected IClientPage CreateClientPage(String name, IItem parent)
		{
			IClientPage clientPage = ConsumerFactory.CreateClientPage(name);
			ConsumerContext.StorageSession.Save(clientPage);
			ConsumerContext.StorageSession.AddRelation(parent.Id, clientPage.Id);

			return clientPage;
		}

		protected void HandleWsrpClick(System.Collections.Specialized.NameValueCollection parameters, System.Collections.Specialized.NameValueCollection formParameters)
		{

			String windowId = parameters[Constants.PortletInstanceKey];
			if (windowId == null || windowId.Length == 0)
			{
				// Special case - if portlet is producer-offered portlet and not yet a consumer configured portlet,
				// PortletInstanceKey may be empty even though we have provided the information in our RuntimeContext.
				// If we can look up a single instance of the portletHandle on our page instead, ue that 
				// PortletInstanceHandle instead
				String portletHandle = parameters[Constants.PortletHandle];
				windowId = ConsumerContext.ClientPage.FindPortletInstanceKeyFromHandle(portletHandle);
				if (windowId == null || windowId.Length == 0)
					return;
			}

			
			IPortletWindowSession windowSession = null;
			try { windowSession = ConsumerContext.ClientPage.GetPortletWindowSession(windowId); }
			catch (Exception x) { System.Diagnostics.Debug.WriteLine( x.ToString() ); }
			if (windowSession == null)
				return;

			String newMode = parameters[CHANGE_MODE];
			if (newMode != null)
			{
				windowSession.Mode = newMode;
				return;
			}

			String newState = parameters[CHANGE_STATE];
			if (newState != null)
			{
				ConsumerContext.ClientPage.ChangeWindowState(windowSession, newState);
				return;
			}

			String urlType = parameters[Constants.UrlType];	
			if (urlType == Constants.UrlTypeBlockingAction)
			{
				ConsumerContext.ClientPage.PerformPortletInteraction(windowSession, parameters, formParameters);
				return;
			}

//			if (urlType == Constants.UrlTypeRender)
//			{
//				PerformPortletRender(windowSession, parameters);
//				return;
//			}

			// TODO maybe check for non null urlType and throw an exception...
		}


		private void RenderAvailablePortlets()
		{
			foreach (DictionaryEntry entry in ConsumerContext.ConsumerEnvironment.ProducerRegistry) 
			{
				IProducer prod = entry.Value as IProducer;

				ServiceDescription sd =  null;
				try 
				{
					System.Diagnostics.Debug.WriteLine("Getting service description from producer: " + prod.Name );
					sd = prod.ServiceDescription;
				}
				catch
				{
					System.Diagnostics.Debug.WriteLine("ServiceDescription could not be obtained from producer: " + prod.Name );
					continue;
				}
				foreach( PortletDescription portlet in sd.offeredPortlets ) 
				{
					IPortletKey key = ConsumerFactory.CreatePortletKey( prod.ProducerId, portlet.portletHandle );
					if (!ConsumerContext.ConsumerEnvironment.PortletRegistry.Exists(key)) 
					{
						System.Diagnostics.Debug.WriteLine("Adding portet " + prod.Name + " to registry. ");
						ConsumerContext.ConsumerEnvironment.PortletRegistry.Add( ConsumerFactory.CreateWsrpPortlet( key ) );
					}
				}
			}

		}

		private void PlacePortlets()
		{
			PortletArea[] pas = ((IPortalLayout) _portalLayout).PortletAreas;
			TabInfo tab = this.UserPortalInfo.Tabs[this.TabControl.CurrentTabIndex];

			for ( int i = 0; i < pas.Length && i < tab.Areas.Length; i++ ) 
			{
				foreach (PortletInfo pi in tab.Areas[i].Portlets) 
				{
					IPortletKey key = ConsumerContext.ClientPage.PortletKey(pi.WindowId); // ConsumerFactory.CreatePortletKey( pi.ProducerId, pi.PortletId );

					if ( key == null)
					{
						ConsumerContext.ClientPage.AddPortlet(ConsumerFactory.CreatePortletKey( pi.ProducerId, pi.PortletId), pi.WindowId);
					}
	
					// Create a PortletData control used for rendering
					PortletData pd = new PortletData();
					pd.WindowId = pi.WindowId;
					pas[i].Controls.Add(pd);
				}
			}
		}

		private PortletData FindSoloPortlet(Control parent) 
		{
			PortletData pd;
			foreach (Control child in parent.Controls) 
			{
				try
				{
					pd = child as PortletData;
					if (pd != null) 
					{
						if (pd.PortletDriver == null)
							return null;

						if (! ConsumerContext.ConsumerEnvironment.ProducerRegistry.Exists( pd.PortletDriver.Portlet.PortletKey.ProducerId )) 
						{ 
							return null; 
						}
						if (pd.WindowState == Constants.WindowStateSolo) 
							return pd;
					}
					else 
					{
						pd = FindSoloPortlet(child);
						if (pd != null) 
							return pd;
					}
				}
				catch (WsrpException)
				{
					return null;
				}
			}
			return null;
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
			this.Error += new EventHandler(this.Page_Error);
			this.Unload += new EventHandler(this.Page_Unload);

		}
		#endregion

	}
}
