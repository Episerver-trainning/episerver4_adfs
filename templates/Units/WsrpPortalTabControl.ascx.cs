namespace development.Templates.Units
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	using development.Templates.Wsrp.Consumer;

	/// <summary>
	///		Summary description for WsrpPortalTabControl.
	/// </summary>
	public class WsrpPortalTabControl : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Repeater TabStrip;
		protected System.Web.UI.WebControls.Panel PortalAreaPanel;

		private const string VS_CURR_TAB_IDX = "_CurrentTabIndex";

		private WsrpPortalInfo _portalInfo;

		public int CurrentTabIndex 
		{
			get 
			{
				if ( this.ViewState[VS_CURR_TAB_IDX] == null ) 
				{
					if (Session[VS_CURR_TAB_IDX] != null ) 
					{
						this.ViewState[VS_CURR_TAB_IDX] = Session[VS_CURR_TAB_IDX];
					}
					else 
					{
						this.ViewState[VS_CURR_TAB_IDX] = 0;
					}
				}
                return (int) this.ViewState[VS_CURR_TAB_IDX];
			}
			set 
			{
				this.ViewState[VS_CURR_TAB_IDX] = value;
				Session[VS_CURR_TAB_IDX] = value;
				if (_portalInfo != null) 
				{
					Bind();
					OnTabChanged(EventArgs.Empty);
				}
			}
		}
		public string CurrentTabName 
		{
			get { return _portalInfo.Tabs[CurrentTabIndex].Name; }
		}

		public event EventHandler TabChanged;

		protected virtual void OnTabChanged(EventArgs e) 
		{
			if (TabChanged != null) 
			{
				TabChanged(this, e);
			}
		}

		public WsrpPortalInfo PortalInfo 
		{
			get { return _portalInfo; }
			set { _portalInfo = value;
				Bind();
			}
		}

		protected void Tab_Command(object sender, CommandEventArgs e) 
		{
			int prevIndex = this.CurrentTabIndex;
			int newIndex = Int32.Parse((string) e.CommandArgument);
			if (prevIndex != newIndex) 
			{
				this.CurrentTabIndex = newIndex;
				OnTabChanged(EventArgs.Empty);
			}
			Bind();
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			System.Diagnostics.Trace.Assert( this.TabStrip != null );

			Bind();
		}

		private void Bind() 
		{
			this.TabStrip.DataSource = GetTabs();
			this.TabStrip.DataBind();
		}

		private int GetTabIndex(string tabName) 
		{
			for ( int i = 0; i < this._portalInfo.Tabs.Length; i++ ) 
			{
				if ( this._portalInfo.Tabs[i].Name == tabName ) { return i; }
			}
			return -1;
		}

		private object GetTabs() 
		{
			DataTable dt = new DataTable();
			DataColumn col = dt.Columns.Add( "TabName", typeof( string ) );
			DataColumn act = dt.Columns.Add( "Active", typeof( bool ) );
			DataColumn idx = dt.Columns.Add( "TabIndex", typeof( int ) );
			DataRow row;

			int i = 0;
			foreach(TabInfo tab in this.PortalInfo.Tabs) 
			{
				row = dt.NewRow();
				row[col] = tab.Name;
				row[act] = i == this.CurrentTabIndex;
				row[idx] = i++;
				dt.Rows.Add( row );
			}
			return dt;
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
