% predicate my_length
my_length([], 0).
my_length([_|Y], N) :- my_length(Y, N1), N is N1 + 1.

% predicate member
member(A, [A|_]).
member(A, [_|Z]) :- member(A, Z).

% predicate append
append([], X, X).
append([A | X], Y, [A | Z]) :- append(X, Y, Z).

% predicate remove
remove(X, [X | Y], Y).
remove(X, [Y | Z], [Y | Z1]) :- remove(X, Z, Z1).

% predicate permute
permute([], []).
permute(L, [X | T]) :- remove(X, L, R), permute(R, T).

% predicate sublist
sublist(S, L) :- append(_, L1, L), append(S, _, L1).

% predicate add
add(X, [], [X]).
add(X, [Y | Z], [Y | W]) :- add(X, Z, W).

% predicate remove_n

% Base case 1: If N = 0, return the list unchanged.
remove_n(0, List, List).

% Base case 2: If list is empty, result is an empty list.
remove_n(_, [], []).

% Recursive case: Remove the first element and decrease N by 1.
remove_n(N, [_|Tail], Result) :-
    N > 0,
    N1 is N - 1,
    remove_n(N1, Tail, Result).

% predicate lex_compare

% If both lists are empty, they are equal.
lex_compare([], [], '=').

% If first list is empty and second is not, first is smaller.
lex_compare([], [_|_], '<').

% If second list is empty and first is not, first is greater.
lex_compare([_|_], [], '>').

% If first elements differ, determine result by comparing them.
lex_compare([H1|_], [H2|_], Result) :-
    H1 \= H2,
    compare_elements(H1, H2, Result).

% If first elements are equal, recursively compare tails.
lex_compare([H|T1], [H|T2], Result) :-
    lex_compare(T1, T2, Result).

% predicate compare_elements

compare_elements(E1, E2, '<') :-
    E1 @< E2, !.

compare_elements(E1, E2, '>') :-
    E1 @> E2.
