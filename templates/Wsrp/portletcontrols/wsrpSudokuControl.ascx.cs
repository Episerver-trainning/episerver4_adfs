using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using ElektroPost.Wsrp.V1.Types;

using development.Templates.Wsrp.Core;
using development.Templates.Wsrp.PortletControls.Util;

namespace development.Templates.Wsrp.PortletControls 
{
	/// <summary>
	///		Summary description for wsrpSudokuControl.
	/// </summary>
	public class wsrpSudokuControl : development.Templates.Wsrp.Core.WsrpUserControlBase
	{
		protected PlaceHolder View,Edit;
		protected SudokuControl SudokuControl;

		protected BoardData _entries;
		public BoardData Entries 
		{
			get 
			{ 
				if (_entries == null) 
					_entries = (BoardData) this.PortletState["entries"];
				if (_entries == null)
					_entries = new BoardData(new int[81]);
				return _entries;
			}
			set 
			{
				_entries = null;
				this.PortletState["entries"] = value;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			this.SetDisplayMode( View, Edit );
			this.DataBind();
		}

		private void wsrpSudokuControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			string submit = e.GetParameter("check");
			if (submit != null && submit != string.Empty) 
			{
				switch (submit) 
				{
					case "Check":
						NamedString[] pars = e.Request.interactionParams.formParameters;
						foreach (NamedString par in pars) 
						{
							if (par.value != string.Empty && par.name != "submit") 
							{
								int r, c, v;
								System.Text.RegularExpressions.Match m = regex.Match( par.name );
								if (!m.Success) continue;
								r = Int32.Parse( m.Groups["r"].Value );
								c = Int32.Parse( m.Groups["c"].Value );
								try 
								{
									v = Int32.Parse( par.value );
								} 
								catch { v = 0; }
								this.Entries[r,c] = v;
							}
						}
						PortletState["entries"] = this.Entries;
						break;
					default:
						throw new NotSupportedException(string.Format("{0} is not a supported action", submit));
				}
			}
			string action = e.GetParameter("action");
			if (action != null && action != string.Empty) 
			{
				switch ( action ) 
				{
					case "generate":
						this.Sudoku = Board.Generate();
						this.Entries = new BoardData( new int[81] );
						break;
						
					default:
						throw new NotSupportedException(string.Format("{0} is not a supported action", action));
				}
			}
		}


		System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"_(?<r>\d)_(?<c>\d)$");

		Board _sudoku;
		public Board Sudoku 
		{
			get 
			{
				if ( _sudoku == null ) 
					_sudoku = (Board) PortletState["sudoku"];
				if ( _sudoku == null ) 
				{
					_sudoku = new Board();
				}
				return _sudoku;
			}
			set 
			{
				_sudoku = null;
				this.PortletState["sudoku"] = value;
			}
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
			this.BlockingInteraction += new BlockingInteractionEventHandler(wsrpSudokuControl_BlockingInteraction);
		}
		#endregion

	}
}
