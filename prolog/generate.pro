% Demonstrates a generate-and-test function.
% It generates a number and tests to see if it's square is two digits.

% If you refuse all the answers, it does NOT fail; it just gets caught in a 
% generate->test cycle infinately.  You may be able to fix this by having:
% A) the test return some signal when the max is exceeded, or
% B) the generator have a max limit imposed on it, either internally or by 
% the caller function.
int_with_two_digit_square( X ):-
   int( X ), % There's a primative called 'integer', so we call this 'int'.
   test_square( X ).

test_square( X ):-
   Y is X * X,
   Y >= 10,
   Y < 100.

int( 1 ).
int( N ):-
   int( N1 ),
   N is N1 + 1.
