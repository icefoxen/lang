MODULE Hello
EXPORTS Main;
IMPORT Trestle, TextVBT;

VAR
   (* Constructs VBT as the top level window *)
   main := TextVBT.New( "Hello world!" );

BEGIN
   Trestle.Install( main );
   Trestle.AwaitDelete( main );

END Hello.
