\ files.fs
\ Doing file I/O and shibby stuff like that.
\ 
\ Simon Heath
\ 19/5/2003

\ Create two constants for file-descriptors
0 value fd-in
0 value fd-out
256 chars value buflen 
create buffer buflen chars allocate


\ Create two words for opening files
: open-input ( straddr strlen -- )
  \ r/o is read-only; there's also w/o and r/w.  'to' assigns a val to a
  \ constant
  r/o open-file throw 
  to fd-in ;

: open-output ( straddr strlen -- )
  w/o open-file throw 
  to fd-out ;

\ Example:
: copy-file ( -- )
  s" foo.txt" open-input
  s" foo2.txt" open-output
  begin
    buffer buflen fd-in read-line throw
  while
    buffer swap fd-out write-file throw
  repeat 
  fd-in close-file throw
  fd-out close-file throw 
  ;
