<% @ webhandler language="C#" class="GetFile" %> 

using System; 
using System.Web;
using EPiServer.Core;
using EPiServer.FileSystem;
using EPiServer.Diagnostics;

[Language(SessionLanguage=true,QueryStringLanguage=true,CookieLanguage=true,HttpContextLanguage=true)]
public class GetFile : IHttpHandler 
{ 
   public bool IsReusable 
   { get { return true; } }
   
   public void ProcessRequest(HttpContext ctx) 
   { 
   
		DownloadManagerAction action = DownloadManagerAction.None;
				
		if(ctx.Request.QueryString["action"]!=null && ctx.Request.QueryString["action"].Length>0)
			action = (DownloadManagerAction)Enum.Parse(typeof(DownloadManagerAction),ctx.Request.QueryString["action"],true);
   
		string returnedFile = WebDownloadManager.TransmitFileEx(ctx.Request.QueryString["name"],ctx.Request.QueryString["ufv"],action);
		string sessionId = null;
		HttpCookie sessionCookie = ctx.Request.Cookies["ASP.NET_SessionId"];
		if (sessionCookie != null) 
		{
			sessionId = sessionCookie.Value;
			if (sessionId != null)
				sessionId = sessionId.ToLower(System.Globalization.CultureInfo.InvariantCulture);
		}
		StatisticsLog.Log( returnedFile!=null ? returnedFile : ctx.Request.QueryString["path"], HitType.File, sessionId, EPiServer.Security.UnifiedPrincipal.CurrentSid, EPiServer.Core.PageReference.EmptyReference, EPiServer.Security.UnifiedPrincipal.Current.Identity.Name, null );
   } 
}