% Prints a list.
% In Prolog, a list is the structure [a, b, c].
% You can divvy them up using a Lispy car/cdr syntax, like thus:
% [A|B] = a and [b, c]
% [A, B|C] = a, b, and [c]
% [A|[B, C]] = a and [b, c].
% And so on.

alpha( [a, b, c, d, e] ).
beta( [c, d, e] ).
gamma( [a, b, c] ).

% Base case
print_list( [] ).
% Recursive case
print_list( [H|T] ):-
   write( H ),
   print_list( T ).

% print_matching prints all elements two lists have in common.
% BUT ONLY UP 'TILL THEY ARE DIFFERENT.
% Base case: if list is empty, return true
print_matching( [] ).

% If H1 = H2, print the symbol and recurse.
print_matching( [H1|T1], [H2|T2] ):-
   H1 = H2,
   write( H1 ),
   print_matching( T1, T2 ).

% If H1 \= H2, don't print, and recurse.
print_matching( [H1|T1], [H2|T2] ):-
   H1 \= H2,
   print_matching( T1, T2 ).

% Better version of print_matching.

% list_contains is true if E = H,
list_contains( E, [H|_] ):-
   H = E.  
% or if T contains E
list_contains( E, [_|T] ):-
   list_contains( E, T ).

print_matching2( [], _  ).
% W00t!  'Tis tail-recursive!!
% Weel... it kinda has to be... it checks the truth of each statement in
% order, so you could get into some nasty tangles putting checks before the
% recursive call...  And the return value is only Yes/No, so there's no actual
% data to mess with...
print_matching2( [H1|T1], L2 ):-
   list_contains( H1, L2 ),
   write( H1 ),
   write( ' ' ),
   print_matching2( T1, L2 ).


% Slicing lists.
% This is NOT Lisp; these can NOT be nested!!!
% They PRINT the value, they do not RETURN it.  They only return true or
% false!
car( [H|_] ):-
   write( H ).

cdr( [_|T] ):-
   write( T ).

% ALL TRUE!
[X, Y] = [a | [b]]
[a | [b | [c]]] = [a, b, c]
[a, [b, c]] \= [a, b, c]

% Prints every other element of a list.
print_every_other( [] ).
print_every_other( [H|T] ):-
   write( H ),
   write( ' ' ),
   p_e_o_helper( T ).

% Mutually-recursive helper function for print_every_other
% Simply slices out the head of the list and passes it back, hah.
p_e_o_helper( [] ).
p_e_o_helper( [_|T] ):-
   print_every_other( T ).


