% Prolog properties.
% Declaring data.
% Building a family tree...

% American family...
man( simon ).
man( ian ).
man( alec ).
man( peter ).
man( doug ).
man( roy ).
woman( alison ).
woman( thayer ).
woman( christina ).

% Danish family...
man( gert ).
man( finn ).
man( egon ).
man( anders ).
woman( alisa ).
woman( marianne ).
woman( lisa ).
woman( lona ).
woman( iben ).
woman( mormor ).

% Tree of decendence...
parent( mormor, gert ).
parent( mormor, lona ).
parent( mormor, lisa ).
parent( mormor, marianne ).
parent( egon, gert ).
parent( egon, lona ).
parent( egon, lisa ).
parent( egon, marianne ).
parent( lisa, iben ).
parent( lisa, anders ).
parent( lisa, alisa ).

parent( roy, peter ).
parent( roy, doug ).
parent( thayer, peter ).
parent( thayer, doug ).
parent( doug, ian ).
parent( doug, alec ).
parent( alison, ian ).
parent( alison, alec ).
parent( peter, simon ).
parent( peter, christina ).
parent( marianne, simon ).
parent( marianne, christina ).


% Prolog rules.
% Capital letters are variables.

% F is father of C if F is a man and F is a parent of C
father(F, C):-
  man(F),
  parent(F, C).

mother(M, C):-
  woman(M),
  parent(M, C).

% If some parameter is unimportant, we use a _
is_father( F ):-
  father( F, _ ).

is_mother( M ):-
  mother( M, _ ).

% Now, continue...
son( S, P ):-
  man( S ),
  parent( P, S ).

daughter( D, P ):-
  woman( D ),
  parent( D, P ).

% Siblings have at least one parent in common.
% A \= B preserves that A and B are different.
% P is checked against all values, I suppose...
siblings( A, B ):-
  parent( P, A ),
  parent( P, B ),
  A \= B.

% Full siblings have both parents the same
full_siblings( A, B ):-
  A \= B,
  father( F, A ),
  father( F, B ),  % Same father?
  mother( M, A ),
  mother( M, B ).  % Same mother?

% Half-siblings have one parent the same
half_siblings( A, B ):-
  A \= B,
  parent( P, A ),
  parent( P, B ),  % At least one parent in common...
  not( full_siblings( A, B ) ).  % and NOT full siblings.

% Is B A's brother?
brother( A, B ):-
  man( B ),
  siblings( A, B ).

% Is B A's siter?
sister( A, B ):-
  woman( B ),
  siblings( A, B ).

% Is B A's uncle?
uncle( A, B ):-
  % Is B the brother of one of A's parents?
  brother( parent( P, A ), B ).

% Is B A's aunt?
aunt( A, B ):-
  % Is B the sister of one of A's parents?
  sister( parent( P, A ), B ).

% is B A's niece?
neice( A, B ):-
  % Is B a girl?
  woman( b ),
  % Is A B's uncle or aunt?
  aunt( B, A ),
  uncle( B, A ).

nephew( A, B ):-
  % Is B a boy?
  man( B ),
  % Is A B's uncle or aunt?
  aunt( B, A ),
  uncle( B, A ).

% Is G N's grandparent?
grand_parent( G, N ):-
  % Does N have a parent X?
  parent( X, N ),
  % Is G a parent of X?
  parent( G, X ).
