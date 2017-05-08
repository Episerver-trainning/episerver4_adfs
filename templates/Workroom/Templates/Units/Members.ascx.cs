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
	///	The Members tab.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/Members.ascx",RequiredAccess=AccessLevel.Administer,SortIndex=7000, 
				LanguagePath="/templates/workroom/plugins/members")]
	public class Members : WorkroomControlBase, ICustomPlugInLoader, IWorkroomPlugin
	{
		protected DataGrid			WorkroomMembers;
		protected DataGrid			SearchHits;
		protected TextBox			SearchText;
		protected Panel				ActiveMembersArea;
		protected Panel				AddMembersArea;
		protected Panel				EditUserArea;
		protected RadioButtonList	EditMemberStatus;

		private void Page_Load(object sender, System.EventArgs e)
		{
			LoadUsers();
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
		#endregion

		protected Sid GetSid(DataGridItem item)
		{
			return item.DataItem as Sid;
		}

		protected String GetUserDisplayName(Sid sid)
		{
			if(sid is UserSid)
				return ((UserSid)sid).DisplayName;
			return sid.Name;
		}
		protected String GetUserEmail(Sid sid)
		{
			if(sid is UserSid)
				return ((UserSid)sid).Email;
			return String.Empty;
		}
		protected String GetUserTelephone(Sid sid)
		{
			if(sid is UserSid)
				return ((UserSid)sid).Telephone;
			return String.Empty;
		}

		protected void SearchUser_Click(object sender, System.EventArgs e)
		{
			DoSearch();
		}

		private void DoSearch()
		{
			String searchText = SearchText.Text;
			String firstname = String.Empty, lastname = String.Empty, email = String.Empty;
			String advancedSearch = String.Empty;

			if(searchText.IndexOf(' ') > 0)
			{
				firstname	= searchText.Substring(0, searchText.IndexOf(' ') - 1);
				lastname	= searchText.Substring(searchText.IndexOf(' ') + 1);	
			}
			else if(searchText.IndexOf('@') > 0)
				email = searchText;
			else
				advancedSearch = searchText;

			if(advancedSearch.Length > 0)
				SearchResults = DoAdvancedSearch(advancedSearch);
			else
				SearchResults = Sid.Search(SecurityIdentityType.AnySidType, false, null, firstname, lastname, email, null);
			SearchHits.DataBind();
			FocusToInput(SearchText);
		}
		private SidCollection DoAdvancedSearch(String searchString)
		{
			SidCollection firstSearch = Sid.Search(SecurityIdentityType.AnyUserSid, false, searchString, null, null, null, null);
			SidCollection secondSearch = Sid.Search(SecurityIdentityType.AnyUserSid, false, null, searchString, null, null, null);
			SidCollection thirdSearch = Sid.Search(SecurityIdentityType.AnyUserSid, false, null, null, searchString, null, null);

			MergeSidCollections(firstSearch, secondSearch);
			MergeSidCollections(firstSearch, thirdSearch);

			return firstSearch;
		}
		private void MergeSidCollections(SidCollection collectionToAddTo, SidCollection collectionToAddFrom)
		{
			foreach(Sid sid in collectionToAddFrom)
			{
				if(!collectionToAddTo.Contains(sid))
					collectionToAddTo.Add(sid);
			}
		}

		protected void AddMember_Click(object sender, CommandEventArgs e)
		{
			int selectedMemberID = Int32.Parse(e.CommandArgument.ToString());
			Sid user = Sid.Load(selectedMemberID);
			CurrentWorkroom.SetMemberStatus(user, MemberStatus.User, false);

			DoSearch();
		}

		protected void RemoveMember_Click(object sender, CommandEventArgs e)
		{
			int selectedMemberID = Int32.Parse(e.CommandArgument.ToString());
			Sid user = Sid.Load(selectedMemberID);
			CurrentWorkroom.RemoveMember(user);
			LoadUsers();
		}

		protected void EditMember_Click(object sender, CommandEventArgs e)
		{
			int selectedID = Int32.Parse(e.CommandArgument.ToString());
			Sid sid = Sid.Load(selectedID);

			SelectedSid = sid;
				
			EditMemberStatus.Items.Clear();
			EditMemberStatus.Items.Add(new ListItem(Translate("memberstatus/guest"), ((Int32)MemberStatus.Guest).ToString()));
			EditMemberStatus.Items.Add(new ListItem(Translate("memberstatus/user"), ((Int32)MemberStatus.User).ToString()));
			EditMemberStatus.Items.Add(new ListItem(Translate("memberstatus/administrator"), ((Int32)MemberStatus.Administrator).ToString()));

			EditMemberStatus.SelectedValue = ((int)CurrentWorkroom.GetDistinctMemberStatus(sid)).ToString();

			EditUserArea.Visible = true;
			ActiveMembersArea.Visible = false;
		}

		private void LoadUsers()
		{
			WorkroomMembers.DataSource = CurrentWorkroom.GetMembers();
			WorkroomMembers.DataBind();
		}	
	
		protected string GetMemberStatusString(Sid member)
		{
			MemberStatus status = CurrentWorkroom.GetMemberStatus(member);
			return Translate("memberstatus/" + status.ToString().ToLower());
		}

		protected String GetSidMemberIcon(DataGridItem item)
		{
			Sid sid = GetSid(item);

			MemberStatus status = CurrentWorkroom.GetDistinctMemberStatus(sid);
			if(sid is GroupSid)
			{
				if(status == MemberStatus.None)
					return "group";
				else
					return "groupmember";
			}
			else
			{
				if(status == MemberStatus.None)
					return CurrentWorkroom.GetMemberStatus(sid) == MemberStatus.None ? "user" : "memberofgroup";
				else
					return "member";
			}
		}
		protected void ChangeMemberPaging(object sender, DataGridPageChangedEventArgs e)
		{
			WorkroomMembers.CurrentPageIndex = e.NewPageIndex;
			WorkroomMembers.DataBind();
		}
		protected void ChangeSearchPaging(object sender, DataGridPageChangedEventArgs e)
		{
			SearchHits.CurrentPageIndex = e.NewPageIndex;
			SearchHits.DataBind();
		}
		protected SidCollection SearchResults
		{
			get{return (SidCollection)ViewState["SearchResults"];}
			set{ViewState["SearchResults"] = value;}
		}

		protected void SetMemberHeaders(object sender, EventArgs e)
		{
			WorkroomMembers.Columns[1].HeaderText = Translate("/admin/secedit/editname");
			WorkroomMembers.Columns[2].HeaderText = Translate("/admin/secedit/editemail");
			WorkroomMembers.Columns[3].HeaderText = Translate("/admin/secedit/edittelephone");
			WorkroomMembers.Columns[4].HeaderText = Translate("/templates/workroom/members/memberstatusheader");
		}

		protected void SetSearchHitsHeaders(object sender, EventArgs e)
		{
			SearchHits.Columns[1].HeaderText = Translate("/admin/secedit/editname");
			SearchHits.Columns[2].HeaderText = Translate("/admin/secedit/editemail");
			SearchHits.Columns[3].HeaderText = Translate("/admin/secedit/edittelephone");
			SearchHits.Columns[4].HeaderText = Translate("/templates/workroom/members/memberstatusheader");
		}

		protected void SwitchView_Click(object sender, EventArgs e)
		{
			if(ActiveMembersArea.Visible)
			{
				ActiveMembersArea.Visible	= false;
				AddMembersArea.Visible		= true;
				FocusToInput(SearchText);
			}
			else
			{
				ActiveMembersArea.Visible	= true;
				AddMembersArea.Visible		= false;
				EditUserArea.Visible		= false;
			}
		}

		protected void SaveUserSettings_Click(object sender, System.EventArgs e)
		{
			try
			{
				Int32 selectedStatus = Int32.Parse(EditMemberStatus.SelectedValue);
				CurrentWorkroom.SetMemberStatus(SelectedSid, (MemberStatus)selectedStatus, false);
				SwitchView_Click(sender, e);
				LoadUsers();

			}
			catch(Exception exc)
			{
				AddFailedValidator(exc.Message);
				return;
			}
		}

		public Sid SelectedSid
		{
			get
			{
				return (Sid)ViewState["SelectedSid"];
			}
			set
			{
				ViewState["SelectedSid"] = value;
			}
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