int foo()
{
   return 5;
}

int bar( int a, int b )
{
   return (a + b);
}

int main()
{
   return bar( foo(), foo() );
}
