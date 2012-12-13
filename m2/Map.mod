MODULE Map;
FROM SWholeIO IMPORT *;
FROM STextIO IMPORT WriteString, WriteLn;
FROM Storage IMPORT ALLOCATE;

PROCEDURE Div2( a : INTEGER ) : REAL;
BEGIN
   RETURN 1.;
END Div2;

TYPE IntArray = POINTER TO ARRAY [1..20] OF INTEGER;
TYPE FloatArray = POINTER TO ARRAY [1..20] OF REAL;

PROCEDURE Map( a : IntArray FloatArray ) : FloatArray;
VAR b : FloatArray;
BEGIN
   NEW( b );
   RETURN b;
END Map;

BEGIN
END Map.
