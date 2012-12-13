-module(echo).
-export([start/0, stop/1, init/0]).
-include_lib("exmpp/include/exmpp_client.hrl").

start() ->
    spawn(?MODULE, init, []).
    %spawn(echo, init, []).

stop(EchoClientPid) ->
    EchoClientPid ! stop.

%% Basic setup: make values, try to connect to server
init() ->
    application:start(exmpp),
    MySession = exmpp_session:start(),
    MyJID = exmpp_jid:make("testbot", "alopex.li", random),
    exmpp_session:auth_basic_digest(MySession, MyJID, "testbot"),
    _StreamId = exmpp_session:connect_TCP(MySession, "alopex.li", 5222),
    session(MySession, MyJID).

%% Connected, now try logging in.
%% Do not register.
session(MySession, _MyJID) ->
    exmpp_session:login(MySession),
    exmpp_session:send_packet(MySession,
			      exmpp_presence:set_status(
				exmpp_presence:available(), "Echo ready.")),
    loop(MySession).

%% Main loop.
loop(MySession) ->
    receive
	stop ->
	    exmpp_session:stop(MySession);
	Record = #received_packet{packet_type=message, raw_packet=Packet} ->
	    io:format("~p~n", [Record]),
	    echo_packet(MySession, Packet),
	    loop(MySession);
	Record = #received_packet{packet_type=presence, type_attr="subscribe", from=From} ->
	    io:format("~p~n", [Record]),
	    subscribe_ok(MySession, From);
	Record ->
	    io:format("~p~n", [Record]),
	    loop(MySession)
    end.

echo_packet(MySession, Packet) ->
    From = exmpp_xml:get_attribute(Packet, from, <<"unknown">>),
    To = exmpp_xml:get_attribute(Packet, to, <<"unknown">>),
    TmpPacket = exmpp_xml:set_attribute(Packet, from, To),
    TmpPacket2 = exmpp_xml:set_attribute(TmpPacket, to, From),
    NewPacket = exmpp_xml:remove_attribute(TmpPacket2, id),
    exmpp_session:send_packet(MySession, NewPacket).

subscribe_ok(MySession, From) ->
    Packet1 = exmpp_presence:subscribed(),
    % XXX: How do I turn the From tuple into the binary needed?
    Packet2 = exmpp_xml:set_attribute(Packet1, to, <<"icefox@alopex.li">>),
    Packet3 = exmpp_xml:remove_attribute(Packet2, id),
    exmpp_session:send_packet(MySession, Packet3).

