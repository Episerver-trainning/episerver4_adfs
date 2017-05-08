using System;
using System.Collections;
using System.Drawing;
using System.Text;
//using System.Windows.Forms;

namespace development.Templates.Wsrp.PortletControls.Util 
{
	public class Sudoku 
	{
		public static void Main() {
			#region benchmarks
// solvable ?
//			int[] b = new int[] {0,0,1,0,0,0,8,0,0,0,7,0,3,1,0,0,9,0,3,0,0,0,4,5,0,0,7,0,9,0,7,0,0,5,0,0,0,4,2,0,5,0,1,3,0,0,0,3,0,0,9,0,4,0,2,0,0,5,7,0,0,0,4,0,3,0,0,9,1,0,6,0,0,0,4,0,0,0,3,0,0};
// solvable easy
//			int[] b = new int[] {0,5,0,0,0,1,0,0,0,2,0,3,0,0,0,7,0,0,0,7,0,3,0,0,1,8,2,0,0,4,0,5,0,0,0,7,0,0,0,1,0,3,0,0,0,8,0,0,0,2,0,6,0,0,1,8,5,0,0,6,0,9,0,0,0,2,0,0,0,8,0,3,0,0,6,4,0,0,0,7,0};
// solvable medium
//			int[] b = new int[] {0,0,4,0,5,0,0,6,0,0,6,0,1,0,0,8,0,9,3,0,0,0,0,7,0,0,0,0,8,0,0,0,0,5,0,0,0,0,0,4,0,3,0,0,0,0,0,6,0,0,0,0,7,0,0,0,0,2,0,0,0,0,6,1,0,5,0,0,4,0,3,0,0,2,0,0,7,0,1,0,0};
// solvable hard
//			int[] b = new int[] {0,7,0,0,1,0,0,9,0,9,0,0,8,0,0,0,0,7,0,0,3,0,0,0,0,0,6,0,4,0,0,0,1,5,0,0,0,3,0,0,0,0,0,1,0,0,0,2,7,0,0,0,6,0,5,0,0,0,0,0,6,0,0,6,0,0,0,0,5,0,0,2,0,8,0,0,2,0,0,7,0};
// unsolvable hard
//			int[] b = new int[] {2,0,0,6,7,0,0,0,0,0,0,6,0,0,0,2,0,1,4,0,0,0,0,0,8,0,0,5,0,0,0,0,9,3,0,0,0,3,0,0,0,0,0,5,0,0,0,2,8,0,0,0,0,7,0,0,1,0,0,0,0,0,4,7,0,8,0,0,0,6,0,0,0,0,0,0,5,3,0,0,8};
//			Board board = new Board(b);
//	h ok	
//			Board board = Board.FromUkString("2____8_6_+_8_4_9___+5_____2_4+____73_5_+_67___43_+_5_84____+7_4_____5+___9_7_4_+_1_5____2");
//	h ok	
//			Board board = Board.FromUkString("__9____3_+3____9__2+_52_31_7_+__425____+29_____51+____132__+_8_34_51_+5__1____6+_1____8__");
//	h fail	
//			Board board = Board.FromUkString("__8_634__+_3_____7_+4__8_1__3+__74_96__+_________+__23_654_+9__6_8__4+_2_____9_+__492_7__");
			#endregion

			Board board = Board.Generate();
			
			Console.WriteLine(board.ToString());
			Console.WriteLine(board.ToString(true));
			Console.WriteLine(board.ToUkString());
		}
	
	}
	

	[Serializable]
	public class BoardData 
	{
		int[] _data;

		internal BoardData(int[] data) 
		{
			_data = data;
		}
		public int this[int r, int c] 
		{
			get { return _data[r*9+c]; }
			set { _data[r*9+c] = value; }
		}
		public int[] RawData { get { return _data; } }
	}

	[Serializable]
	public class Board {
		int[] _solution;
		int[] _data;
		int[][] _free;
		BoardData _initialGrid;
		BoardData _solutionGrid;

		public BoardData InitialGrid { get { return _initialGrid; } }
		public BoardData SolutionGrid { get { return _solutionGrid; } }
		
		public void Solve(bool verbose) {
			bool exit = false;
			while (!exit) {
				int res = this.PopulateFree(verbose);
				if (res == -1) return;
				if (res > 0) 
					continue;
				if (this.ResolveSingles(verbose) > 0) continue;
				if (this.ResolvePairs(verbose) == 0) exit = true;
			}
		}
		
