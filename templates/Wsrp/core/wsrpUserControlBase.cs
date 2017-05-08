using System;
using System.Collections;
using System.Web.UI.WebControls;

using EPiServer;
using EPiServer.Core;
using ElektroPost.Wsrp.Producer;
using ElektroPost.Wsrp.V1.Types;

using Constants = ElektroPost.Wsrp.Constants;

namespace development.Templates.Wsrp.Core
{
	public delegate void BlockingInteractionEventHandler(object sender, BlockingInteractionEventArgs e);

	/// <summary>
	/// Summary description for wsrpControl.
	/// </summary>
	public class WsrpUserControlBase : UserControlBase, EPiServer.Core.IPageSource
	{
		private IPortlet					_portlet;
		private GetMarkup					_markup;
		private MarkupResponse				_resp;
		private PerformBlockingInteraction	_interact;
		private BlockingInteractionResponse	_interactionResponse;

		private MarkupParams				_markupParams;
		private UserContext					_userContext;
		private PortletContext				_portletContext;
		private RuntimeContext				_runtimeContext;
		private MarkupContext				_markupContext;

		/// <summary>
		/// 
		/// </summary>
		public WsrpUserControlBase()
		{
			// Get markup and interaction data blocks. Note that only one of these should
			// be non-null (a WSRP request is either getMarkup of performBlockingInteraction)
			if (Context != null)
			{
				_markup					= Context.Items["wsrpMarkup"] as GetMarkup;
				_resp					= Context.Items["wsrpMarkupResponse"] as MarkupResponse;
				_interact				= Context.Items["wsrpBlockingInteraction"] as PerformBlockingInteraction;
				_interactionResponse	= Context.Items["wsrpBlockingInteractionResponse"] as BlockingInteractionResponse;
				_portlet				= Context.Items["wsrpPortlet"] as IPortlet;
			}

			// Get the sub-elements for generic access
			if (_markup != null)
			{
				_markupParams	= _markup.markupParams;
				_userContext	= _markup.userContext;
				_portletContext = _markup.portletContext;
				_runtimeContext	= _markup.runtimeContext;
				if (_resp != null)
				{
					_markupContext = _resp.markupContext;
				}
			}
			else if (_interact != null)
			{
				_markupParams	= _interact.markupParams;
				_userContext	= _interact.userContext;
				_portletContext = _interact.portletContext;
				_runtimeContext	= _interact.runtimeContext;
				if (_interactionResponse != null)
				{
					_interactionResponse.updateResponse.newMode				= ElektroPost.Wsrp.Constants.ModeView;
					_interactionResponse.updateResponse.navigationalState	= CurrentMarkupParams.navigationalState;
					_markupContext	= _interactionResponse.updateResponse.markupContext;
				}
			}
			else
			{
				_markupParams	= new MarkupParams();
				_userContext	= new UserContext();
				_portletContext = new PortletContext();
				_runtimeContext	= new RuntimeContext();
			}
		}

		protected override System.Web.UI.StateBag ViewState
		{
			get { return ((UserControlExecution)Page).PersistentViewState; }
		}

		public GetMarkup CurrentMarkup
		{
			get { return _markup; }
		}

		public MarkupParams CurrentMarkupParams
		{
			get{ return _markupParams; }
		}

		public UserContext CurrentUserContext
		{
			get{ return _userContext; }
		}

		public PortletContext CurrentPortletContext
		{
			get{ return _portletContext; }
		}

		public RuntimeContext CurrentRuntimeContext
		{
			get{ return _runtimeContext; }
		}

		public IPortlet CurrentPortlet
		{
			get { return _portlet; }
		}

		public MarkupContext CurrentMarkupContext
		{
			get { return _markupContext; }
		}

        /// <summary>
        /// Returns a string that can be used to prefix control identifiers to make them unique
        /// </summary>
        protected string UniquePrefix
        {
            get {
                if (!(CurrentRuntimeContext.namespacePrefix == null || CurrentRuntimeContext.namespacePrefix == String.Empty))
                {
                    return GetClientFriendlySegment(CurrentRuntimeContext.namespacePrefix);
                }
                return GetClientFriendlySegment(CurrentRuntimeContext.portletInstanceKey); 
            }
        }

        private string GetClientFriendlySegment(string segment)
        {
            return segment.GetHashCode().ToString().Replace('-', '_');
        }


		public string CurrentDisplayMode
		{
			get
			{
				if (_interactionResponse != null)
				{
					String mode = _interactionResponse.updateResponse.newMode;
					if (mode != null && mode.Length > 0)
						return mode;
				}

				return CurrentMarkupParams.mode;
			}
		}

		public string CurrentWindowState
		{
			get
			{
				if (_interactionResponse != null)
				{
					String state = _interactionResponse.updateResponse.newWindowState;
					if (state != null && state.Length > 0)
						return state;
				}

				return CurrentMarkupParams.windowState;
			}
		}

		public void SetDisplayMode(PlaceHolder view)
		{
			SetDisplayMode(view, null, null, null);
		}

		public void SetDisplayMode(PlaceHolder view, PlaceHolder edit)
		{
			SetDisplayMode(view, edit, null, null);
		}
		
		public void SetDisplayMode(PlaceHolder view, PlaceHolder edit, PlaceHolder help)
		{
			SetDisplayMode(view, edit, help, null);
		}

