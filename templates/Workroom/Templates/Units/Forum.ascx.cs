using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	///	The Forum tab.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/Forum.ascx",SortIndex=3000, 
				LanguagePath="/templates/workroom/plugins/forum")]
	public class Forum : WorkroomControlBase, ICustomPlugInLoader, IWorkroomPlugin
	{
		#region IWorkroomPlugin implementation
		string IWorkroomPlugin.Name
		{
			get { return DisplayName; }
		}

		Boolean IWorkroomPlugin.IsActive
		{
			get 
			{ 
				return CurrentPage["IsActiveForum"] != null && (bool)CurrentPage["IsActiveForum"] == true;
			}
			set 
			{ 
				CurrentPage["IsActiveForum"] = value;
			}
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return true; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return false; }
		}
		#endregion

		public PlugInDescriptor[] List()
		{
			return GetPlugInDescriptor();
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
		}
		#endregion
	}
}