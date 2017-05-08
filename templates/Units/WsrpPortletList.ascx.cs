namespace development.Templates.Units
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Collections;
	using ElektroPost.Wsrp.Consumer;
	using ElektroPost.Wsrp;
	using ElektroPost.Wsrp.V1.Types;

	//using development.Templates.Wsrp.Consumer;
	using EPiServer.Util;

	/// <summary>
	///		Summary description for WsrpPortletList.
	/// </summary>
	public class WsrpPortletList : System.Web.UI.UserControl
	{
		private Hashtable _availableProducers;

		public string[] AvailableProducers 
		{
			get 
			{
				EnsureAvailableProducers();
				ArrayList producers = new ArrayList( _availableProducers.Keys );
				return (string[]) producers.ToArray(typeof(string));
			}
		}

		public PortletDescription[] GetPortlets(string ProducerId) 
		{
			EnsureAvailableProducers();
			return (PortletDescription[]) _availableProducers[ProducerId];
		}

		private void EnsureAvailableProducers() 
		{
			if (_availableProducers == null) 
			{
				_availableProducers = new Hashtable();
				foreach (DictionaryEntry entry in ConsumerContext.ConsumerEnvironment.ProducerRegistry)
				{
					IProducer producer = entry.Value as IProducer;

					try 
					{
						ServiceDescription description = producer.ServiceDescription;
						PortletDescription[] portlets = description.offeredPortlets;
						foreach (PortletDescription pd in portlets) 
						{
							if (pd.displayName == null) 
							{
								pd.displayName = new LocalizedString("Display name unknown", "EN");
							}
							if (pd.title == null) 
							{
								pd.title = new LocalizedString("Title unknown", "EN");
							}
						}
						_availableProducers[producer.ProducerId] = portlets;
					}
					catch 
					{
						_availableProducers[producer.ProducerId] = new PortletDescription[0];
					}
				}
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			if (this.Visible) 
			{
				this.DataBind();

				this.Page.RegisterClientScriptBlock("WsrpPortletList", @"
<script type=""text/javascript"">
function toggle(producerId) { 
	var container;
	container = document.all['_Portlets' + producerId ];
	if(container.style.display == 'none') 
		container.style.display = '';
	else
		container.style.display = 'none';
}
</script>");
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
