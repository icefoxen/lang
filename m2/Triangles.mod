MODULE Triangles;
FROM STextIO IMPORT WriteString, WriteLn;
FROM SRealIO IMPORT WriteReal;
FROM SWholeIO IMPORT ReadCard, WriteCard;
FROM RealMath IMPORT sqrt;

VAR A, B, C : CARDINAL; 
    S, Area : REAL;

BEGIN
   WriteString( "Input lengths of sides in ascending order, seperated by <SPACE>: " );
   ReadCard( A );
   ReadCard( B );
   ReadCard( C );
   WriteLn;
   WriteCard( A, 3 );
   WriteCard( B, 3 );
   WriteCard( C, 3 );
   WriteString( "..." );

   (* Do whacky fragile stuff stuff. *)
   IF A + B > C THEN
      IF A = C THEN
         WriteString( "An equilateral triangle" );
      ELSIF (A = B) OR (B = C) THEN
         WriteString( "An isoceles triangle" );
      ELSE
         WriteString( "A scalene triangle" );
      END;
      (* Figure area *)
      S := 0.5 * FLOAT(A + B + C);
      Area := sqrt( S * (S - FLOAT(A)) * (S - FLOAT(B)) * (S - FLOAT(C)));
      WriteString( " of area " ); WriteReal( Area, 10 );
      WriteLn;
   ELSE
      WriteString( "Not a triangle" );
   END;
   WriteLn;
END Triangles.
