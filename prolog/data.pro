% data.pl
% Defines a 'date' datatype.

date( Y, M, D ).

make_date( Y, M, D, date( Y, M, D ) ).

% get_year matches any date where the year = Y, and so on.
get_year( date( Y, _, _ ), Y ).
get_month( date( _, M, _ ), M ).
get_day( date( _, _, D ), D ).

% Okay... HOW do these work?
set_year( Y, date( _, M, D), date( Y, M, D ) ).
set_month( M, date( Y, _, D ), date( Y, M, D ) ).
set_day( D, date( Y, M, _ ), date( Y, M, D ) ).


