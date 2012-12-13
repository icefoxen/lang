-module( bot ).
-author( "jonathan.roes@gmail.com" ).
-export( [connect/2, loop/1] ).
-define( nickname, "testbot" ).
-define( channel, "#bottest" ).

% Connect to an IRC server with given Host and Port.  Set up the TCP option to
% give us messages per line.
connect( Host, Port ) ->
   {ok, Sock} = gen_tcp:connect( Host, Port, [{packet, line}] ),
   gen_tcp:send( Sock, "NICK " ++ ?nickname ++ "\r\n" ),
   gen_tcp:send( sock, "USER " ++ ?nickname ++ " 0 * :test bot\r\n" ),
   loop( Sock ).

loop( Sock ) ->
   receive
      {tcp, Sock, Data} ->
         io:format( "[~w] Received: ~s", [Sock, Data] ),
         parse_line( Sock, string:tokens( Data, ": " ) ),
         loop( Sock );
      quit ->
         io:format( "[~w] Received quit message, exiting...~n", [Sock] ),
         gen_tcp:close( Sock ),
         exit( stopped )
   end.

parse_line( Sock, [User, "PRIVMSG", Channel, ?nickname|_] ) ->
   Nick = list:nth( 1, string:tokens( User, "!" ) ),
   irc_privmsg( Sock, Channel, "Yar, " ++ Nick ++ "!" );

parse_line( Sock, [_, "376"|_] ) ->
   gen_tcp:send( Sock, "JOIN :" ++ ?channel ++ "\r\n" );
parse_line( Sock, ["PING"|Rest] ) ->
   gen_tcp:send( Sock, "PONG " ++ Rest ++ "\r\n" );
parse_line( _, _ ) -> 0.

irc_privmsg( Sock, To, Message ) ->
   gen_tcp:send( Sock, "PRIVMSG " ++ To ++ " :" ++ Message ++ "\r\n" ).
