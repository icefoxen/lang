% test3.erl
% If constructs, yay!

-module( tut3 ).
-export( [test_if/2, month_length/2] ).

test_if( A, B ) ->
   if
      A == 5 ->
         io:format( "A = 5~n", [] ),
	 a_equals_5;
      B == 6 ->
         io:format( "B = 6~n", [] ),
	 b_equals_6;
      A == 2, B == 3 ->       % A == 2 and B == 3
         io:format( "A == 2, B == 3~n", [] ),
         a_equals_2_b_equals_3;
      A == 1 ; B == 7 ->      % A == 1 or B == 7
         io:format( "A == 1 ; B == 7~n", [] ),
         a_equals_1_or_b_equals_7
   end.


% Just what the heck is the difference between if and case anyway?
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

