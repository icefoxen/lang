MODULE NumberCounter;
IMPORT STextIO;
IMPORT SRealIO;

VAR n : REAL; s : CHAR;

BEGIN
   STextIO.WriteString( "Today we are going to find out how big our ints are.");
   STextIO.WriteLn;
   STextIO.WriteString( "Are you ready?" );
   STextIO.ReadChar( s );

   n := 1.;
   WHILE TRUE DO
      SRealIO.WriteReal( n, 80 );
      STextIO.WriteLn;
      n := n * 2.;
   END;

END NumberCounter.
