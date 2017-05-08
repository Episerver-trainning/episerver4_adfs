using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml;

using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.V1.Types;

using development.Templates.Wsrp.Core;

namespace development.Templates.Wsrp.PortletControls
{
	/// <summary>
	///		Summary description for MyControl.
	/// </summary>
	public class WsrpRssControl : WsrpUserControlBase
	{
		protected Repeater	RssNewsGrid;
		protected Label		ErrorMessage;

		protected PlaceHolder mainview;
		protected PlaceHolder configurationview;

		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		private void WsrpRssControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			String submit = EmptyAsNull(e.GetParameter("submit"));
			if (submit != null)
			{
				String url = EmptyAsNull(e.GetParameter("theurl"));
				if (url != null && url.IndexOf("://") < 0)
					url = "http://" + url;

				PortletState["theurl"]		= url;
				PortletState["thetitle"]	= EmptyAsNull(e.GetParameter("thetitle"));
				PortletState["themaxcount"]	= EmptyAsNull(e.GetParameter("themaxcount"));

				// Always switch to view mode after getting edit mode parameters
				e.Response.updateResponse.newMode	= Constants.ModeView;
			}

			e.ReturnMarkup = true;
		}

		private void WsrpRssControl_PreRender(object sender, EventArgs e)
		{
			// Show customized portlet title
			// Note that if PortletState contains no information about "thetitle" it will return null.
			// The default  value of preferredTitle is null which means "use regular title"
			CurrentMarkupContext.preferredTitle = (String)PortletState["thetitle"];

			SetupDataGrid();
			SetDisplayMode( mainview, configurationview);
		}

		private void SetupDataGrid()
		{
			string url = (String)PortletState["theurl"];
			if (url == null)
				url = "http://www.episerver.com/RSS-PRESS-SE";

			DataTable feed;
			try
			{	
				feed = LoadFeed(url);
			}
			catch (Exception ex)
			{
				ErrorMessage.Visible = true;
				ErrorMessage.Text = Translate("/templates/news/errorbindingrsssource") + "<br /><br />" + ex.Message;
				return;
			}

			RssNewsGrid.DataSource = feed;	
			RssNewsGrid.DataBind();			
		}

		private DataTable LoadFeed(string url)
		{
			// Read the RSS feed
			XmlTextReader reader = new XmlTextReader(url);
			DataSet ds = new DataSet();
			ds.ReadXml(reader);			

			foreach (DataTable table in ds.Tables)
			{
				if (table.TableName == "item")
				{
					int maxcount = 5;
					if (PortletState["themaxcount"] != null)
					{
						try
						{ 
							maxcount = Int32.Parse((String)PortletState["themaxcount"]);
						}
						catch
						{ 
							// Ignore any error - we just care about success in parsing, otherwise default value will be used
						}
					}
					while (table.Rows.Count > maxcount)
						table.Rows.RemoveAt(maxcount);

					return table;
				}
			}

			return new DataTable();
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
			BlockingInteraction += new BlockingInteractionEventHandler(WsrpRssControl_BlockingInteraction);
			PreRender += new EventHandler(WsrpRssControl_PreRender);
		}
		#endregion

	}
}
