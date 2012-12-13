(* Seems casting has gotten looser since 1987. *)
MODULE TypePlay;
IMPORT InOut;
FROM SRealIO IMPORT ReadReal;

VAR i : INTEGER; c : CARDINAL; f, g : REAL;

BEGIN
   f := 10.0;
   ReadReal( g );
   IF (f / g) * g = f THEN
      InOut.WriteString( "Float arithmatic is precise!" );
   ELSE
      InOut.WriteString( "Float arithmatic is imprecise!" );
   END;

   i := 10;
   c := i; (* CARDINAL( i ); *)
   c := c - 20;
   i := c; (* INTEGER( c ); *)
   InOut.WriteInt( i, 10 );
END TypePlay.
