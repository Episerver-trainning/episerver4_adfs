using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;

using SoapDocumentServiceAttribute	= System.Web.Services.Protocols.SoapDocumentServiceAttribute;
using SoapServiceRoutingStyle		= System.Web.Services.Protocols.SoapServiceRoutingStyle;

namespace development.Templates.Wsrp.Services
{
	/// <summary>
	/// Summary description for WsrpService.
	/// </summary>
	[WebService(Name="WSRPService", Namespace="urn:oasis:names:tc:wsrp:v1:bind")]
	[WebServiceBinding(Name="WSRP_v1_Markup_Binding_SOAP")]
	[WebServiceBinding(Name="WSRP_v1_Registration_Binding_SOAP")]
	[WebServiceBinding(Name="WSRP_v1_ServiceDescription_Binding_SOAP")]
	[WebServiceBinding(Name="WSRP_v1_PortletManagement_Binding_SOAP")]
	[SoapDocumentService(RoutingStyle=SoapServiceRoutingStyle.RequestElement)]
	public class WsrpService : ElektroPost.Wsrp.Producer.Service.DefaultWsrpService
	{
		public WsrpService()
		{
			//CODEGEN: This call is required by the ASP.NET Web Services Designer
			InitializeComponent();
		}

		#region Component Designer generated code
		
		//Required by the Web Services Designer 
		private IContainer components = null;
				
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if(disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);		
		}
		
		#endregion

	}
}
