% how to use:
%kosken> erl -sname ping
%
%gollum> erl -sname pong
%
%(pong@gollum)1> pingpong2:start_pong().
%(ping@kosken)1> pingpong2:start_ping(pong@gollum).

-module(pingpong2).

-export([start_ping/1, start_pong/0,  ping/2, pong/0]).

ping(0, Pong_Node) ->
    {pong, Pong_Node} ! finished,
    io:format("ping finished~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()},
    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N - 1, Pong_Node).

pong() ->
    receive
        finished ->
            io:format("Pong finished~n", []);
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []),
            Ping_PID ! pong,
            pong()
    end.

start_pong() ->
    register(pong, spawn(pingpong2, pong, [])).

start_ping(Pong_Node) ->
    spawn(pingpong2, ping, [10, Pong_Node]).
