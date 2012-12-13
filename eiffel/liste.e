indexing
   description: "Simple recursive linked list.  Practice."
   author: "Simon Heath"
   date: "9/1/2002"
class LISTE[T]
creation
   make

feature
   head : T        -- car
   tail : LISTE[T] -- cdr; yay recursion!
   -- NOTE: if tail is Void, that signals the end of the list!  This does 
   -- NOT do things like Lisp's dotted-pair (foo . bar) syntax would!
   -- Now, if could if Eiffel was weakly typed, but..

   make( new_head : T; new_tail : LISTE[T] ) is
      -- Make a new list with new_head prepended to new_tail
      do
         head := new_head
	 tail := new_tail
      end --make

   insert( new_head : T ) is -- LISTE[T] is
      -- Inserts a new head value
      require
         not_void: new_head /= Void -- A Void cell signals end of list
      local
         new_tail : LISTE[T]
      do
         create new_tail.make( head, tail )
	 tail := new_tail
	 head := new_head
      end --append

   has( v : T ): BOOLEAN is
      -- Does the list contain an object = to v?
      do
         if head = v then
	    Result := True
	 elseif tail /= Void then
	    Result := tail.has( v )
	 end --if
      end --has

   length: INTEGER is
      -- Returns the length of the list
      do
         if tail = Void then 
	    Result := 1
	 else 
	     Result := 1 + tail.length  -- Yay recursion!
	 end --if

      ensure
         is_sane: Result > 0
      end --length

   get, infix "@" ( n : INTEGER ): T is
      -- Return the n'th object in the list
      require
         is_positive: n >= 0
      do
         if n = 0 then 
	    Result := head
	 else 
	    Result := tail.get( n - 1 )
	 end --if
      ensure
         length_greater_zero: Current.length > 0
      end --get 


end --LISTE[T]