		public void SetDisplayMode(PlaceHolder view, PlaceHolder edit, PlaceHolder help, PlaceHolder preview)
		{
			if (edit != null)
			{
				edit.Visible = CurrentDisplayMode == ElektroPost.Wsrp.Constants.ModeEdit;
			}

			if (view != null)
			{
				view.Visible = CurrentDisplayMode == ElektroPost.Wsrp.Constants.ModeView;
			}

			if (help != null)
			{
				help.Visible = CurrentDisplayMode == ElektroPost.Wsrp.Constants.ModeHelp;
			}

			if (preview != null)
			{
				preview.Visible = CurrentDisplayMode == ElektroPost.Wsrp.Constants.ModePreview;
			}
		}

		public void MarkupIsCacheable(Int32 timeout, String userScope, CacheVaryBy keyParameters)
		{
			CurrentPortlet.MarkupIsCacheable(CurrentMarkupContext, timeout, userScope, keyParameters);
		}

		public void MarkupIsCacheable(Int32 timeout)
		{
			MarkupIsCacheable(timeout, Constants.CachePerUser, CacheVaryBy.Default);
		}

		public IPortletState PortletState
		{
			get { return CurrentPortlet.State; }
		}

		public ISessionState WsrpSession
		{
			get
			{
				if (_markup != null && _resp != null)
					return ProducerFactory.SessionManagerInstance().GetSession(_markup, _resp);

				if (_interact != null && _interactionResponse != null && _interactionResponse.updateResponse != null)
					return ProducerFactory.SessionManagerInstance().GetSession(_interact, _interactionResponse.updateResponse);
	
				return null;
			}
		}

		public Boolean IsWsrpSessionActive
		{
			get
			{
				if (_markup != null)
					return ProducerFactory.SessionManagerInstance().IsSessionActive(_markup);

				if (_interact != null)
					return ProducerFactory.SessionManagerInstance().IsSessionActive(_interact);
	
				return false;
			}
		}

		public IDictionary GroupSession
		{
			get { return ProducerFactory.GroupSessionManagerInstance().GetSession(CurrentPortletContext); }
		}

		public Boolean IsGroupSessionActive
		{
			get { return ProducerFactory.GroupSessionManagerInstance().IsSessionActive(CurrentPortletContext); }
		}

		public event BlockingInteractionEventHandler BlockingInteraction;

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
			if (_interact != null)
				Load += new System.EventHandler(this.RaiseBlockingInteraction);
		}

		private void RaiseBlockingInteraction(Object sender, EventArgs e)
		{
			BlockingInteractionEventArgs ev = new BlockingInteractionEventArgs(_interact, _interactionResponse);
			if (BlockingInteraction != null)
				BlockingInteraction(this, ev);
			if (!ev.ReturnMarkup)
			{
				Response.SuppressContent = true;
			}
		}

		public void UsePersistentNavigationalState()
		{
			String navState = CurrentMarkupParams.navigationalState;

			// Is navigational state given in request?
			if (navState == null || navState.Length == 0)
			{
				// Do we have an active session?
				if (IsWsrpSessionActive)
				{
					// Is navigational state stored in session?
					if (WsrpSession["navigationalState"] != null)
					{
						// Get saved state and pretend it was delivered with the request
						navState = (String)WsrpSession["navigationalState"];
						CurrentMarkupParams.navigationalState = navState;

						// Set CurrentPage based on the saved state
						GlobalSetCurrentPage(GetPage(new PageReference(navState)));
					}
				}
			}
			else
			{
				// Navigational state exists, save it for future reference
				WsrpSession["navigationalState"] = navState;
			}
		}

		public void GlobalSetCurrentPage(PageData page)
		{
			SetCurrentPage(this.Page.Controls, page);
		}

		protected void SetCurrentPage(System.Web.UI.ControlCollection controls, PageData page)
		{
			foreach (System.Web.UI.Control control in controls)
			{
				EPiServer.UserControlBase episerverControl = control as EPiServer.UserControlBase;
				if (episerverControl != null)
					episerverControl.CurrentPage = page;
				if (control.Controls != null && control.Controls.Count > 0)
					SetCurrentPage(control.Controls, page);
			}
		}

		public String EmptyAsNull(String source)
		{
			if (source != null && source.Length == 0)
				return null;
			return source;
		}

		public String NullAsEmpty(Object source)
		{
			String str = source as String;
			if (str == null)
				return String.Empty;
			return str;
		}

		#region Obsoleted properties / methods

		[Obsolete("Use the BlockingInteraction event and the e.Request parameter to access PerformBlockingInteraction request parameter", false)]
		public PerformBlockingInteraction CurrentBlockingInteraction
		{
			get { return _interact; }
		}

		[Obsolete("Use the BlockingInteraction event and the e.Response parameter to access PerformBlockingInteraction response parameter", false)]
		public BlockingInteractionResponse CurrentInteractionResponse
		{
			get { return _interactionResponse; }
		}

		[Obsolete("Use the BlockingInteraction event and the e.Response.updateResponse parameter to access updateResponse", false)]
		public UpdateResponse CurrentUpdateResponse
		{
			get 
			{
				if (CurrentInteractionResponse == null)
					return null;
				return CurrentInteractionResponse.updateResponse; 
			}
		}

		[Obsolete("Use the BlockingInteraction event and the e.GetParameter method", false)]
		public String GetParameter(string key) 
		{
			if (CurrentBlockingInteraction != null && CurrentBlockingInteraction.interactionParams.formParameters != null )
			{
				NamedString[] parameters = CurrentBlockingInteraction.interactionParams.formParameters;
				for (int i = 0; i < parameters.Length ; i++)
				{
					if (parameters[i].name == key)
						return parameters[i].value;
				}
			}
			return null;
		}

		#endregion

	}
}
