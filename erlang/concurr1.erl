-module( concurr1 ).

-export( [start/0, sayStuff/2] ).

sayStuff( _, 0 ) ->
   done;
sayStuff( Y, X ) ->
   io:format( "~p~n", [Y] ),
   sayStuff( Y, X - 1 ).

start() ->
   spawn( concurr1, sayStuff, ["Hi", 10] ),
   spawn( concurr1, sayStuff, ["Bye",10] ).
