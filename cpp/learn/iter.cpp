#include <iostream>
#include <array>

using namespace std;

int main() {
   string str = "Foo bar!";
   for(auto c : str) {
      cout << c << endl;
   }

   // Clang has a warning about requiring the double braces
   // and I have no idea why.
   array<int,3> arr {{10,20,30}};
   for(int i = 0; i < arr.size(); i++) {
      cout << arr[i] << endl;
      arr[i] *= 2;
   }
   for(auto member : arr) {
      cout << member << endl;
   }
   return 0;
}
