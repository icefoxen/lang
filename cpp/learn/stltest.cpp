/* Test various stl stuff.
   No, not St. Louis.
   Containers, algorithms, iterators, oh my!
*/


#include <iostream>
#include <ext/hash_map>

using namespace std;

// This CAN'T be right...
//using namespace __gnu_cxx;


struct eqstr
{
      bool operator()(const char* s1, const char* s2) const
      {
	 return strcmp(s1, s2) == 0;
      }
};

int main()
{
   hash_map<int, string> stuff;
  
   stuff[0] = "Foo";
   stuff[1] = "bar";
   stuff[2] = "Bop";

   for( int x = 0; x < 4; x++ )
   {
      cout << stuff[x] << endl;
   }

   return 0;
}
