MODULE Main;
IMPORT IO;

PROCEDURE fact( i : INTEGER ) : INTEGER =
BEGIN
   IF i <= 2 THEN
      RETURN i;
   ELSE
      RETURN i * fact( i - 1 );
   END;
END fact;

BEGIN
  IO.PutInt( fact( 15 ) );
  IO.Put( "\n" );
END Main.
