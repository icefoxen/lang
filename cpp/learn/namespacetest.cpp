#include <iostream>
namespace foo {
   void hello() {
      std::cout << "Hello world!\n";
   }
}


int main() {
   foo::hello();
   return 0;
}
