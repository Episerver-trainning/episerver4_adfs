using System;
using System.Web;
using System.Web.UI.WebControls;

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
	public class WsrpIframeControl : WsrpUserControlBase
	{
		protected PlaceHolder mainview;
		protected PlaceHolder configurationview;

		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		private void WsrpIframeControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			String submit = EmptyAsNull(e.GetParameter("submit"));
			if (submit != null)
			{
				String url = EmptyAsNull(e.GetParameter("theurl"));
				if (url != null && url.IndexOf("://") < 0)
					url = "http://" + url;

				PortletState["theurl"]		= url;
				PortletState["thetitle"]	= EmptyAsNull(e.GetParameter("thetitle"));
				PortletState["theheight"]	= EmptyAsNull(e.GetParameter("theheight"));

				// Since this portlet is the "receiver" of showpage, we should clear it to 
				// make sure that theurl is at least displayed after saving new settings.
				if (IsGroupSessionActive)
					GroupSession["showpage"] = null;

				// Always switch to view mode after getting edit mode parameters
				e.Response.updateResponse.newMode	= Constants.ModeView;
			}

			e.ReturnMarkup = true;
		}

		private void WsrpIframeControl_PreRender(object sender, EventArgs e)
		{
			// Show customized portlet title
			// Note that if PortletState contains no information about "thetitle" it will return null.
			// The default  value of preferredTitle is null which means "use regular title"
			CurrentMarkupContext.preferredTitle = (String)PortletState["thetitle"];

			// Select edit or normal view
			SetDisplayMode( mainview, configurationview);
		}

		public String RenderUrl()
		{
			if (IsGroupSessionActive && GroupSession["showpage"] != null)
				return (String)GroupSession["showpage"];

			if (PortletState["theurl"] != null)
				return (String)PortletState["theurl"];

			return "http://www.episerver.com";
		}

		public String RenderHeight()
		{
			if (PortletState["theheight"] != null)
				return PortletState["theheight"] + "px";

			return "300px";
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
			BlockingInteraction += new BlockingInteractionEventHandler(WsrpIframeControl_BlockingInteraction);
			PreRender += new EventHandler(WsrpIframeControl_PreRender);
		}
		#endregion

	}
}
