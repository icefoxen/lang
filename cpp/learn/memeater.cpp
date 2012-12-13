/* Let's test out allocation.  And exceptions.  ^_^
 */

#include <iostream>
using namespace std;

int main()
{
   int *foo = new int[1000];
   for( int x = 0; x < 1000; x++ )
   {
      foo[x] = x;
   }


   for( int x = 0; x < 1000; x++ )
   {
      cout << foo[x] << endl;	
   }

   delete[] foo;
   cout << foo[91] << endl;
   
   double *bar;
   try
   {
      for(;;)
      {
	 bar = new double[100000];
      }
   }
   catch( bad_alloc& )
   {
      cout << "Snargle!" << endl;
   }
   return 0;
}
