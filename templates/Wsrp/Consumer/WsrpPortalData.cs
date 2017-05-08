using System;
using System.Collections;
using System.Xml;
using System.Xml.Serialization;

namespace development.Templates.Wsrp.Consumer
{
	/// <summary>
	/// Summary description for WsrpPortalData.
	/// </summary>
	/// 
	[Serializable]
	public class WsrpPortalInfo : EPiServer.BaseLibrary.IItem
	{
		public TabInfo[] Tabs;
		public bool AllowTabCreation;
		private Guid _id = Guid.NewGuid();

		public WsrpPortalInfo() 
		{
			Tabs = new TabInfo[0];
		}

		public WsrpPortalInfo Merge( WsrpPortalInfo other ) 
		{
			WsrpPortalInfo merge = new WsrpPortalInfo();
			merge.AllowTabCreation = this.AllowTabCreation;

			ArrayList tabs1 = new ArrayList(this.Tabs);
			ArrayList tabs2 = new ArrayList(other.Tabs);
			ArrayList tabsm = new ArrayList();

			foreach ( TabInfo tab in tabs1 ) 
			{
				if (!tabs2.Contains(tab) && !tab.AllowRemove ) 
				{
					tabsm.Add( tab );
				}
				else if (tabs2.Contains(tab)) 
				{
					tabsm.Add( tab.Merge( (TabInfo) tabs2[ tabs2.IndexOf( tab ) ] ) );
					tabs2.Remove( tab );
				}
			}
			foreach ( TabInfo tab in tabs2 ) 
			{
				tabsm.Add( tab );
			}
			merge.Tabs = (TabInfo[]) tabsm.ToArray(typeof(TabInfo));
			merge._id = (Guid)other.Id;
			return merge;
		}

		public int AddTab(string name) 
		{
			ArrayList tabs = new ArrayList( this.Tabs );
			TabInfo newTab = new TabInfo();
			newTab.Name = name;
			newTab.AllowRemove = true;
			newTab.UserControlName = null;
			int idx = tabs.Add( newTab );

			this.Tabs = (TabInfo[]) tabs.ToArray(typeof(TabInfo) );
			return idx;
		}

		public void RemoveTab(int index) 
		{
			ArrayList tabs = new ArrayList( this.Tabs );
			tabs.RemoveAt( index );
			this.Tabs = (TabInfo[]) tabs.ToArray(typeof(TabInfo) );
		}

		public void AddPortlet(int tabIndex, int portletIndex, int portletArea, string producerId, string portletHandle, string windowId) 
		{
			PortletInfo portlet = new PortletInfo();
			portlet.AllowRemove = true;
			portlet.PortletId = portletHandle;
			portlet.ProducerId = producerId;
			portlet.WindowId = windowId;

			ArrayList areas = new ArrayList( this.Tabs[tabIndex].Areas );
			// dynamically increase the area collection if portletArea index points outside current bounds.
			if (areas.Count <= portletArea) 
			{
				int diff = portletArea-areas.Count+1;
				for (int i = 0; i < diff; i++) 
				{
					areas.Add(new AreaInfo());
				}
				this.Tabs[tabIndex].Areas = (AreaInfo[]) areas.ToArray(typeof(AreaInfo));
			}
			ArrayList portlets = new ArrayList( this.Tabs[tabIndex].Areas[portletArea].Portlets );
			portlets.Insert( portletIndex, portlet );
			this.Tabs[tabIndex].Areas[portletArea].Portlets = (PortletInfo[]) portlets.ToArray(typeof(PortletInfo));
		}

		public void RemovePortlet(int tabIndex, int portletArea, string windowId) 
		{
			int idx = this.Tabs[tabIndex].Areas[portletArea].IndexOfPortlet( windowId );
			if (idx < 0) return;
			ArrayList portlets = new ArrayList( this.Tabs[tabIndex].Areas[portletArea].Portlets );
			portlets.RemoveAt( idx );
			this.Tabs[tabIndex].Areas[portletArea].Portlets = (PortletInfo[]) portlets.ToArray(typeof(PortletInfo));
		}

		public string ToXml() 
		{
			System.IO.MemoryStream ms = new System.IO.MemoryStream();
			this.Save( ms );
			ms.Flush();
			ms.Position = 0;
			System.IO.StreamReader sr = new System.IO.StreamReader( ms );
			string xmlString = sr.ReadToEnd();
			sr.Close();
			return xmlString;
		}
		public void Save( System.IO.Stream s ) 
		{
			XmlSerializer serializer = new XmlSerializer( typeof(WsrpPortalInfo) );
			serializer.Serialize( s, this );
		}