		public bool SolutionFound {
			get {
				// first make sure we have all cells filled out
				for (int i = 0; i < _solution.Length; i++) if (_solution[i] == 0) return false;

				int validProd = 362880; int validSum = 45;
				int rprod, cprod, bprod;
				int rsum, csum, bsum;
				
				// check all rows and columns
				for (int i = 0; i < 9; i++) 
				{
					rprod = 1; rsum = 0;
					cprod = 1; csum = 0;

					for (int j = 0; j < 9; j++) 
					{
						rprod *= _solution[i*9+j];
						rsum += _solution[i*9+j];
						cprod *= _solution[j*9+i];
						csum += _solution[j*9+i];
					}
					if (rprod != validProd) return false;
					if (rsum != validSum) return false;
					if (cprod != validProd) return false;
					if (csum != validSum) return false;
				}
				// check all boxes
				for (int br = 0; br < 3; br++) 
				{
					for	(int bc = 0; bc < 3; bc++) 
					{
						bprod = 1; bsum = 0;
						for (int r = 0; r < 3; r++) 
						{
							for (int c = 0; c < 3; c++) 
							{
								bprod *= _solution[(br*3+r)*9+bc*3+c];
								bsum += _solution[(br*3+r)*9+bc*3+c];
							}
						}
						if (bprod != validProd) return false;
						if (bsum != validSum) return false;
					}
				}
				return true;
			}
		}
		
		public static Board Generate() {
			return Generate( (int) DateTime.Now.Ticks );
		}
		public static Board Generate(int seed) {
			Random rand = new Random(seed);
			bool retry;
			do {
				retry = false;
				Board b = new Board(new int[81]);
				b.PopulateFree(false);
				int added = 0;
				while (!b.SolutionFound && !retry) {

					// populate a new cell
					int[] c = b.GetCellCandidates();
					int i = c[rand.Next(c.Length)];
					int v = b._free[i][rand.Next(b._free[i].Length)];
					b._data[i] = v;
					b._solution[i] = v;
					added++;
					if (b.PopulateFree(false) < 0) 
					{ 
						// invalid soduko, make another attempt
						retry = true; 
					}
					else if (added > 20) {
						// don't bother to solve until there are at least 20 cells populated
						b.Solve(false);
					}
				}
				if (!retry) 
				{
					// a Sudoku was found with a distinct solution, return it...
					return b;
				}
			} while (retry);

			// should never happen
			return null;
		}
		
		private int[] GetCellCandidates() {
			int maxLength = 0;
			ArrayList clist = new ArrayList();
			for(int i = 0; i < _free.Length; i++) {
				if (_free[i].Length > maxLength) { 
					maxLength = _free[i].Length;
					clist.Clear();
					clist.Add(i);
				} 
				else if (_free[i].Length == maxLength) {
					clist.Add(i);
				}
			}
			return (int[]) clist.ToArray(typeof(int));
		}

		public Board() : this(new int[81]) {}
		public Board(int[] data) { 
			_data = data; 
			_solution = new int[data.Length];
			data.CopyTo(_solution,0); 
			_free = new int[data.Length][];
			_initialGrid = new BoardData( _data );
			_solutionGrid = new BoardData( _solution );
		}
		
		public string ToUkString() {
			return ToUkString(false);
		}
		public string ToUkString(bool solution) {
			StringBuilder sb = new StringBuilder();
			for (int r = 0; r < 9; r++) {
				for (int c = 0; c < 9; c++) {
					int v = solution ? _solution[r*9+c] : _data[r*9+c];
					sb.AppendFormat("{0}",v>0?v.ToString():"_");
				}
				if (r < (9-1)) sb.Append("+");
			}
			return sb.ToString();
		}
		
		public static Board FromUkString(string s) {
			StringBuilder sb = new StringBuilder(s);
			int[] data = new int[81];
			int i = 0;
			while(sb.Length > 0) {
				switch(sb[0]) {
					case '_':
						sb.Remove(0,1);
						i++;
						break;
					case '+':
						sb.Remove(0,1);
						break;
					default:
						data[i] = Int32.Parse(sb.ToString(0,1));
						sb.Remove(0,1);
						i++;
						break;
				}
			}
			return new Board(data);
		}
		
		public override string ToString() {
			return ToString(false);
		}
		public string ToString(bool solution) {
			StringBuilder sb = new StringBuilder();
			string hbar = "+---+---+---+\r\n";
			for (int r = 0; r < 9; r++) {
				if (r%3 == 0) sb.Append(hbar);
				for (int c = 0; c < 9; c++) {
					if (c%3 == 0) sb.Append("|");
					int v = solution ? _solution[r*9+c] : _data[r*9+c];
					sb.AppendFormat("{0}",v>0?v.ToString():" ");
				}
				sb.Append("|\r\n");
			}
			sb.Append(hbar);
			return sb.ToString();
		}
		
