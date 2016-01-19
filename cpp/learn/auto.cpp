// Compile with 'g++ -std=c++11' or better

#include <iostream>

using namespace std;

int main() {
   auto a = 10;
   decltype(a) b = a;
   auto c = 55.5;
   // Ahhh, we can silently turn a float into an int with
   // no warning.  Fantastic.
   b = c;

   const auto rawr = 10;

   cout << "A: " << a << endl;
   cout << "B: " << b << endl;
   cout << "C: " << c << endl;
   cout << "Rawr: " << rawr << endl;

   // cin >> whatever is dumb; use getline instead.
   string foo;
   cout << "Enter a line." << endl;
   getline(cin, foo);
   cout << "You entered: " << foo << endl;

   return a;
}
