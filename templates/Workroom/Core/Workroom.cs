using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAccess;
using EPiServer.FileSystem;
using EPiServer.Security;
using System.Text;
using System.Text.RegularExpressions;
using System;

namespace development.Templates.Workrooms.Core
{
	/// <summary>
	/// A class that represents a Workroom. 
	/// </summary>
	public class Workroom
	{
		private static readonly string WorkroomPageTypeName = "Workroom";

		private PageData	_page;

		#region Constructors

		public Workroom(PageData page)
		{
			if (page == null || !page.PageTypeName.Equals(WorkroomPageTypeName))
				throw new Exception(EPiServer.Global.EPLang.Translate("/workroom/invalidworkroompage"));

			_page = page;
		}

		#endregion

		#region Public static methods

		public static Workroom Load(int id)
		{
			return Load(Global.EPDataFactory.GetPage(new PageReference(id)));
		}

		public static Workroom Load(PageData page)
		{
			Workroom workroom = new Workroom(page);
			return workroom;
		}

		/// <summary>
		/// Create a new Workroom instance.
		/// </summary>
		/// <param name="parent">Workroom's parent page</param>
		/// <returns>An instantiated Workroom</returns>
		public static Workroom CreateWorkroom(PageReference parent)
		{
			PageData page = Global.EPDataFactory.GetDefaultPageData(parent, PageType.Load(WorkroomPageTypeName).ID);
			Workroom workroom = new Workroom(page);
			return workroom;
		}		
		#endregion

		#region Public methods
		public void Save()
		{
			Global.EPDataFactory.Save(_page, SaveAction.Publish, AccessControlList.NoAccess);
		}

		public void SetMemberStatus(Sid member, MemberStatus status, bool clearAclFirst)
		{
			AccessLevel level = GetAccessLevel(status);
			SaveFileAcl(FileRoot, member, level, clearAclFirst);
			SavePageAclRecursive(_page, member, level, clearAclFirst);
			ChangeMemberStatus(member, status);
		}

		private void ChangeMemberStatus(Sid member, MemberStatus newStatus)
		{
			if (newStatus == MemberStatus.None)
			{
				RemoveMember(member);
				return;
			}

			String memberInfo = (string)_page["MemberStatusInfo"];
			string newStatusString = member.ID.ToString() + ':' + ((Int32)newStatus).ToString();
			String searchPattern = member.ID.ToString() + ':' + "\\d*";
			
			if(memberInfo == null || memberInfo.Length == 0)
				_page["MemberStatusInfo"] = newStatusString;
			else if(!Regex.IsMatch(memberInfo, searchPattern))
				_page["MemberStatusInfo"] = memberInfo + ',' + newStatusString;
			else
				_page["MemberStatusInfo"] = Regex.Replace(memberInfo, searchPattern, newStatusString);

			Global.EPDataFactory.Save(_page, SaveAction.Publish, AccessControlList.NoAccess);
		}

		public void RemoveMember(Sid member)
		{	
			String memberInfo = (string)_page["MemberStatusInfo"];
			String searchPattern = member.ID.ToString() + ":\\d*";
			
			if (!Regex.IsMatch(memberInfo, searchPattern))
			{
				throw new EPiServerException(member.Name + " is not a member of workroom \"" + _page.PageName + "\"");
			}

			// Make sure any "," after of before the pattern is also removed from the list
			if (Regex.IsMatch(memberInfo, searchPattern + ','))
				searchPattern = searchPattern + ',';
			else if(Regex.IsMatch(memberInfo, ',' + searchPattern))
				searchPattern = ',' + searchPattern;

			memberInfo = Regex.Replace(memberInfo, searchPattern, String.Empty);
			_page["MemberStatusInfo"] = memberInfo;

			Global.EPDataFactory.Save(_page, SaveAction.Publish, AccessControlList.NoAccess);
		}

