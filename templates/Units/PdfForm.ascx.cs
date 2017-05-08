using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.FileSystem;

namespace development.Templates.Units
{
	public class PdfFormView : UserControlBase
	{
		protected DataGrid		DocumentFields;
		protected Button		CreatePdf;
		protected PageList		SelectDocumentList;
		protected Panel			CreateFormArea;
		protected Panel			SelectDocumentArea;
		private bool			_evenRow;
		private readonly string _evenCssClass = "evenrow", _unevenCssClass = "unevenrow";

		public void Page_Load(object sender,System.EventArgs e)
		{
			if(CurrentPage["Document"] == null)
			{
				SelectDocumentArea.Visible = true;
				CreateFormArea.Visible = false;
				SetupDocumentList();
			}
			else
			{
				if(!IsPostBack)
				{
					SelectDocumentArea.Visible	= false;
					CreateFormArea.Visible		= true;
					SetupInputForm();
				}
			}
		}
		private void SetupDocumentList()
		{			
			PageDataCollection children = Global.EPDataFactory.GetChildren(CurrentPage.PageLink);
			SelectDocumentList.DataSource = children;
			SelectDocumentList.DataBind();
		}
		private void SetupInputForm()
		{
			string documentUrl = (string)CurrentPage["Document"];
			PdfReader pdfReader = new PdfReader(documentUrl);

			DocumentFields.DataSource = pdfReader.Fields;
			DocumentFields.DataBind();
			
			//Temporary set target of the form when the user clicks on the create pdf button
			Page.RegisterStartupScript("SetTemporaryFormTarget","<script>function setTemporaryFormTarget(){document.forms[0].target = 'pdfWindow';window.setTimeout(\"document.forms[0].target = '_self'\", 2000);}document.all['" + CreatePdf.ClientID + "'].attachEvent('onclick',setTemporaryFormTarget)</script>");
		}
		protected string GetCssClass(bool changeClass)
		{
			if (changeClass)
				_evenRow = !_evenRow;

			return _evenRow ? _evenCssClass : _unevenCssClass;
		}
		private string GetDocumentName(string documentUrl)
		{
			int dotPosition = 0;

			for(int i = documentUrl.Length - 1 ; i >= 0 ; i--)
			{
				if(dotPosition == 0 && documentUrl[i] == '.')
					dotPosition = i;
				else if(documentUrl[i] == '/')
					return documentUrl.Substring(i + 1 , dotPosition - i - 1);
			}
			return string.Empty;
		}
		protected void Create_Click(object sender, EventArgs e)
		{
			string documentUrl	= (string)CurrentPage["Document"];
			PdfReader pdfReader = new PdfReader(documentUrl);

			foreach (DataGridItem item in DocumentFields.Items)
			{
				string name = (item.Cells[0].Controls[0] as Label).Text;
				string value = (item.Cells[1].Controls[0] as TextBox).Text;
				pdfReader.SetFieldValue(name, value);
			}
		
			string documentName = GetDocumentName(documentUrl);
	
			Response.Clear();
			Response.ContentEncoding = System.Text.Encoding.GetEncoding(1252);
			Response.ContentType = "Application/vnd.pdf";
			Response.AppendHeader("content-disposition","inline; filename=" + documentName + ".pdf");
			pdfReader.SaveFile(Response.OutputStream);
			Response.End();
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
		}
		#endregion
	}
	public class SimpleField
	{
		private string _id;
		private string _gen;
		
		public SimpleField(string id,string gen)
		{
			_id = id;
			_gen = gen;
		}

		public string ID
		{
			get 
			{
				return _id;
			}
		}

		public string Gen
		{
			get 
			{
				return _gen;
			}
		}
	}
	public class PdfObject
	{
		private string _originalValue;

		public PdfObject(string originalValue)
		{
			_originalValue = originalValue;
		}
		public int FieldID
		{
			get 
			{
				Regex regid = new Regex("(\\d+)\\s+(\\d+)\\s+obj\\s*",RegexOptions.Singleline|RegexOptions.IgnoreCase);
				string id = regid.Match(_originalValue).Groups[1].Value;
				return int.Parse(id);
			}
		}
		public int FieldVersion
		{
			get 
			{
				Regex regid = new Regex("(\\d+)\\s+(\\d+)\\s+obj\\s*",RegexOptions.Singleline|RegexOptions.IgnoreCase);
				Match m =  regid.Match(_originalValue);
				string id = m.Groups[2].Value;
				return int.Parse(id);
			}
		}
		public override string ToString()
		{
			return _originalValue;			
		}

