using System;

class HelloName
{
  static void Main( string[] args )
  {
    // The args[] array is not quite what you think it is...
    if( length( args ) > 0 ) {
       Console.WriteLine( "Hello, {0}!", args[0] );
    }
  }
}
