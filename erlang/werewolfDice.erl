% werewolfDice.erl
% I wanna do some simulation of Werewolf dice-rolling and see how the
% curve falls under various conditions.
% I'd normally do this in Python, but I resolved to write stuff in Erlang,
% so.
%
% Simon Heath
% 21/2/2006

-module( werewolfDice ).
-export( [averageSuccesses/2, rollGroup/2, rollRange/1] ).
%-import( [random, lists] ).

%TargetNumber = 6.

%rollDice( Number ) ->
%   rollDice( Number, 0 ).

% Rolls a bunch of dice and returns a number of successes.
rollDice( 0, S ) ->
   S;
rollDice( Number, SuccessesSoFar ) ->
   TargetNumber = 6,
   Roll = random:uniform( 10 ),
   if
      Roll == 1 -> 
         rollDice( Number - 1, SuccessesSoFar - 1 );
% We're not doing Exalted.
%      Roll == 10 ->
%         rollDice( Number - 1, SuccessesSoFar + 2 );
      Roll >= TargetNumber ->
         rollDice( Number - 1, SuccessesSoFar + 1 );
      true ->
         rollDice( Number - 1, SuccessesSoFar )
   end.

rollXDice( X ) ->
   rollDice( X, 0 ).

% Now we want to roll a bunch of dice X times, and return the average
% number of successes.
rollGroup( GroupSize, NumTimes ) ->
   rollGroup( GroupSize, NumTimes, [] ).

rollGroup( _, 0, Accm ) ->
   Accm;
rollGroup( GroupSize, NumTimes, Accm ) -> 
   Successes = rollXDice( GroupSize ),
   rollGroup( GroupSize, NumTimes - 1, [Successes|Accm] ).


average( Lst ) ->
   Sum = fun( X, Y ) -> X + Y end,
   Total = lists:foldl( Sum, 0, Lst ),
   Total / length( Lst ).

averageSuccesses( GroupSize, NumTimes ) ->
   average( rollGroup( GroupSize, NumTimes ) ).


rollRange( 0 ) ->
   0;
rollRange( N ) ->
   Successes = averageSuccesses( N, 10000 ),
   io:format( "~w dice gets ~w successes~n", [N, Successes] ),
   rollRange( N - 1 ).
