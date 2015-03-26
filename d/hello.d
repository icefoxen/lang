import std.stdio;
void main() {
   debug writeln("Foo!");
   writeln("Hello world!");
}

int twice(int x) {
   return x+x;
}
/** unit tests */
unittest {
   assert(twice(-1) == -2);
   assert(twice(2) == 4);
}