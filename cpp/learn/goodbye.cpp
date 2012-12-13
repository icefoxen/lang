// goodbye.cpp
// More C++ junk.
// 1/2/2004

using namespace std;

#include <iostream>

const int a = 10;


int main()
{
   int a = 5;
   int b (5);  // Stupid syntax; exact same as above.
   char foo[16];

   cout << "Hello there!  Type \"foo\"." << endl;
   cin >> foo;
   if( foo[0] == 'f' && foo[1] == 'o' && foo[2] == 'o' )
      cout << "Yay!" << endl;
   else
      cout << "Boo!" << endl << endl;
   

   cout << a + ::a << endl;
   cout << a + b + ::a << endl;
   cin >> b;  // It appears that if a number doesn't parse, it's ignored.
   cout << a + ::a + b << endl;

   b += a + ::a;

   cout << "Decimal of b is : " << b << endl;
   cout << "Octal of b is : 0" << oct << b << endl;
   cout << "Hex of b is : 0x" << hex << b << endl;
   cout << "Char of b is : " << (char) b << endl;

   return 0;
}
