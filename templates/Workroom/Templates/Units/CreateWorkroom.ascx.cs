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
using EPiServer.DataAccess;
using EPiServer.FileSystem;
using EPiServer.Filters;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;
using EPiServer.WebControls;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	/// Create new workroom.
	/// </summary>
	public class CreateWorkroom : WorkroomControlBase
	{
		protected System.Web.UI.WebControls.Button SaveButton;
		protected System.Web.UI.WebControls.Button CancelButton;
		protected System.Web.UI.WebControls.Label HeaderLabel;
		protected System.Web.UI.WebControls.RequiredFieldValidator WorkroomNameValidator;
		protected EPiServer.SystemControls.ValidationSummary Summary;
		protected System.Web.UI.WebControls.TextBox WorkroomName;
		protected System.Web.UI.WebControls.Panel EditWorkroomPanel;
		private UnifiedDirectory _fileRoot;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			SaveButton.Enabled = true;
			FocusToInput(WorkroomName);
			DataBind();
		}

		protected WorkroomTemplate GetWorkroomTemplate()
		{
			PageReference configPage = (PageReference) CurrentPage["WorkroomsConfigPage"];
			WorkroomTemplateCollection templates = WorkroomTemplate.List(configPage);

			// Return the first template found (TO DO: select one of the templates from the collection)
			return templates.Count > 0 ? templates[0] : null;
		}

		protected void SaveButton_Click(object sender, System.EventArgs e)
		{
			try
			{
				Page.Validate();
				if(!Page.IsValid)
				{
					BuildErrorMessages();
					return;
				}		

				WorkroomTemplate workroomTemplate = GetWorkroomTemplate();

				if (workroomTemplate == null)
				{
					AddFailedValidator(EPiServer.Global.EPLang.Translate("/workroom/unabletofindworkroomtemplates"));
					return;
				}

				string workRoomFileRoot;

				workRoomFileRoot = CreateDocumentDirectory(WorkroomName.Text);
				Workrooms.Core.Workroom workroom = workroomTemplate.CreateWorkroom(CurrentPage.PageLink);
				workroom.Page.PageName = WorkroomName.Text;
				workroom.FileRoot = workRoomFileRoot;

				// By default all tabs are enabled
				for(int propertyIndex = 0; propertyIndex < workroom.Page.Property.Count; propertyIndex++)
				{
					PropertyData property = workroom.Page.Property[propertyIndex];
					if (property.Name.StartsWith("IsActive") && property.Type == PropertyDataType.Boolean)
						property.Value = true;
				}
				workroom.Save();
				workroom.SetMemberStatus(Sid.Load(UnifiedPrincipal.CurrentSid), MemberStatus.Administrator, true);

				Response.Redirect(workroom.Page.LinkURL);
			}
			catch(ArgumentException ex)
			{
				this.AddFailedValidator(EPiServer.Global.EPLang.Translate("/workroom/unabletocreateworkroom") + ex.Message);
			}
		}

		private string CreateDocumentDirectory(string workroomName)
		{	
			string newWorkroomName = workroomName;
			string newDirectoryName = newWorkroomName;
			int i = 0;

			while(FileRoot.GetSubdirectory(newDirectoryName) != null)
				newDirectoryName = newWorkroomName + (++i).ToString();

			UnifiedDirectory newDir = FileRoot.CreateSubdirectory(newDirectoryName);
			return newDir.Path;
		}

		public UnifiedDirectory FileRoot
		{
			get
			{
				if(_fileRoot == null)
				{
					if(CurrentPage["DocumentRootDirectory"] != null)
					{
						string documentRootDir = Configuration.RootDir + CurrentPage["DocumentRootDirectory"];
						_fileRoot = UnifiedFileSystem.GetDirectory(documentRootDir, AccessControlList.NoAccess);

						if (_fileRoot == null)
							throw new EPiServerException(EPiServer.Global.EPLang.Translate("/workroom/invalidrootdir") + " \"" + documentRootDir + "\"");
					}
					else
						throw new EPiServerException(EPiServer.Global.EPLang.Translate("/workroom/undefinedrootdir"));
				}
				return _fileRoot;
			}
		}

		protected void CancelButton_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("WorkroomList.aspx?id=" + CurrentPage.PageLink.ID);
		}


		override protected string CreateFailedValidationErrorMsg(string caption)
		{
			if (caption.Equals("/templates/workroom/workroomname"))
				caption = "/templates/workroom/common/name";

			return base.CreateFailedValidationErrorMsg(caption);
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
			this.ID = "WorkroomPageList";
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}