		public void SaveFileAcl(string path, Sid member, AccessLevel level, bool clearAclFirst)
		{
			UnifiedDirectory dir = UnifiedFileSystem.GetDirectory(path, AccessControlList.NoAccess);
			if(dir == null || !dir.Configuration.IsVirtualShare)
				return;
			EPiServer.Security.AccessControlList acl = dir.ACL;
			acl.IsInherited = false;
			if(clearAclFirst)
				acl.Clear();

			if(level == AccessControlList.NoAccess)
			{
				if(acl.Exists(member.ID))
					acl.Remove(member.ID);				
			}
			else
			{
				if(!acl.Exists(member.ID))
					acl.Add(member.ID, level);
				else
					acl[member.ID] = level;
			}
			acl.Save();
		}

		public void SavePageAclRecursive(PageData page, Sid member, AccessLevel level, bool clearAclFirst)
		{
			EPiServer.Security.AccessControlList acl = page.ACL;

			if(clearAclFirst)
				acl.Clear();

			if(level == AccessControlList.NoAccess)
			{
				if(acl.Exists(member.ID))
					acl.Remove(member.ID);				
			}
			else
			{
				if(!acl.Exists(member.ID))
					acl.Add(member.ID, level);
				else
					acl[member.ID] = level;
			}
			
			//We don't want to save Recursive as if empties the cache
			acl.Save();

			PageDataCollection children = Global.EPDataFactory.GetChildren(page.PageLink);
			foreach(PageData child in children)
				SavePageAclRecursive(child, member, level, clearAclFirst);
		}

		public AccessLevel GetAccessLevel(MemberStatus status)
		{
			switch(status)
			{
				case MemberStatus.Administrator:
					return AccessControlList.FullAccess;
				case MemberStatus.User:
					return AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit | AccessLevel.Publish;
				case MemberStatus.Guest:
					return AccessLevel.Read;
			}
			return AccessControlList.NoAccess;
		}

		public bool UserIsMember(Sid user)
		{
			return GetMemberStatus(user) != MemberStatus.None;
		}
		public bool UserIsDistinctMember(Sid user)
		{
			return GetDistinctMemberStatus(user) != MemberStatus.None;
		}

		public MemberStatus GetMemberStatus(int sidID)
		{
			return GetMemberStatus(Sid.Load(sidID));
		}

		public MemberStatus GetMemberStatus(Sid member)
		{
			MemberStatus highestStatus = MemberStatus.None;
			MemberStatus status;

			foreach(string memberInfo in MemberInfoRecords)
			{
				string[] info = memberInfo.Split(':');
				Int32 userID = Int32.Parse(info[0]);
				if(userID == member.ID)
					status = (MemberStatus)Int32.Parse(info[1]);
				else if(member is UserSid && IsMemberOfGroup((UserSid)member, userID))
					status = (MemberStatus)Int32.Parse(info[1]);
				else
					continue;
				if(highestStatus == MemberStatus.None || highestStatus > status)
					highestStatus = status;
			}
			return highestStatus;
		}
		public MemberStatus GetDistinctMemberStatus(Sid member)
		{
			foreach(string memberInfo in MemberInfoRecords)
			{
				string[] info = memberInfo.Split(':');
				Int32 userID = Int32.Parse(info[0]);
				if(userID != member.ID)
					continue;

				MemberStatus status = (MemberStatus)Int32.Parse(info[1]);
				return status;
			}
			return MemberStatus.None;
		}
		private bool IsMemberOfGroup(UserSid user, Int32 groupID)
		{
			foreach(GroupSid group in user.MemberOfGroups)
				if(groupID == group.ID)
					return true;
			return false;
		}

		private  String[] MemberInfoRecords
		{
			get
			{
				string memberinfo = (string)_page["MemberStatusInfo"];
				if(memberinfo == null)
					return new String[0];
				return memberinfo.Split(',');
			}
		}

