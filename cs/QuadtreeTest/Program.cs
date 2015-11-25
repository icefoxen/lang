using System;
using System.Diagnostics;

namespace QuadtreeTest
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			RunTest(1000000);
		}

		static void RunTest(int n, int bounds = 1000000000)
		{
			int halfBounds = bounds / 2;
			var r = new Random();
			var q = new QuadTree<int>(new Vector2d(0, 0), 0);
			var sw = new Stopwatch();
			sw.Start();
			for (int i = 0; i < n; i++) {
				q.Insert(new Vector2d(r.NextDouble() * bounds - halfBounds, r.NextDouble() * bounds - halfBounds), 0);
			}
			sw.Stop();
			Console.WriteLine("Adding {0} items to quadtree: {1} seconds", n, sw.ElapsedMilliseconds / 1000.0);
			
		}
	}
}
