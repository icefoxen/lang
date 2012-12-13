-module(guitest2).

-export([start/0,init/0]).

start() ->
    spawn(guitest2,init,[]).

init() ->
    S = gs:start(),
    W = gs:create(window,S,[{map,true},{keypress,true},
                            {buttonpress,true},{motion,true}]),
    gs:create(button,W,[{label,{text,"PressMe"}},{enter,true},
                        {leave,true}]),
    event_loop().

event_loop() ->
    receive
        X ->
            io:format("Got event: ~w~n",[X]),
            event_loop()
    end.
