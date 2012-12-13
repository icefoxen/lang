parse pull x
say x"! =" factorial( x )
exit

/* 'procedure' lets it recurse safely */
factorial:
procedure
parse arg p
if p < 3 then return p
else return p * factorial( p - 1 )

