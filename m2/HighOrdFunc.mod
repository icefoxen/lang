MODULE HighOrdFunc;
FROM SRealIO IMPORT WriteReal;


TYPE Func = PROCEDURE( REAL, REAL ) : REAL;

PROCEDURE Foo( a, b : REAL ) : REAL;
BEGIN
   RETURN a * b;
END Foo;

VAR bop : Func;
VAR beep : PROCEDURE( REAL, REAL ) : REAL;
BEGIN
   bop := Foo;
   beep := Foo;
   WriteReal( bop( 10., 20. ), 12 );
   WriteReal( beep( 31., 456. ), 12 );

END HighOrdFunc.
