using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace TaskToy
{
	class TaskToy
	{
		public static void Main(string[] args)
		{
			List<Task<double>> taskArray = new List<Task<double>>();
			const int numTasks = 1 << 16;
			for (int i = 0; i < numTasks; i++) {
				taskArray.Add(Task<double>.Factory.StartNew(() => doComputation(1000000)));
			}

			var results = new double[taskArray.Count];
			var sum = 0.0;
			for (var i = 0; i < taskArray.Count; i++) {
				// Reading result blocks until the task is complete.
				results[i] = taskArray[i].Result;
				Console.WriteLine("Task {0}: {1}", i, results[i]);
				sum += results[i];
			}
			Console.WriteLine("Sum: {0}", sum);
		}

		private static double doComputation(int end)
		{
			double sum = 0;
			for (var value = 0; value <= end; value += 1) {
				sum += value;
			}
			return sum;
		}
	}
}