		public string OriginalValue
		{
			get
			{
				return _originalValue;
			}
			set
			{
				_originalValue = value;
			}
		}
	}
	public class PdfForm : PdfObject
	{
		public PdfForm(string originalValue):base(originalValue)
		{
		}
		public ArrayList Fields
		{
			get 
			{
				ArrayList arr = new ArrayList();
				Regex fieldrefregex = new Regex("Fields\\[[^\\]]*\\]");
				Match refs = fieldrefregex.Match(OriginalValue);
				Regex refRegex = new Regex("(\\d+)\\s+(\\d+)\\s+R",RegexOptions.Singleline|RegexOptions.IgnoreCase);
				MatchCollection fields = refRegex.Matches(refs.Value);
				
				foreach (Match reference in fields)
				{
					string objid = reference.Groups[1].Value;
					string objgen = reference.Groups[2].Value;
					arr.Add(new SimpleField(objid,objgen));
				}				
				return arr;
			}
		}
		public override string ToString()
		{
			Regex vreg = new Regex("/NeedAppearances\\s+(\\w+)",RegexOptions.Singleline | RegexOptions.IgnoreCase);
			Match m = vreg.Match(OriginalValue);
			if (m.Success)
			{
				return vreg.Replace(OriginalValue, "/NeedAppearances true)");
			} 
			else
			{
				return OriginalValue.Replace(">>\rendobj" , "/NeedAppearances true>>\rendobj");
			}
		}

	}
	public class PdfField : PdfObject
	{
		private bool _changed = false;
		private object _fieldvalue;

		public PdfField(string originalValue) : base(originalValue)
		{
		}
		public string FieldName
		{
			get 
			{
				Regex fieldregex = new Regex("/T\\((?<name>[^\\)]+)\\)",RegexOptions.Singleline|RegexOptions.IgnoreCase);
				Match mName = fieldregex.Match(OriginalValue);										
				return mName.Groups[1].Value;
			}
		}
		public string FieldType
		{
			get 
			{
				Regex regtype = new Regex("/Ft/([^/]*)/",RegexOptions.Singleline|RegexOptions.IgnoreCase);
				string type = regtype.Match(OriginalValue).Groups[1].Value;
				return type;
			}
		}
		public override string ToString()
		{
			Regex vreg = new Regex("/V\\((\\s+)\\)",RegexOptions.Singleline|RegexOptions.IgnoreCase);
			Match m = vreg.Match(OriginalValue);
			if (m.Success)
			{
				if (FieldType=="Tx")
					return vreg.Replace(OriginalValue, "/V(" + FieldValue+")");
				else 
					return vreg.Replace(OriginalValue, "/V " + FieldValue+"");
			} 
			else
			{
				if (FieldType=="Tx")
					return OriginalValue.Replace(">>\rendobj" , "/V(" + FieldValue+")>>\rendobj");
				else
					return OriginalValue.Replace(">>\rendobj" , "/V " + FieldValue+">>\rendobj");
			}
		}
		public bool IsChanged
		{
			get 
			{
				return _changed;
			}
		}
		public object FieldValue
		{
			get 
			{
				return _fieldvalue;
			}
			set 
			{
				_fieldvalue = value;
				_changed = true;
			}
		}
	}
	public class PdfReader
	{		
		private ArrayList	_fields;
		private string		_fileContent;
		private string		_filename;
		private	PdfForm		_form;

		public PdfReader(string filename)
		{
			_filename = filename;
			UnifiedFile uf = UnifiedFileSystem.GetFile(filename);
			Stream stream = uf.OpenRead();
			StreamReader reader = new StreamReader(stream,true);
			ReadFile(reader);
		}
		public PdfReader(StreamReader reader)
		{
			ReadFile(reader);
		}

		private void ReadFile(StreamReader reader)
		{
			_fileContent = reader.ReadToEnd();
			reader.Close();
			InitializeFields();
		}
		private PdfForm GetForm()
		{
			MatchCollection matches = objectregex.Matches(_fileContent);
			foreach (Match mLine in matches)
			{		
				Match mType = fieldtyperegex.Match(mLine.Value);
				string fieldtype = mType.Groups[1].Value;
				if (fieldtype.ToLower() == "fields")
					return new PdfForm(mLine.Value);
			}
			return null;
		}
		
		private void InitializeFields()
		{
			_fields = new ArrayList();

			if(Form == null)
				return;

			foreach (SimpleField sp in Form.Fields)
			{
				string objid = sp.ID;
				string objgen = sp.Gen;
				Regex fi = new Regex("\r" + objid + " " + objgen + findinput,RegexOptions.Multiline | RegexOptions.IgnoreCase);
				MatchCollection myinputs = fi.Matches(_fileContent);
				foreach (Match myinput in myinputs)
				{
					PdfField pf = new PdfField(myinput.Value);
					if(pf.FieldName != string.Empty)
						_fields.Add(pf);
				}
			}					
		}	
		public void SetFieldValue(string fieldname,object fieldvalue)
		{
			for (int i = 0; i < Fields.Count; i++)
			{
				PdfField field = (PdfField)Fields[i];
				if (field.FieldName == fieldname)
				{
					if (field.FieldType == "Tx")
						((PdfField)Fields[i]).FieldValue = fieldvalue as string;
					else 
						((PdfField)Fields[i]).FieldValue = (bool)fieldvalue ? " /Yes" : " /No";
				}
			}
		}

