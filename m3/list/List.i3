(* List.m3
   A linked list.
*)
INTERFACE List;

TYPE
LList = RECORD
   car : INTEGER;
   cdr : REF LList;
END;

   
(*   
PROCEDURE cons( itm : INTEGER; nxt : List ) : List;

PROCEDURE car( lst : List ) : INTEGER;

PROCEDURE cdr( lst : List ) : List;
*)
PROCEDURE findList( itm : INTEGER; lst : LList ) : INTEGER;

PROCEDURE getList( idx : INTEGER; lst : LList ) : INTEGER;

PROCEDURE printList( lst : LList );

END List.
