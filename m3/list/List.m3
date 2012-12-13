(* List.m3
   A linked list.
*)

MODULE List;
IMPORT IO;

(*
(struct llist
   (car:int 0)
   (cdr:^llist nil))   // Nil pointer = bad juju, but...
*)

TYPE
LList = RECORD
   car : INTEGER;
   cdr : REF LList;
END;
*)

(*
(def cons:list (itm:int nxt:list)
   (let (l:list (create :list)))
   (stack (l:list))
*)

(*
PROCEDURE cons( itm : INTEGER; nxt : REF LList ) : LList =
VAR l : LList := LList{ itm, nxt };
BEGIN
   RETURN l;
END cons;

PROCEDURE car( lst : REF LList ) : INTEGER =
BEGIN
   RETURN lst.car;
END car;

PROCEDURE cdr( lst : LList ) : LList =
BEGIN
   RETURN lst.cdr;
END cdr;
*)

PROCEDURE findList( itm : INTEGER; lst : LList ) : INTEGER =
      PROCEDURE findhelper( list :  LList; idx : INTEGER ) : INTEGER =
      BEGIN
	 IF list.car = itm THEN
	    RETURN idx;
	 ELSIF list.cdr = NIL THEN
	    RETURN -1;
	 ELSE
	    RETURN findhelper( list.cdr^, idx + 1 );
	 END;
      END findhelper;
BEGIN
   RETURN findhelper( lst, 0 );
END findList;

PROCEDURE getList( idx : INTEGER; lst : LList ) : INTEGER =
      PROCEDURE gethelper( lst : LList; i : INTEGER ) : INTEGER =
      BEGIN
	 IF idx = i THEN
	    RETURN lst.car;
	 ELSIF lst.cdr = NIL THEN
	    RETURN -1;
	 ELSE
	    RETURN gethelper( lst.cdr^, i + 1 );
	 END;
      END gethelper;
BEGIN
   RETURN gethelper( lst, 0 );
END getList;

PROCEDURE printList( lst : LList ) =
BEGIN
   IF lst.cdr = NIL THEN
      IO.PutInt( lst.car );
      IO.Put( "\n" );
      RETURN;
   ELSE
      IO.PutInt( lst.car );
      IO.Put( " " );
      printList( lst.cdr^ );
   END;
END printList;

BEGIN

END List.
