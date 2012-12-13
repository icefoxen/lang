% randomnamex.erl
% randomnamex, re-written in erlang since the original got nuked.
% ...you know, Erlang is really nice stuff.  It's halfway between
% Haskell and Python, with a bit of Prolog thrown in.
%
% Simon Heath
% 22/2/2006

-module( randomnamex ).
-export( [] ).
%-import( [lists, file, io] ).


file2list( Filename ) ->
   
% ...I know there's some sane transparent way of matching the error value
% right off of the function call, but I'm not sure what it is.  match?
file2list( FileDesc, Accm ) ->
   slurpFile( file:open( 
