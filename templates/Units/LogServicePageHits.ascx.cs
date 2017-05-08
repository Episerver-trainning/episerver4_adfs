using System;
using System.Text;
using System.Data;
using System.Drawing;
using System.Xml;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.Diagnostics;

using log4net;



namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for LogServerLastUsers.
	/// </summary>
	public class LogServicePageHits : UserControlBase
	{
		protected	Translate	Heading;
		protected	new Label		Error;
		protected	Panel		Content;



		private void Page_Load(object sender, System.EventArgs e)
		{
		}



		private String CreatePageLink( Int32 pageId )
		{
			StringBuilder ret = new StringBuilder();
			try
			{
				PageData page = Global.EPDataFactory.GetPage( 
					new PageReference( pageId ) );
							
				if( !page.IsDeleted)
				{
					ret.Append( "<a href='" )
						.Append( page.LinkURL ).Append( "'>" )
						.Append( Server.HtmlEncode( page.PageName ) ).Append( "</a><br/>" );
				}
			} 
			catch ( Exception ) 
			{
				// the page can not be instanced skip the page
			}

			return ret.ToString();
		}

		
		
		protected String PageHits
		{
			get 
			{
				if ( !log4net.LogManager.GetLogger( "EPiServer.Util.PixelImg" ).IsInfoEnabled )
					return Translate( "/templates/logservice/notactive" );

				try
				{
					System.Collections.Hashtable isShowed = new System.Collections.Hashtable();
					StringBuilder ret = new StringBuilder();

					RealTimeAnalyzerView client = new RealTimeAnalyzerView();

					Uri address = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");
					Uri via;
					if( (String)EPiServer.Global.EPConfig["EPsLogServiceHost"] != String.Empty )
						via = new Uri("soap.tcp://" + EPiServer.Global.EPConfig["EPsLogServiceHost"] + "/RealTimeAnalyzerView");
					else
						via = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");

					client.Destination = new Microsoft.Web.Services2.Addressing.EndpointReference(address, via);

					DataSet data = client.GetMaxHits( Global.EPConfig.SiteName );

					if (data.Tables["Pages"].Rows.Count == 0)
					{
						return ret.ToString();
					}
					else
					{
						foreach( DataRow row in data.Tables["Pages"].Rows )
						{
							if( !(bool)isShowed.Contains( (Int32)row["PageId"] ) ) 
							{
								ret.Append( CreatePageLink( (Int32)row["PageId"] ) );
								isShowed[(Int32)row["PageId"]] = true;
							}
						}
						return ret.Append( "<br/>" ).ToString();
					}
				}
				catch ( Exception )
				{
					return Translate( "/templates/logservice/pagehits/noconnection" );
				}
			}
		}


		protected String RPS
		{
			get 
			{
				if ( !log4net.LogManager.GetLogger( "EPiServer.Util.PixelImg" ).IsInfoEnabled )
					return String.Empty;

				try
				{
					RealTimeAnalyzerView client = new RealTimeAnalyzerView();

					Uri address = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");
					Uri via;
					if( (String)EPiServer.Global.EPConfig["EPsLogServiceHost"] != String.Empty )
						via = new Uri("soap.tcp://" + EPiServer.Global.EPConfig["EPsLogServiceHost"] + "/RealTimeAnalyzerView");
					else
						via = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");

					client.Destination = new Microsoft.Web.Services2.Addressing.EndpointReference(address, via);

					return String.Format(
						Translate( "/templates/logservice/pagehits/totalpagehits" ), 
						client.RequestPerMinute( Global.EPConfig.SiteName ) );
				}
				catch ( Exception )
				{
					return String.Empty;
				}
				
			}
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
