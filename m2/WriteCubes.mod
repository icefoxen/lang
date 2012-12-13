MODULE WriteCubes;
FROM STextIO IMPORT WriteLn;
FROM SWholeIO IMPORT WriteCard;

VAR J : CARDINAL;

BEGIN
   FOR J := 1 TO 10 DO
      WriteCard( J * J * J, 8 );
   END;
   WriteLn;

END WriteCubes.
