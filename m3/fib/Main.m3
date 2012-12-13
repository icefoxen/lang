MODULE Main;
IMPORT IO;

PROCEDURE fib( i : INTEGER ) : INTEGER = BEGIN
   IF i < 2 THEN
      RETURN 1;
   ELSE
      RETURN fib( i - 1 ) + fib( i - 2 );
   END;
END fib;

BEGIN
   IO.PutInt( fib( 40 ) );
   IO.Put( "\n" );
END Main.
