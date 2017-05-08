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
				Url="~/templates/Workroom/Templates/Units/Settings.ascx",RequiredAccess=AccessLevel.Administer,SortIndex=8000, 
				LanguagePath="/templates/workroom/plugins/settings")]
	public class Settings : WorkroomControlBase, ICustomPlugInLoader, IWorkroomPlugin
	{
		protected System.Web.UI.WebControls.Panel				SettingsPanel;
		protected EPiServer.SystemControls.ValidationSummary	Summary;

		private void Page_Load(object sender, System.EventArgs e)
		{
			RenderSettingsControls();
		}

		#region IWorkroomPlugin implementation
		string IWorkroomPlugin.Name
		{
			get { return DisplayName; }
		}

		Boolean IWorkroomPlugin.IsActive
		{
			get { return IsAdministrator; }
			set { }
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return false; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return true; }
		}

		private IWorkroomPlugin[] GetWorkroomPlugins()
		{
			ArrayList list = new ArrayList();

			list.Add(new Overview());
			list.Add(new BulletinBoard());
			list.Add(new Calendar());
			list.Add(new News());

			// Forum not implemented. Once it is, just include it using this line:
			//list.Add(new Forum());

			return (IWorkroomPlugin[]) list.ToArray(typeof(IWorkroomPlugin));
		}
		#endregion

		private string GetIsActiveID(IWorkroomPlugin workroomPlugin)
		{
			return "IsActive_" + workroomPlugin.GetType().Name;
		}

		private TextBox AddTextBox(string id, string caption, string text)
		{
			TextBox textbox = new TextBox();
			textbox.ID = id;
			textbox.Text = text;
			textbox.CssClass = "large";

			Label label = new Label();
			label.Text = caption + ": ";
			label.CssClass = "descriptionsmall";

			Panel subPanel = new Panel();
			subPanel.Controls.Add(label);
			subPanel.Controls.Add(textbox);
			SettingsPanel.Controls.Add(subPanel);
			return textbox;
		}

		private CheckBox AddCheckBox(bool status, string id, string text)
		{
			CheckBox checkbox = new CheckBox();
			checkbox.Checked = status;
			checkbox.ID = id;
			checkbox.Text = text;
			Panel subPanel = new Panel();
			SettingsPanel.Controls.Add(subPanel);
			subPanel.Controls.Add(checkbox);
			return checkbox;
		}

		private void RenderSettingsControls()
		{
			AddTextBox("WorkroomName", Translate("common/name"), CurrentPage.PageName);

			SettingsPanel.Controls.Add(new HtmlGenericControl("br"));

			AddCheckBox(CurrentWorkroom.IsActiveWorkroom, "IsActive_Workroom", 
							Translate("common/captionsingle") + " " +
							Translate("plugins/settings/active"));

			SettingsPanel.Controls.Add(new HtmlGenericControl("hr"));
			foreach(IWorkroomPlugin workroomPlugin in GetWorkroomPlugins())
			{
				string text = workroomPlugin.Name + " " + Translate("plugins/settings/active");
				AddCheckBox(workroomPlugin.IsActive, GetIsActiveID(workroomPlugin),	text);
			}
		}

		protected void SaveButton_Click(object sender, System.EventArgs e)
		{
			try
			{
				Boolean isDirty = false;

				TextBox nameTextBox = FindControl("WorkroomName") as TextBox;			

				if (nameTextBox.Text.Length < 3)
					nameTextBox.Text = CurrentWorkroom.Page.PageName;
				else if (!CurrentWorkroom.Page.PageName.Equals(nameTextBox.Text))
				{
					isDirty = true;
					CurrentWorkroom.Page.PageName = nameTextBox.Text;
				}

				CheckBox workroomCheckbox = FindControl("IsActive_Workroom") as CheckBox;
			
				if (CurrentWorkroom.IsActiveWorkroom != workroomCheckbox.Checked)
				{
					isDirty = true;
					CurrentWorkroom.IsActiveWorkroom = workroomCheckbox.Checked;
				}

				foreach(IWorkroomPlugin workroomPlugin in GetWorkroomPlugins())
				{
					CheckBox checkbox = FindControl(GetIsActiveID(workroomPlugin)) as CheckBox;

					if (checkbox != null && (workroomPlugin.IsActive != checkbox.Checked))
					{
						isDirty = true;
						workroomPlugin.IsActive = checkbox.Checked;
					}
				}

				if (isDirty)
				{
					CurrentWorkroom.Save();
				}

				ReloadCurrentTab();
			}
			catch(Exception exc)
			{
				AddFailedValidator(exc.Message);
				return;
			}		
		}

		protected void CancelButton_Click(object sender, System.EventArgs e)
		{
			ReloadCurrentTab();
		}

		private void ReloadCurrentTab()
		{
			string redirectUrl;
			string tabName = Page.Server.UrlEncode(((WorkroomPage)Page).WorkRoomTabStrip.ActiveTab.Text);
			redirectUrl = PageReference.AddQueryString(CurrentPage.LinkURL,"SelectedWorkRoomTab",tabName);
			Response.Redirect(redirectUrl);
		}

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
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}