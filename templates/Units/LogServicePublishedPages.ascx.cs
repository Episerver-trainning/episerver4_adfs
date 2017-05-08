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
using EPiServer.Diagnostics;
using EPiServer.WebControls;

using log4net;



namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for LogServicePublishedPages.
	/// </summary>
	public class LogServicePublishedPages : UserControlBase
	{
		protected Translate Heading;
		protected NewsList	PublishedPagesControl;
		protected Label		ErrorMsg;

	

		private void Page_Load(object sender, System.EventArgs e)
		{
			SetPublishedPages();
		}



		protected void SetPublishedPages()
		{
			if ( !log4net.LogManager.GetLogger( "EPiServer.DataAccess.PageSaveDB" ).IsDebugEnabled )
			{
				ErrorMsg.Text = Translate( "/templates/logservice/notactive" );
				return;
			}

			PageDataCollection ret = new PageDataCollection();
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

				DataSet data = client.PublishedPages( Global.EPConfig.SiteName );
				foreach( DataRow row in data.Tables["Pages"].Rows )
				{
					try 
					{
						PageData page = Global.EPDataFactory.GetPage( 
							new PageReference( (Int32)row["PageId"] ) );
						if( !page.IsDeleted )
							ret.Add( page );
					}
					catch( PageNotFoundException ) {}
					catch( AccessDeniedException ) {}
				}
				PublishedPagesControl.DataSource = ret;			
				PublishedPagesControl.DataBind();
			}
			catch ( Exception )
			{
				ErrorMsg.Text = Translate( "/templates/logservice/pagehits/noconnection" );
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
