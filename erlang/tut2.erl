% tut2.erl
% Slightly more sophisticated stuff, now...
% Note that functions are known by name/arity, not just name, and not
% name/argtypes
% listMax/1 != listMax/2
%
% Simon Heath
% 23/10/2004

-module( tut2 ).
-export( [listMax/1, reverse/1] ).

listMax( [Head|Rest] ) ->
   listMax( Rest, Head ).

% ...woah.  Wild stuff.
% (defun listMax (lst accm)
%    (cond
%       ((null lst) accm)
%       ((> (car lst) accm) (listMax (cdr lst) (car lst)))
%       (t (listMax (cdr lst) accm))))
listMax( [], Res ) ->
   Res;
listMax( [Head|Rest], ResultSoFar ) when Head > ResultSoFar ->
   listMax( Rest, Head );
listMax( [_|Rest], ResultSoFar ) ->
   listMax( Rest, ResultSoFar ).

reverse( List ) ->
   reverse( List, [] ).

% This function isn't exported...
reverse( [Car|Cdr], Accm ) ->
   reverse( Cdr, [Car|Accm] );
reverse( [], Accm ) ->
   Accm.



month_length(Year, Month) ->
   %% All years divisible by 400 are leap
   %% Years divisible by 100 are not leap (except the 400 rule above)
   %% Years divisible by 4 are leap (except the 100 rule above)
   Leap = if
      trunc(Year / 400) * 400 == Year ->
         leap;
      trunc(Year / 100) * 100 == Year ->
         not_leap;
      trunc(Year / 4) * 4 == Year ->
         leap;
      true ->
         not_leap
   end,  
   case Month of
      sep -> 30;
      apr -> 30;
      jun -> 30;
      nov -> 30;
      feb when Leap == leap -> 29;
      feb -> 28;
      jan -> 31;
      mar -> 31;
      may -> 31;
      jul -> 31;
      aug -> 31;
      oct -> 31;
      dec -> 31
   end.

