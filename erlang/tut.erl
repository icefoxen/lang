% tut.erl
% Hrmm... Weird comment character.  Postscript-y
% Anyway, this is just basic Erlang-ish stuff.
% It's rather prolog-y, really.  The function composition, the weak
% typing, the | list-deconstruction, the using lists of numbers as strings.
% Rather more practical, though.
%
% Simon Heath
% 23/10/2004


-module( tut ).
-export( [double/1, fact/1, fib/1, convert_length/1, listLen/1, range/1,
          write/0] ).

double( X ) ->
    2 * X.

fact( 1 ) -> 
    1;
fact( X ) ->
    X * fact( X - 1 ).

fib( 1 ) ->
    1;
fib( 2 ) ->
    2;
fib( X ) ->
    fib( X - 1 ) + fib( X - 2 ).

convert_length({centimeter, X}) ->
   {inch, X / 2.54};
convert_length({inch, Y}) ->
   {centimeter, Y * 2.54}.

listLen( [] ) -> 0;
listLen( [_ | Cdr] ) -> 1 + listLen( Cdr ).

% | can be used to construct lists as well as deconstruct them, but the
% syntax ain't exactly Haskell or Ocaml.
range( 0 ) -> [];

range( X ) -> 
   [X | range( X - 1 )].


% Oooo, slightly lispy format!  W00t!
write() ->
   io:format( "Hello world!~n", [] ),
   io:format( "This outputs one term: ~w~n", [hello] ),
   io:format( "This outputs two terms: ~w ~w~n", [hello, world] ).
