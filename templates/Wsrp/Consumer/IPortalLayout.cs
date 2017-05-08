using System;
using ElektroPost.Wsrp.Consumer.WebControls;

namespace development.Templates.Wsrp.Consumer
{
	/// <summary>
	/// Summary description for IPortalLayout.
	/// </summary>
	public interface IPortalLayout
	{
		PortletArea[] PortletAreas { get; }
		string ViewMode { get; set; }
		string LayoutName { get; }
	}
}
