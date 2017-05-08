using System;
using System.Collections;
using System.IO;
using System.Net;
using System.Web;

using NameValueCollection = System.Collections.Specialized.NameValueCollection;

namespace development.Templates
{
	/// <summary>
	/// Summary description for Resource.
	/// </summary>
	public class Resource : System.Web.UI.Page
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			HttpWebResponse resp		= null;
			Stream			instream	= null;

			Response.Clear();
			try
			{
				String url = ResourceUrl();
				if (url == null)
					return;

				HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
				req.Method = "GET";

				TransferRequestHeaders(Request.Headers, req);

				resp = (HttpWebResponse)req.GetResponse();
				instream = resp.GetResponseStream();

				byte[] inData = new byte[4096];
				int bytesRead = instream.Read(inData, 0, inData.Length);
				while (bytesRead > 0)
				{
					Response.OutputStream.Write(inData, 0, bytesRead);
					bytesRead = instream.Read(inData, 0, inData.Length);
				}

				TransferResponseHeaders(resp, Response);

				Response.End();
			}
			catch (WebException ex)
			{
				resp = ex.Response as HttpWebResponse;
				if (resp == null || resp.Headers == null)
					throw;

				TransferResponseHeaders(resp, Response);
				Response.End();
			}
			finally
			{
				if (instream != null)
					instream.Close();
			}
		}

		private String ResourceUrl()
		{
			// Get url from query string
			String url = Request.QueryString[ElektroPost.Wsrp.Constants.Url];
			if (url == null || url.Length == 0)
				return null;

			// Decode url
			url = Server.UrlDecode(url);

			// Special handling to make sure we have a fully qualified url
			if (url.StartsWith("/"))
				url = Request.Url.Scheme + "://" + Request.Url.Host + url;

			return url;
		}

		private void TransferRequestHeaders(NameValueCollection headers, HttpWebRequest req)
		{
			foreach (String key in headers)
			{
				String val = headers[key];

				try
				{
					switch (key) 
					{
						case "Accept":
							req.Accept = val;
							break;
						case "Connection":
							if (val == "Keep-Alive")
							{
								req.KeepAlive = true;
							}
							else
							{
								req.Connection = val;
							}
							break;
						case "Content-Length":
							break;
						case "Content-Type":
							break;
						case "Expect":
							req.Expect = val;
							break;
						case "Date":
							break;
						case "Host":
							break;
						case "If-Modified-Since":
							req.IfModifiedSince = DateTime.Parse(val);
							break;
						case "Proxy-Connection":
							break;
						case "Range":
							break;
						case "Referer":
							break;
						case "Transfer-Encoding":
							break;
						case "User-Agent":
							req.UserAgent = val;
							break;
						default:
							req.Headers.Add(key, val);
							break;
					}
				}
				catch (ArgumentException)
				{
					// Ignore ArgumentExceptions, since they may be thrown if trying to assign
					// a Http header with req.Headers.Add rather than accessing thru a specific property.
					// Most of these cases should already been handled, but this is just a security
					// precaution.
				}
			}
		}

		private void TransferResponseHeaders(HttpWebResponse resp, HttpResponse response)
		{
			response.ClearHeaders();
			foreach (String key in resp.Headers)
			{
				switch (key)
				{
					case "Content-Type":
						response.ContentType = resp.ContentType;
						break;
					case "Date":
						break;
					case "Server":
						break;
					default:
						if (key.StartsWith("X-"))
							break;
						response.AppendHeader(key, resp.Headers[key]);
						break;
				}
			}
				
			response.StatusCode			= (Int32)resp.StatusCode;
			response.StatusDescription	= resp.StatusDescription;
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
