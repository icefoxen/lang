% Find out just how many atoms are used up, and what it looks like when
% we run out!


-module( atomsmash ).
-export( [go/0] ).


go( Count ) ->
    S = list_to_atom( integer_to_list( Count ) ),
    io:format( "Symbol ~p~n", [S] ),
    go( Count + 1 ).
		      

go() ->
    go( 0 ).

