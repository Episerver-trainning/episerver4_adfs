using System;
using ElektroPost.Wsrp.V1.Types;

namespace development.Templates.Wsrp.Core
{
	/// <summary>
	/// Summary description for BlockingInteractionEventArgs.
	/// </summary>
	public class BlockingInteractionEventArgs : EventArgs
	{
		private PerformBlockingInteraction	_request;
		private BlockingInteractionResponse	_response;
		private Boolean						_returnMarkup;

		public BlockingInteractionEventArgs(PerformBlockingInteraction request, BlockingInteractionResponse response)
		{
			_request = request;
			_response = response;
		}

		public PerformBlockingInteraction Request
		{
			get { return _request; }
		}

		public BlockingInteractionResponse Response
		{
			get { return _response; }
		}

		public Boolean ReturnMarkup
		{
			get { return _returnMarkup; }
			set { _returnMarkup = value; }
		}

		public String GetParameter(string key) 
		{
			if (Request.interactionParams == null || Request.interactionParams.formParameters == null)
				return null;

			NamedString[] parameters = Request.interactionParams.formParameters;
			for (int i = 0; i < parameters.Length ; i++)
			{
				if (parameters[i].name == key)
					return parameters[i].value;
			}

			return null;
		}
	}
}
