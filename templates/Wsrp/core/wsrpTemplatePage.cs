using System;

using EPiServer;
using EPiServer.Core;

namespace development.Templates.Wsrp.Core
{
	/// <summary>
	/// Summary description for wsrpTempaltePage.
	/// </summary>
	public class WsrpTemplatePage : TemplatePage
	{
		private string	_navigationalState;

		public string NavigationalState
		{
			set{ 
				_navigationalState = value;
			}
			get{
				return _navigationalState;
			}
		}

		public WsrpTemplatePage()
		{
			//
			// TODO: Add constructor logic here
			//
		}


	}
}
