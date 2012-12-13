MODULE DumbCalculator;
FROM STextIO IMPORT ReadChar, WriteString, WriteLn, WriteChar;
FROM SRealIO IMPORT ReadReal, WriteReal;

VAR Value1, Value2 : REAL; Op : CHAR;

BEGIN
   WriteString( "Input 'numberopnumber' please: " );
   ReadReal( Value1 ); ReadChar( Op ); ReadReal( Value2 );
   WriteLn;
   WriteChar( Op );
   CASE Op OF
      '+': WriteReal( Value1 + Value2, 10 )
    | "-": WriteReal( Value1 - Value2, 10 )
    | "/": WriteReal( Value1 / Value2, 10 )
    | "*": WriteReal( Value1 * Value2, 10 )
   END;
   WriteLn;
END DumbCalculator.
