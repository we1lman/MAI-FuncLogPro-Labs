% Ensure all participants have different ranks
unique_ranks(P, L, K, S) :-
    P \= L,
    P \= K,
    P \= S,
    L \= K,
    L \= S,
    K \= S.

% Fan 1 Conditions
fan1_condition(P, _, K, _) :-
    P \= 1, !, 
    K is 4.
fan1_condition(_, _, _, _).

% Fan 2 Conditions
fan2_condition(P, _, K, _) :-
    K is 3, !, 
    P is 4.
fan2_condition(_, _, _, _).

fan2_additional_condition(P, _, _, S) :-
    P < S.

% Fan 3 Conditions
fan3_condition1(P, L, _, _) :-
    L \= 1, !, 
    P is 3.
fan3_condition1(_, _, _, _).

fan3_condition2(_, _, K, S) :-
    K is 2, !, 
    S \= 4.
fan3_condition2(_, _, _, _).

% Fan 4 Conditions
fan4_condition1(_, _, K, S) :-
    K is 1, !, 
    S is 2.
fan4_condition1(_, _, _, _).

fan4_condition2(_, L, _, S) :-
    S \= 2, !, 
    L \= 2.
fan4_condition2(_, _, _, _).

% Main predicate to determine the ranks of participants
determine_ranks(P, L, K, S) :-
    T = [1, 2, 3, 4],
    member(P, T),
    member(L, T),
    member(K, T),
    member(S, T),
    unique_ranks(P, L, K, S),
    fan1_condition(P, L, K, S),
    fan2_condition(P, L, K, S),
    fan2_additional_condition(P, L, K, S),
    fan3_condition1(P, L, K, S),
    fan3_condition2(P, L, K, S),
    fan4_condition1(P, L, K, S),
    fan4_condition2(P, L, K, S).
