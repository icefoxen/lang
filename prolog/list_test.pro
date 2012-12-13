% List wanking and practice.

% You can get the head of a list by passing the list, AND A VARIABLE.
head( [H|_], E ):-
   H = E.

% Same here, call it like "tail( [a, b, c, d], X )."
tail( [_|T], E ):-
   T = E.

is_vowel( L ):-
   list_contains( L, [a, e, i, o, u] ).

% Takes a list as it's first arg and returns as it's second a list which
% contains every element of the input list which is a vowel.
vowels( [H|T], R ):-
   .


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Utility Functions

% list_contains is true if E = H,
list_contains( E, [H|_] ):-
   H = E.  
% or if T contains E
list_contains( E, [_|T] ):-
   list_contains( E, T ).
