% Tests the 'cut' function, !
% It stops the program from backtracking and looking for another solution, I 
% think.

% This finds an answer, then if you refuse it keeps looking indefinately.
% Try loading it, going into trace mode, and doing sum( 3, X ).  If you refuse,
% it redo's, hits 0, then keeps on recursing, looking for an answer.
sum( 1, 1 ).
sum( N, Ans ):-
   NewN is N - 1,       % reduce problem,
   sum( NewN, Ans1 ),   % recurse,
   Ans is Ans1 + N.     % build solution

% This finds an answer, then if you refuse it, it fails.
% Here, if you refuse, it recurses back to sum( 1, 1 ), which then fails.
sum2( 1, 1 ):-
   !.
sum2( N, Ans ):-
   NewN is N - 1,
   sum2( NewN, Ans1 ),
   Ans is Ans1 + N.


