-module(guitest5).
-copyright('Copyright (c) 1991-97 Ericsson Telecom AB').
-vsn('$Revision: /main/release/2 $ ').

-export([start/0, init/0]).

start() ->
   spawn( guitest5, init, [] ).

init() -> 
    S = gs:start(),
    gs:create(window,win1,S,[{width,200},{height,100}]),
    gs:create(button,b1,win1,[{label, {text,"Press Me"}}]),
    gs:config(win1, {map,true}),
    loop().     

loop() ->
    receive
        {gs, b1, click, Data, Args} ->
            io:format("Hello World!~n",[]),
            loop()
    end.