		private int NonZero { 
			get {
				int nn = 0;
				for (int i = 0; i < 81; i++) 
					if (_data[i] != 0) nn++;
				return nn;
			}
		}
		// returns number of resolved tiles
		public int PopulateFree(bool verbose) {
			for (int i = 0; i < _solution.Length; i++) {
				if (_solution[i] == 0) {
					int[] freei = Board.GetFree(i/9,i%9,_solution);
					if (freei.Length == 0) return -1;
					if (_free[i] == null || freei.Length < _free[i].Length) {
						_free[i] = freei;
					}
				}
				else if (_free[i] != null && _free[i].Length > 0) {
					_free[i] = new int[0];
				}
			}
			return 0;
		}

		public static int[] GetRow(int r, int[] data) {
			ArrayList row = new ArrayList();
			for (int c = 0; c < 9; c++) {
				if (data[r*9+c] > 0) row.Add(data[r*9+c]);
			}
			return (int[]) row.ToArray(typeof(int));
		}
		
		public static int[] GetCol(int c, int[] data) {
			ArrayList col = new ArrayList();
			for (int r = 0; r < 9; r++) {
				if (data[r*9+c] > 0) col.Add(data[r*9+c]);
			}
			return (int[]) col.ToArray(typeof(int));
		}
		
		public static int[] GetBox(int r, int c, int[] data) {
			int br = r / 3;
			int bc = c / 3;
			ArrayList d = new ArrayList();
			for (int ri = 0; ri < 3; ri++) 
				for (int ci = 0; ci < 3; ci++) 
					if (data[(br*3+ri)*9+bc*3+ci] > 0) d.Add(data[(br*3+ri)*9+bc*3+ci]);
			return (int[]) d.ToArray(typeof(int));
		}
		
		public static int[] GetFree(int row, int col, int[] data) {
			int[] free = Set.Difference(Set.Full, Set.Union(Set.Union(GetRow(row, data), GetCol(col, data)), GetBox(row, col, data)));
			return free;
		}
		
		public int ResolvePairs(bool verbose) {
			int resolved = 0;
			int f;
			for (int i = 0; i < _solution.Length; i++) {
				if (_free[i] != null && _free[i].Length == 2) {

					// resolve row pairs
					int r = i / 9;
					int c2 = -1;
					int c;
					for (c = 0; c < 9 && c2 < 0; c++) {
						if (_solution[r*9+c] == 0 && (r*9+c) != i && Set.IsEqual(_free[i], _free[r*9+c])) c2 = c; 
					}
					if (c2 >= 0) {
						if (verbose) Console.WriteLine("{0,-2:G},{1,-2:G}:   {2,-2:G},{3,-2:G} (ResolvePairs by row)", r+1, i%9+1, r+1, c2+1);
						for (c = 0; c < 9; c++) {
							if (c != c2 && r*9+c != i && _solution[r*9+c] == 0) {
								f = _free[r*9+c].Length;
								_free[r*9+c] = Set.Difference(_free[r*9+c], _free[i]);
								resolved+=f-_free[r*9+c].Length;
							}
						}
					}
					
					// resolve col pairs
					c = i % 9;
					int r2 = -1;
					for (r = 0; r < 9 && r2 < 0; r++) {
						if (_solution[r*9+c] == 0 && (r*9+c) != i && Set.IsEqual(_free[i], _free[r*9+c])) r2 = r; 
					}
					if (r2 >= 0) {
						if (verbose) Console.WriteLine("{0,-2:G},{1,-2:G}:   {2,-2:G},{3,-2:G} (ResolvePairs by col)", i/9+1, c+1, r2+1, c+1);
						for (r = 0; r < 9; r++) {
							if (r != r2 && r*9+c != i && _solution[r*9+c] == 0) {
								f = _free[r*9+c].Length;
								_free[r*9+c] = Set.Difference(_free[r*9+c], _free[i]);
								resolved+=f-_free[r*9+c].Length;
							}
						}
					}

					// resolve box pairs
					r = i / 9;
					c = i % 9;
					int br = r / 3;
					int bc = c / 3;
					r2 = -1;
					c2 = -1;
					for (r = 0; r < 3 && r2 < 0; r++) {
						for (c = 0; c < 3 && c2 < 0; c++) {
							if ( _solution[(br*3+r)*9+bc*3+c] == 0 && ((br*3+r)*9+bc*3+c) != i && Set.IsEqual(_free[i], _free[(br*3+r)*9+bc*3+c]) ) {
								r2 = r;
								c2 = c;
							}
						}
					}
					if (r2 >= 0 && c2 >= 0) {
						if (verbose) Console.WriteLine("{0,-2:G},{1,-2:G}:   {2,-2:G},{3,-2:G} (ResolvePairs by box)", i/9+1, i%9+1, br*3+r2+1, bc*3+c2+1);
						for (r = 0; r < 3 && r2 < 0; r++) {
							for (c = 0; c < 3 && c2 < 0; c++) {
								if (r != r2 && ((br*3+r)*9+bc*3+c) != i && _solution[(br*3+r)*9+bc*3+c] == 0) {
									f = _free[(br*3+r)*9+bc*3+c].Length;
									_free[(br*3+r)*9+bc*3+c] = Set.Difference(_free[(br*3+r)*9+bc*3+c], _free[i]);
									resolved+=f-_free[(br*3+r)*9+bc*3+c].Length;
								}
							}
						}
					}
					
				}
			}
			return resolved;
		}
		
