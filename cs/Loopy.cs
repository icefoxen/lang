using System;

class Loopy
{
  static void Main()
  {
    int counter = 0;
    while( counter < 10 )
    {
      // The varargs of this must treat things as an array...
      Console.WriteLine( "Counter: {0}", counter );
      counter++;
    }
    Console.WriteLine( "Done." );

    for( int x = 99; x > 90; x-- )
    {
      Console.WriteLine( "X: {0}", x );
    }

    string[] names = {"Me", "Myself", "I", "And", "Joe", "Too"};
    foreach( string person in names )
    {
      Console.WriteLine( "This is {0}", person );
    }

  }
}
