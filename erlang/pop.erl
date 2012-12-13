% pop.erl
% Population projections
% Well, population projections for an immortal race...

% Simon Heath
% 7/5/2006

-module( pop ).
-export( [additivePopulation/3, sanePopulation/4] ).

% Takes an initial population, a number of generations, and a number of
% children for each female.
% This assumes that all females raise a new generation each generation.
additivePopulation( InitPop, 1, NumChildren ) ->
   NumFemales = InitPop / 2,
   InitPop + (NumFemales * NumChildren);

additivePopulation( InitPop, NumGenerations, NumChildren ) ->
   NumFemales = InitPop / 2,
   NewPop = InitPop + (NumFemales * NumChildren),
   additivePopulation( NewPop, NumGenerations - 1, NumChildren ).


% Same as above, but only the most recent generation makes a new generation.
sanePopulation( InitPop, LastGenPop, 1, NumChildren ) ->
   NumFemales = LastGenPop / 2,
   InitPop + (NumFemales * NumChildren);

sanePopulation( InitPop, LastGenPop, NumGenerations, NumChildren ) -> 
   NumFemales = LastGenPop / 2,
   NewGen = NumFemales * NumChildren,
   sanePopulation( InitPop + LastGenPop, NewGen, 
                   NumGenerations - 1, NumChildren ).