		public int ResolveSingles(bool verbose) {
			// check constraints
			for (int row = 0; row < 9; row++) {
				for (int col = 0; col < 9; col++) {
					if (_solution[row*9+col] > 0) continue;
					bool resolved = false;
					for (int i = 0; i < _free[row*9+col].Length && !resolved; i++) {
						int fi = _free[row*9+col][i];
						bool found = false;
						bool resolvedByRow = false;
		
						// check row constraints
						if (true) {
							for (int c = 0; c < 9 && !found; c++) {
								if (col != c && _solution[row*9+c] == 0) {
									ArrayList t = new ArrayList(_free[row*9+c]);
									found = t.IndexOf(fi) >= 0;
								}
							}
						}
						
						resolvedByRow = !found;
		
						// check col constraints (if necessary)
						if (found) {
							found = false;
							for (int r = 0; r < 9 && !found; r++) {
								if (row != r && _solution[r*9+col] == 0) {
									ArrayList t = new ArrayList(_free[r*9+col]);
									found = t.IndexOf(fi) >= 0;
								}
							}
						}
						
						// check box constraints (if necessary)
						if (found) {
							found = false;
							int br = row / 3;
							int bc = col / 3;
							int bri = row % 3;
							int bci = col % 3;
							for (int r = 0; r < 3 && !found; r++) {
								for (int c = 0; c < 3 && !found; c++) {
									if ( (bri != r || bci != c )  && _solution[(br*3+r)*9+bc*3+c] == 0) {
										ArrayList t = new ArrayList(_free[(br*3+r)*9+bc*3+c]);
										found = t.IndexOf(fi) >= 0;
									}
								}
							}
						}
		
						if (!found) {
							_solution[row*9+col] = fi;
							if (verbose) Console.WriteLine("{0,-2:G},{1,-2:G}:   {2} (ResolveSingles by {3})", row+1, col+1, fi, resolvedByRow ? "row" : "col");
							return 1;
						}
					}
				}
			}
			return 0;
		}
	}
	
	public class Set {		
		public static bool IsEqual(int[] A, int[] B) {
			// early return if different length
			if (A.Length != B.Length) return false;
			
			// return negative if any cell is different
			for (int i = 0; i < A.Length; i++)
				if (A[i] != B[i]) return false;
				
			// everything seems to be the same
			return true;
		}
		
		public static int[] Full = new int[] {1,2,3,4,5,6,7,8,9};
		public static int[] Union(int[] A, int[] B) {
			ArrayList c = new ArrayList(A);
			c.AddRange(B);
			c.Sort();
			return Unique(c);
		}
		
		public static int[] Unique(int[] A) {
			return Unique(new ArrayList(A));
		}
		
		public static int[] Unique(ArrayList a) {
			int i = 0;
			while (i < a.Count-1) {
				if ((int)a[i] == (int)a[i+1]) 
					a.RemoveAt(i+1);
				else
					i++;
			}
			return (int[]) a.ToArray(typeof(int));
		}
		
		public static int[] Difference(int[] A, int[] B) {
			ArrayList c = new ArrayList(A);
			ArrayList b = new ArrayList(B);
			int i = 0;
			while (i < c.Count) {
				if (b.IndexOf(c[i]) >= 0)
					c.RemoveAt(i);
				else 
					i++;
			}
			return (int[]) c.ToArray(typeof(int));
		}
		
		public static string ToString(int[] A) {
			StringBuilder sb = new StringBuilder();
			foreach (int i in A) sb.AppendFormat("{0}", i);
			return sb.ToString();
		}
	}
}