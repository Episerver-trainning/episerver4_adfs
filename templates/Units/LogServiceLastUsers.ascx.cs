using System;
using System.Text;
using System.Data;
using System.Drawing;
using System.Xml;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer;
using EPiServer.Diagnostics;

using log4net;



namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for LogServerLastUsers.
	/// </summary>
	public class LogServiceLastUsers : UserControlBase
	{
		private		DataSet	_data;



		private void Page_Load(object sender, System.EventArgs e)
		{
		}



		protected String ActiveUsers
		{
			get 
			{
				if ( !log4net.LogManager.GetLogger( "EPiServer.Util.PixelImg" ).IsInfoEnabled )
					return Translate( "/templates/logservice/notactive" );

				try
				{
					StringBuilder ret = new StringBuilder();

					if (Data.Tables["Users"].Rows.Count == 0)
					{
						return ret.ToString();
					}
					else
					{
						foreach( DataRow row in Data.Tables["Users"].Rows )
						{
							ret.Append( EPiServer.DataAbstraction.UserSid.Load( Convert.ToInt32( row["SID"] ) ).Name )
								.Append( " " )
								.Append( ((DateTime)row["LastActive"]).ToString( "HH:mm" ) )
								.Append( "<br/>" );
						}
						return ret.Append( "<br/>" ).ToString();
					}
				}
				catch ( Exception )
				{
					return Translate( "/templates/logservice/lastusers/noconnection" );
				}
			}
		}


		protected String CountUsers
		{
			get 
			{
				if ( !log4net.LogManager.GetLogger( "EPiServer.Util.PixelImg" ).IsInfoEnabled )
					return String.Empty;

				try
				{
					return String.Format(
						Translate( "/templates/logservice/lastusers/totalusers" ), 
						(Int32)Data.Tables["Total"].Rows[0]["Count"] );
				}
				catch ( Exception )
				{
					return String.Empty;
				}
				
			}
		}



		private DataSet Data
		{
			get 
			{
				if( _data != null )
						return _data;

				RealTimeAnalyzerView client = new RealTimeAnalyzerView();

				Uri address = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");
				Uri via;
				if( (String)EPiServer.Global.EPConfig["EPsLogServiceHost"] != String.Empty )
					via = new Uri("soap.tcp://" + EPiServer.Global.EPConfig["EPsLogServiceHost"] + "/RealTimeAnalyzerView");
				else
					via = new Uri("soap.tcp://localhost/RealTimeAnalyzerView");

				client.Destination = new Microsoft.Web.Services2.Addressing.EndpointReference(address, via);

				_data = client.LatestUsers( Global.EPConfig.SiteName );

				return _data;
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