		public string GetUpdate()
		{
			int nullOffset = 0;
			int offset = _fileContent.Length;
			string update = "";
			string xref = "\nxref\n";
			xref += "0 1\n";
			xref += nullOffset.ToString("0000000000") + " 65535 f \n";

			// write the AcroForm object
			string formString = Form.ToString();
			update += formString;
			xref += Form.FieldID.ToString() + " 1\n";
			xref += offset.ToString("0000000000") + " " + Form.FieldVersion.ToString("00000") + " n \n";
			offset += formString.Length;
			int moreobject= 1;
			foreach (PdfField field in Fields)
			{
				if (field.IsChanged)
				{
					string fieldString = field.ToString();
					update += fieldString;
					xref += field.FieldID.ToString() + " 1\n";
					xref += offset.ToString("0000000000") + " " + field.FieldVersion.ToString("00000") + " n \n";
					offset += fieldString.Length;
					moreobject++;
				}
			}

			string trailer = string.Empty;
			trailer += "trailer\n";
			trailer += GetTrailer()+ "\n";			
			trailer += "startxref\n";
			trailer += offset.ToString() + "\n";
			trailer += "%%EOF\n";

			return update + xref + trailer;
		}	
		public string GetTrailer()
		{
			int li = -1;
			int prev = li;
			int ti = -1;
			string line = string.Empty;
			li = _fileContent.LastIndexOf("startxref");
			
			ti = _fileContent.LastIndexOf("trailer", li);

			while (li != 0)
			{				
				
				Match m = findRef.Match(_fileContent, li);
				if (m.Success)
				{
					li = Int32.Parse(m.Groups[1].Value);					
					line = trailer.Match(_fileContent, ti).Groups[0].Value;
				} 
				else 
				{
					break;
				}
				if ((li == 0)||(li > _fileContent.Length))
					break;
				prev = li;
				li= _fileContent.IndexOf("startxref", li);
				ti= _fileContent.LastIndexOf("trailer", li);
			}

			Regex root = new Regex("/Root\\s+(\\d+)\\s+(\\d+)\\s+R",RegexOptions.Singleline);
			Regex size = new Regex("/Size\\s+(\\d+)",RegexOptions.Singleline);
			
			Match rootmatch = root.Match(line);
			Match sizematch = size.Match(line);

			return string.Format("<<\n/Size {0}\n/Root {1} {2} R\n/Prev {3}\n>>",								
				sizematch.Groups[1].Value,
				rootmatch.Groups[1].Value,
				rootmatch.Groups[2].Value,
				prev.ToString()
				);
		}
	
		public void SaveFile(Stream s)
		{
			Stream ins = UnifiedFileSystem.GetFile( _filename).OpenRead();
			byte[] inby = new byte[ins.Length];
			ins.Read(inby, 0, inby.Length);
			ins.Close();
			string _update = GetUpdate();
			string lines = _update;

			byte[] buffer = new byte[lines.Length];

			for (int i = 0; i < lines.Length; i++)
			{
				buffer[i] = (byte)lines[i];
			}
			for (int i = 0; i < inby.Length ; i++)
				s.WriteByte(inby[i]);

			s.Write(buffer, 0, buffer.Length);			
		}


		public ArrayList Fields
		{
			get
			{
				return _fields;
			}
		}
		public string Filename
		{
			get
			{
				return _filename;
			}
			set
			{
				_filename = value;
			}
		}
		public PdfForm Form
		{
			get
			{
				if(_form == null)
					_form = GetForm();
				return _form;
			}
			set
			{
				_form = value;
			}
		}
		#region Parsing Strings
		private readonly Regex objectregex = new Regex("\\d+\\s+\\d+\\s+obj<<[^\\r]+>>\\rendobj",RegexOptions.IgnoreCase|RegexOptions.Singleline);
		private readonly Regex fieldregex = new Regex("/T\\((?<name>[^\\)]+)\\)",RegexOptions.Singleline|RegexOptions.IgnoreCase);
		private readonly Regex fieldtyperegex = new Regex("obj<</(\\w+)\\s*",RegexOptions.Singleline|RegexOptions.IgnoreCase);
		private readonly Regex fieldrefregex = new Regex("Fields\\[[^\\]]*\\]");
		private readonly Regex inputregex = new Regex("\\d+\\s+\\d+\\s+obj<</Fields\\[(^])*\\]\\s*",RegexOptions.Singleline|RegexOptions.IgnoreCase);
		private readonly string findinput= "\\s+obj<<[^\\r]+>>\\rendobj";
		private readonly Regex findRef = new Regex("startxref\\s+(\\d+)\\s*");
		private readonly Regex trailer = new Regex("trailer\\s+<<(([^>][^>])*)",RegexOptions.Singleline);
		#endregion
	}
}