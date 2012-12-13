-- io.adb
-- Plays with console IO.
-- Note that Ada is case-INSENSITIVE.
--
-- Simon Heath
-- 19/7/2004

with Ada.Text_Io;
use Ada.Text_Io;

procedure Io is
   C : Character;
   S : String(1..32);
begin
   Put_Line( "This reads information and then displays it." );
   Put_Line( "Please type a character then 'enter'" );
   New_Line;

   Get( C );

   Put_Line( "You typed '" & C & "'" );

   --Put_Line( "Now type a string, then 'enter'" );
   --Get_Line( S, 32 );
   --Put_Line( "You typed:" );
   --Put_Line( S );
end Io;

