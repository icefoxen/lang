: foo
  do
    i
  loop ;

: bar
  255 0 foo
  cr
  255 0 do
    emit
  loop
  cr ;
