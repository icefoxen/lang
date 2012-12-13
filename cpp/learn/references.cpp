
#include <iostream>

using namespace std;

int main()
{
   int x = 10;
   int& a = x;

   const int& q = 91;

   cout << "x = " << x << endl;
   cout << "a = " << a << endl;
   x++;
   cout << "a = " << a << endl;

   // It seems a reference works both ways...  can't be re-assigned.
   a = q;

   cout << "x = " << x << endl;
   cout << "a = " << a << endl;
   a++;
   cout << "x = " << x << endl;

   return 0;
   
}
