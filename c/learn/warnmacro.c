#include <stdio.h>

#define FOO(x)\
   printf("X is: %s\n", x);  \
   #warning "TEST:" x

int main() {
   FOO("Hi there")
   FOO("Bye there")
}