		public static WsrpPortalInfo Load( String xml ) 
		{
			System.IO.MemoryStream ms = new System.IO.MemoryStream();
			System.IO.StreamWriter sw = new System.IO.StreamWriter( ms );
			sw.Write( xml );
			sw.Flush();
			ms.Position = 0;
			WsrpPortalInfo obj = Load( ms );
			ms.Close();
			return obj;
		}
		public static WsrpPortalInfo Load( System.IO.Stream s ) 
		{
			XmlSerializer serializer = new XmlSerializer( typeof(WsrpPortalInfo) );
			return (WsrpPortalInfo) serializer.Deserialize( s );
		}
		#region IItem Members

		public object Id
		{
			get { return _id; }
		}

		public string Name
		{
			get
			{
				return ElektroPost.Wsrp.Constants.ConsumerStateItem;
			}
		}

		#endregion
	}

	[Serializable]
	public class TabInfo 
	{
		public Guid Id = Guid.NewGuid();
		public string Name;
		public string UserControlName;
		public AreaInfo[] Areas;
		public bool AllowRemove;

		public TabInfo() 
		{
			Areas = new AreaInfo[0];
			UserControlName = "~/templates/units/WsrpSingleColumnLayout.ascx";
		}

		public override bool Equals(object obj)
		{
			TabInfo other = obj as TabInfo;
			if (other != null) 
			{
				return this.Id == other.Id;
			}
			return false;
		}
		public override int GetHashCode()
		{
			return this.Id.GetHashCode();
		}


		public TabInfo Merge(TabInfo other) 
		{
			TabInfo merge = new TabInfo();
			merge.Name = other.Name;
			merge.UserControlName = other.UserControlName;
			merge.Id = this.Id;

			ArrayList areas1 = new ArrayList(this.Areas);
			ArrayList areas2 = new ArrayList(other.Areas);
			ArrayList areasm = new ArrayList();

			foreach (AreaInfo area in areas1) 
			{
				if (!areas2.Contains(area)) 
				{
					areasm.Add( area );
				}
				else
				{
					areasm.Add( area.Merge( (AreaInfo) areas2[ areas2.IndexOf( area ) ] ) );
					areas2.Remove( area );
				}
			}
			foreach (AreaInfo area in areas2) 
			{
				areasm.Add( area );
			}
			merge.Areas = (AreaInfo[]) areasm.ToArray(typeof(AreaInfo));
			return merge;
		}
	}

	[Serializable]
	public class AreaInfo 
	{
		public Guid Id = Guid.NewGuid();
		public PortletInfo[] Portlets;

		public AreaInfo() 
		{
			Portlets = new PortletInfo[0];
		}

		public override bool Equals(object obj)
		{
			AreaInfo other = obj as AreaInfo;
			if (other != null) 
			{
				return this.Id == other.Id;
			}
			return false;
		}
        
		public override int GetHashCode()
		{
			return this.Id.GetHashCode();
		}

		public int IndexOfPortlet(string windowId) 
		{
			for (int i = 0; i < this.Portlets.Length; i++) 
			{
				if (this.Portlets[i].WindowId == windowId) { return i; }
			}

			return -1;
		}

		public AreaInfo Merge(AreaInfo other)
		{
			AreaInfo merge = new AreaInfo();
			merge.Id = this.Id;

			ArrayList portlets1 = new ArrayList(this.Portlets);
			ArrayList portlets2 = new ArrayList(other.Portlets);
			ArrayList portletsm = new ArrayList();

			foreach (PortletInfo portlet in portlets1) 
			{
				if (!portlets2.Contains(portlet)) 
				{
					portletsm.Add( portlet );
				}
				else
				{
					portletsm.Add( portlet.Merge( (PortletInfo) portlets2[ portlets2.IndexOf( portlet ) ] ) );
					portlets2.Remove( portlet );
				}
			}
			foreach (PortletInfo portlet in portlets2) 
			{
				portletsm.Add( portlet );
			}
			merge.Portlets = (PortletInfo[]) portletsm.ToArray(typeof(PortletInfo));
			return merge;
		}

	}

	[Serializable]
	public class PortletInfo 
	{
		public Guid Id = Guid.NewGuid();
		public string ProducerId;
		public string PortletId;
		public string WindowId;

		public string ViewMode;

		public bool AllowRemove;

		public PortletInfo() 
		{
		}

		public override bool Equals(object obj)
		{
			PortletInfo other = obj as PortletInfo;
			if (other != null) 
			{
				return this.WindowId == other.WindowId;
			}
			return false;
		}
		public override int GetHashCode()
		{
			//return this.WindowId.GetHashCode();
			return this.PortletId.GetHashCode();
		}


		public PortletInfo Merge(PortletInfo other) 
		{
			PortletInfo merge = new PortletInfo();
			merge.ProducerId = other.ProducerId;
			merge.PortletId = other.PortletId;
			merge.WindowId = other.WindowId;
//			merge.PortletArea = other.PortletArea;
			merge.AllowRemove = this.AllowRemove;
			merge.Id = this.Id;

			return merge;
		}
	}
}
