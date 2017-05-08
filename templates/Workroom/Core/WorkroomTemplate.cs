using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using System;

namespace development.Templates.Workrooms.Core
{
	/// <summary>
	/// Summary description for WorkroomTemplate.
	/// </summary>
	public class WorkroomTemplate
	{
		PageData _page;

		public WorkroomTemplate(PageData page)
		{
			if (page == null)
				throw new Exception(EPiServer.Global.EPLang.Translate("/workroom/invalidpageinstance"));

			_page = page;
		}

		public static WorkroomTemplateCollection List(PageReference workroomsConfigLink)
		{
			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
			PropertyCriteria criteria = new PropertyCriteria();
			criteria.Name = "PageTypeID";
			criteria.Type = PropertyDataType.PageType;
			criteria.Condition = CompareCondition.Equal;
			criteria.Value = PageType.Load("Workroom").ID.ToString();
			criterias.Add(criteria);

			PageDataCollection pages = Global.EPDataFactory.FindPagesWithCriteria(workroomsConfigLink, criterias);
			
			WorkroomTemplateCollection templates = new WorkroomTemplateCollection();

			foreach(PageData page in pages)
			{
				templates.Add(new WorkroomTemplate(page));
			}
			
			return templates;
		}

		public Workroom CreateWorkroom(PageReference workroomListLink)
		{
			PageReference newWorkroomLink = Global.EPDataFactory.Copy(_page.PageLink, workroomListLink);
			Workroom workroom = new Workroom(Global.EPDataFactory.GetPage(newWorkroomLink, LanguageSelector.MasterLanguage()));
			return workroom;
		}

		public PageData Page
		{
			get { return _page; }
		}
	}
}
