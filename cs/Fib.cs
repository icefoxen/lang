using System;

class Fib {
  static void Main() {
    fib( 40 );
  }

  static int fib( int i ) {
    if( i < 2 ) {
      return 1;
    } else {
       return fib( i - 1 ) + fib( i - 2 );
    }
  }
}
