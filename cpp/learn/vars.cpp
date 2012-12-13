#include <iostream>

using std::cout;
using std::string;
using std::cin;
using std::endl;

char fname[10], lname[10];
char test[] = "Words!";
string mine = "More words!";
bool cont = false;
long num = 12345;

int main()
{
   cout << "Number: " << num << endl;
   cout << "Bool: " << cont << endl;
   cout << "String: " << mine << endl;
   cout << "char[]: " << test << endl;

   cout << "Enter first name\n";
   cin >> fname;
   cout << "Enter last name\n";
   cin >> lname;
   cout << "Your name is: " << fname << " " << lname << endl;

   return 0;
}
