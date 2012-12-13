MODULE Fib;
FROM SWholeIO IMPORT WriteInt;
IMPORT STextIO;

PROCEDURE Fib( x : INTEGER ) : INTEGER;
BEGIN
   IF x < 2 THEN
      RETURN 1
   ELSE
      RETURN Fib( x - 1 ) + Fib( x - 2 );
   END;
END Fib;

BEGIN
   WriteInt( Fib( 40 ), 0 );
   STextIO.WriteLn;
END Fib.
