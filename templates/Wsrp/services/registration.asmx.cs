using System;
using System.ComponentModel;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace development.Templates.Wsrp.Services
{
	/// <summary>
	/// Summary description for registration.
	/// </summary>
	[System.Web.Services.WebServiceAttribute(Namespace="urn:oasis:names:tc:wsrp:v1:bind")]
	[System.Web.Services.WebServiceBindingAttribute(Name="WSRP_v1_Registration_Binding_SOAP", Namespace="urn:oasis:names:tc:wsrp:v1:bind")]
	[SoapDocumentService(RoutingStyle=SoapServiceRoutingStyle.RequestElement)]
	public class Registration : ElektroPost.Wsrp.Producer.Service.DefaultWsrpService
	{
		public Registration()
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
