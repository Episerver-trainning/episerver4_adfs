using System;
using System.Collections;
using System.Xml;
using System.Xml.XPath;

using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Security;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.Producer;
using ElektroPost.Wsrp.V1.Types;

using UserControlPortletInvoker = ElektroPost.Wsrp.Producer.Driver.UserControlPortletInvoker;


namespace development.Templates.Wsrp.Core
{
	/// <summary>
	/// Summary description for SampleProducerBase.
	/// </summary>
	public class ProducerBaseSupport
	{
		public ProducerBaseSupport()
		{
		}

		public static void InitializePortlets()
		{

			EPiServer.Implementation.Serialization.TypeSchemaBuilder.RegisterSchemaAndType( "WsrpPortalInfo", typeof( development.Templates.Wsrp.Consumer.WsrpPortalInfo) );
			EPiServer.Implementation.Serialization.TypeSchemaBuilder.RegisterSchemaAndType( "WsrpPortalPageSession", typeof( development.Templates.Wsrp.Consumer.WsrpPortalPageSession) );

			// Register for the translate event to translate UI strings for portlets
			ProducerFactory.TranslateEvent +=new TranslateTextEventHandler(ProducerFactory_TranslateEvent);

			// Register for the Resolve URL event
			ProducerFactory.ResolveEvent +=new ResolveUrlEventHandler(ProducerFactory_ResolveEvent);

			// Set path to supporting file for executing user controls
			ElektroPost.Wsrp.Producer.Service.AspNetGateway.UserControlExecutionFile = "/templates/wsrp/UserControlExecution.aspx";
			ElektroPost.Wsrp.Producer.Service.AspNetGateway.ApplicationRoot = EPiServer.Global.EPConfig.RootDir;
			
			// Set up the service description
			InitializeServiceDescription();

#if DEBUG
			ElektroPost.Wsrp.WsrpException.IsDebugMode = true;
#endif
		}

		public static void InitializeServiceDescription()
		{
			IDescriptionHandler descHandler = ElektroPost.Wsrp.Producer.ProducerFactory.DescriptionHandlerInstance();
			ServiceDescription desc = descHandler.CurrentServiceDescription;
			desc.locales = new string[] {"en","sv"};

			// Send all EPiServer groups as acceptable userCategories
			SetUserCategories(desc);

			desc.requiresInitCookie = CookieProtocol.perUser;
			descHandler.Save();
		}

		protected static void SetUserCategories(ServiceDescription desc)
		{
			ArrayList categories = new ArrayList();

			// Get all groups from EPiServer and set as allowed userCategories in WSRP
			foreach (Sid sid in Sid.List(SecurityIdentityType.AnyGroupSid))
			{
				categories.Add(new ItemDescription(sid.Name, new LocalizedString(sid.Description, Constants.LocaleEnglish, Constants.UserCategoryDescription + sid.Name)));
			}

			// If you have other groups/roles/categories that you want to support, simply add 
			// new ItemDescriptions for those roles to categories here.

			desc.userCategoryDescriptions = (ItemDescription[])categories.ToArray(typeof(ItemDescription));
		}

		private static void ProducerFactory_ResolveEvent(object sender, ElektroPost.Wsrp.Producer.ResolveEventArgs e)
		{
			if (e.TagName == "a")
			{
				// Adjust id-parameter to handle navigation
				e.Url = e.Url.Replace("id=", "wsrp-navigationalState=");

				// Do not convert these URL-types
				if (e.Url != "thispage.aspx" && !e.Url.StartsWith(EPiServer.Global.EPConfig.RootDir) && !e.Url.StartsWith("/") )
					e.UrlType = ElektroPost.Wsrp.Constants.UrlTypePassthrough;

				// Adjust for documents 
				if (e.Url.EndsWith(".doc") || e.Url.EndsWith(".ppt") || e.Url.EndsWith(".xls") || e.Url.EndsWith(".pdf") || e.Url.EndsWith(".zip") || e.Url.EndsWith(".txt"))
				{
					e.UrlType = ElektroPost.Wsrp.Constants.UrlTypeResource;
				}
			}

			if (e.TagName == "form")
			{
				// Adjust id-parameter to handle navigation
				e.Url = e.Url.Replace("id=", "wsrp-navigationalState=");
			}

			// Make sure that all reource URLs have protocol and host (see paragraph 10.2.1.1.3.1 in WSRP 1.0 spec)
			if (e.UrlType == ElektroPost.Wsrp.Constants.UrlTypeResource)
			{
				if (e.Url.StartsWith("http://127.0.0.1"))
				{
					// Remove "http://127.0.0.1" - actual host name will be added below
					e.Url = e.Url.Substring(16);
				}

				// if no protocol delimiter...
				if (e.Url.IndexOf("://") < 0)
				{
					if (!e.Url.StartsWith("/"))
					{
						e.Url += "/";
					}
					e.Url = EPiServer.Global.EPConfig.HostUrl + e.Url;
				}
			}
		}

		[Obsolete("Replace with call to EPiServer.Global.EPDataFactory.GetPage", false)]
		public static PageData GetAdjustedPage(string id)
		{
			int idstring;
			try
			{
				idstring = int.Parse( id );
				return GetAdjustedPage( idstring );
			}
			catch
			{
				return null;
			}
		}

		[Obsolete("Replace with call to EPiServer.Global.EPDataFactory.GetPage", false)]
		public static PageData GetAdjustedPage(int id)
		{
			return Global.EPDataFactory.GetPage( new PageReference( id ) );
		}

		[Obsolete("No need to call this method - remove call", false)]
		public static PageData AdjustPage(PageData page)
		{
			for(int i = 0; i <page.Property.Count; i++)
			{
				if(page.Property[i].Type == PropertyDataType.LongString && !page.Property[i].IsNull)
					page.Property[i].Value = ((string)page.Property[i].Value).Replace("src=\"/","src=\""+ EPiServer.Global.EPConfig.HostUrl + "/");
			}
			return page;
		}

		private static void ProducerFactory_TranslateEvent(object sender, TranslateEventArgs e)
		{
			// Get name of portlet as the "stripped down" filename-only part (everything between last slash and first dot)
			String portletName = e.Portlet.Name.ToLower(System.Globalization.CultureInfo.InvariantCulture);
			Int32 slashPos = portletName.LastIndexOfAny(new Char[] {'/', '\\'});
			if (slashPos >= 0)
				portletName = portletName.Substring(slashPos + 1);

			Int32 dotPos = portletName.IndexOf('.');
			if (dotPos >= 0)
				portletName = portletName.Substring(0, dotPos);

			// Look in the language document for translations for all existing languages
			foreach (LanguageNode languageNode in Global.EPLang.LanguageDocument.Root.Children)
			{
				string language = languageNode.Name;
				string translated = Global.EPLang.LanguageDocument.Translate("/wsrp/portlets/" + portletName + "/" + e.Text, language);
				if (translated == null)
					continue;
				e.AddTranslation(translated, language);
			}
		}
	}
}
