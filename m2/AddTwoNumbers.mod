MODULE AddTwoNumbers;
FROM InOut IMPORT ReadInt, WriteInt, WriteString, WriteLn;

VAR First, Second, Sum : INTEGER;

BEGIN
   WriteString( "First number: " );
   ReadInt( First );

   WriteString( "Second Number: " );
   ReadInt( Second );
   
   Sum := First + Second;
   WriteString( "Sum: " );
   WriteInt( Sum, 11 );
END AddTwoNumbers.
