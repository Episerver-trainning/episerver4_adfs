using System;
using System.Collections.Specialized;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.Templates.Wsrp.PortletControls.Util {
	public class SudokuControl : Control 
	{

		protected string PortletInstanceClientID 
		{
			get { 
				development.Templates.Wsrp.Core.WsrpUserControlBase ph = HostControl;
				return ph.CurrentRuntimeContext.portletInstanceKey.GetHashCode().ToString().Replace("-", "x"); 
			}
		}
		protected wsrpSudokuControl HostControl 
		{
			get 
			{
				Control c = this.Parent;
				while ( !(c is wsrpSudokuControl) && c.Parent != null ) 
					c = c.Parent;
				return c as wsrpSudokuControl;
			}
		}

		public int[] Entries 
		{
			get 
			{
				return HostControl.Entries.RawData;
			}
		}
        public int[] Values 
        {
            get 
            {
                return HostControl.Sudoku.InitialGrid.RawData;
            }
        }
        
        protected override void OnLoad(EventArgs e) {
        }

        protected override void CreateChildControls() 
        {
			HtmlGenericControl script = new HtmlGenericControl("script");
			script.Attributes["language"] = "javascript";
			script.Attributes["src"] = EPiServer.Util.UrlUtility.ResolveUrl("~/templates/wsrp/portletcontrols/scripts/SudokuControl.js", EPiServer.Util.UrlTypes.Absolute);
			this.Controls.Add( script );
            Table table = new Table();
            table.ID = "sudokuTable";
			table.Attributes["cellspacing"] = "0";
			table.Attributes["cellpadding"] = "1";
			table.Style["border"] = "2px solid gray";
			table.Attributes["clientname"] = table.ID + this.PortletInstanceClientID;

            for (int r = 0; r < 9; r++)
            {
                table.Rows.Add(new TableRow());
                for (int c = 0; c < 9; c++) 
                {
                    TableCell cell = new TableCell();
                    table.Rows[r].Cells.Add(cell);
                    if (r > 0 && r % 3 == 0) cell.Style["border-top"] = "2px solid gray";
                    if (c > 0 && c % 3 == 0 ) cell.Style["border-left"] = "2px solid gray";
                    cell.Attributes["row"] = r.ToString();
                    cell.Attributes["col"] = c.ToString();
					cell.HorizontalAlign = HorizontalAlign.Center;
					cell.VerticalAlign = VerticalAlign.Middle;
					cell.Style["width"] = "2em";
					cell.Style["height"] = "2em";
                    
                    if (Values[r*9+c] != 0 ) 
                    {
                        cell.Text = Values[r*9+c].ToString();
                    }
                    else 
                    {
                        HtmlInputText tb = new HtmlInputText();
                        tb.ID = string.Format("c{0}_{1}_{2}",PortletInstanceClientID,r,c);
						tb.Name = string.Format("c{0}_{1}_{2}",PortletInstanceClientID,r,c);
						if (this.Entries[r*9+c] > 0) {
							tb.Value = this.HostControl.Entries[r,c].ToString();
							tb.Style["color"] = this.HostControl.Entries[r,c] != this.HostControl.Sudoku.SolutionGrid[r, c] ? "#990000" : "#009900";
						}
						tb.Style["width"] = "1.8em";
						tb.Style["height"] = "1.8em";
						tb.Style["text-align"] = "center";
						tb.Attributes["clientname"] = tb.Name;
						tb.Attributes["class"] = "unmarked";
                        tb.Attributes["onmouseover"] = "onMouseOver(this)";
                        tb.Attributes["onmouseout"] = "onMouseOut(this)";
                        tb.Attributes["onkeyup"] = "onKeyUp(this)";
                        cell.Controls.Add( tb );
                    }
                }
            }
            
            this.Controls.Add(table);
        }
    }
}