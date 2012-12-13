-module( guitest ).

-export( [init/0] ).

init() ->
   GContext = gs:start(),
   % Parent of toplevel window is GS server
   Win = gs:create( window, GContext, [{width,200}, {height,200}] ),
   Button = gs:create( button, Win, [{label, {text, "Drink me"}}] ),
   gs:config( Win, {map, true} ),
   loop( Button ).


% ...how the smeg...?
loop( Button ) ->
  receive
      {gs, Button, click, Data, Args} ->
         io:format( "Hi there~n", [] ),
         loop( Button )
   end.
