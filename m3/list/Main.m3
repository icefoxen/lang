
MODULE Main;
IMPORT List;

VAR 
   l : List.LList;

BEGIN
   l := List.LList{ 10, NIL };
   l.cdr^ := List.LList{ 20, NIL };
   List.printList( l );
END Main.