		public SidCollection GetMembers()
		{
			SidCollection members = new SidCollection();

			foreach(string memberInfo in MemberInfoRecords)
			{
				string[] info = memberInfo.Split(':');
				Int32 userID = Int32.Parse(info[0]);
				Sid member = Sid.Load(userID);
				if(member != null)
					members.Add(member);
			}

			return members;
		}
		#endregion

		#region Properties
		public PageData Page
		{
			get { return _page; }
		}

		public Boolean IsActiveCalendar
		{
			get 
			{ 
				return _page["IsActiveWorkroom"] != null && (bool)_page["IsActiveWorkroom"] == true;
			}
			set 
			{ 
				if (!_page.Property.Exists("IsActiveWorkroom"))
				{
					_page.Property.Add("IsActiveWorkroom", new PropertyBoolean(value));
				}
				else
					_page["IsActiveWorkroom"] = value;
			}
		}

		public Boolean IsActiveWorkroom
		{
			get 
			{ 
				return _page["IsActiveWorkroom"] != null && (bool)_page["IsActiveWorkroom"] == true;
			}
			set 
			{ 
				if (!_page.Property.Exists("IsActiveWorkroom"))
				{
					_page.Property.Add("IsActiveWorkroom", new PropertyBoolean(value));
				}
				else
					_page["IsActiveWorkroom"] = value;
			}
		}

		public Boolean IsActiveBulletinBoard
		{
			get 
			{ 
				return _page["IsActiveBulletinBoard"] != null && (bool)_page["IsActiveBulletinBoard"] == true;
			}
			set 
			{ 
				if (!_page.Property.Exists("IsActiveBulletinBoard"))
				{
					_page.Property.Add("IsActiveBulletinBoard", new PropertyBoolean(value));
				}
				else
					_page["IsActiveWorkroom"] = value;
			}
		}

		public Boolean IsActiveNewsList
		{
			get 
			{ 
				return _page["IsActiveNewsList"] != null && (bool)_page["IsActiveNewsList"] == true;
			}
			set 
			{ 
				if (!_page.Property.Exists("IsActiveNewsList"))
				{
					_page.Property.Add("IsActiveNewsList", new PropertyBoolean(value));
				}
				else
					_page["IsActiveNewsList"] = value;
			}
		}

		public Boolean IsActiveFileList
		{
			get 
			{ 
				return _page["IsActiveFileList"] != null && (bool)_page["IsActiveFileList"] == true;
			}
			set 
			{ 
				if (!_page.Property.Exists("IsActiveFileList"))
				{
					_page.Property.Add("IsActiveFileList", new PropertyBoolean(value));
				}
				else
					_page["IsActiveFileList"] = value;
			}
		}

		public PageReference BulletinBoardRoot
		{
			get
			{
				return _page["BulletinBoardContainer"] == null ? PageReference.EmptyReference : (PageReference) _page["BulletinBoardContainer"];
			}
			set
			{
				_page["BulletinBoardContainer"] = value;
			}
		}

		public PageReference CalendarRoot
		{
			get
			{
				return _page["CalendarContainer"] == null ? PageReference.EmptyReference : (PageReference) _page["CalendarContainer"];
			}
			set
			{
				_page["CalendarContainer"] = value;
			}
		}

		public PageReference ForumRoot
		{
			get
			{
				return _page["ConferenceContainer"] == null ? PageReference.EmptyReference : (PageReference) _page["ConferenceContainer"];
			}
			set
			{
				_page["ConferenceContainer"] = value;
			}
		}

		public PageReference NewsListRoot
		{
			get
			{
				return _page["ListingContainer"] == null ? PageReference.EmptyReference : (PageReference) _page["ListingContainer"];
			}
			set
			{
				_page["ListingContainer"] = value;
			}
		}

		public String FileRoot
		{
			get
			{
				return _page["FileRoot"] == null ? String.Empty : (String)_page["FileRoot"];
			}
			set
			{
				_page["FileRoot"] = value;
			}
		}
		#endregion
	}
}