using System;
using System.Runtime.Serialization;
using System.Collections.Specialized;
using EPiServer.BaseLibrary;

namespace development.Templates.Wsrp.Consumer
{
	/// <summary>
	/// Summary description for WsrpPortalPageSession.
	/// </summary>
	[Serializable]
	public class WsrpPortalPageSession : NameValueCollection, IItem
	{
		internal const string STORAGE_KEY = "wsrpportalpagesession";

		private Guid _id = Guid.NewGuid();

		public WsrpPortalPageSession() {}
		protected WsrpPortalPageSession(SerializationInfo info, StreamingContext context) : base(info, context) { }
		
		#region IItem Members

		public object Id
		{
			get
			{
				return _id;
			}
			set 
			{
				_id = (Guid)value;
			}
		}

		public string Name
		{
			get
			{
				return STORAGE_KEY;
			}
		}

		#endregion

	}
}
