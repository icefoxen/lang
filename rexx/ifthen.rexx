say "Number, please"
pull a
if a < 50 then
   say a 'is less than 50'
else
   say a 'is greater than 50'

if a \= 91 then
   say a 'does not equal 91'
else
   say a 'equals 91'

/* & is and, \ is not, | is or, etc */
select
   when a > 0 & a < 10 then say '1-9'
   when a \< 10 & a < 20 then say '10-19'
   when \(a < 20 | a >= 30) then say '20-29'
   otherwise say 'Out of range'
end

/* Can selects overlap?
   Nope, it breaks after the first one.  No fall-through.  */
select
   when a < 10 then say 'Foo!'
   when a > 5 then say 'Bar!'
end

/* Like ocaml; one statement in an if */
if a = 50 then do
   say 'Congrats!'
   say 'You win!'
end
else
   say 'Wrong!  Muahahah!'
