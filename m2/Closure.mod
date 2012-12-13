MODULE Closure;
FROM STextIO IMPORT WriteLn;
FROM SWholeIO IMPORT WriteInt, ReadInt;

TYPE BopFunc = PROCEDURE( INTEGER, INTEGER ) : INTEGER;

PROCEDURE Foo( a : INTEGER ) : BopFunc;
   PROCEDURE Bar( x, y : INTEGER ) : INTEGER;
   BEGIN
      RETURN a * (x + y);
   END Bar;

   VAR e : BopFunc;
BEGIN
   e := Bar;
   RETURN e;
END Foo;

BEGIN
   WriteInt( Foo( ReadInt )( 10, 20 ), 20 );
END Closure;
