% Possible transitions (moves)
move(A,B) :- append(H, ['_','white'|T], A), append(H, ['white','_'|T], B).
move(A,B) :- append(H, ['white','_'|T], A), append(H, ['_','white'|T], B).
move(A,B) :- append(H, ['_','black'|T], A), append(H, ['black','_'|T], B).
move(A,B) :- append(H, ['black','_'|T], A), append(H, ['_','black'|T], B).
move(A,B) :- append(H, ['_','black','white'|T], A), append(H, ['white','black','_'|T], B).
move(A,B) :- append(H, ['_','white','black'|T], A), append(H, ['black','white','_'|T], B).
move(A,B) :- append(H, ['black','white','_'|T], A), append(H, ['_','white','black'|T], B).
move(A,B) :- append(H, ['white','black','_'|T], A), append(H, ['_','black','white'|T], B).

% Prolongation: generates next state from current state
prolong([A|T], [B,A|T]) :- move(A, B), not(member(B, [A|T])).

% Generate numbers from 1 upwards
num(1).
num(N) :- num(N1), N is N1 + 1.

% Depth-First Search (DFS)
dfs(A, B) :- write(A), ddth([[A]], B, T), print(T), !.

% Depth-first search traversal
ddth([[H|T]|_], H, [H|T]).
ddth([H|T], A, C) :- findall(W, prolong(H, W), B), append(B, T, E), !, ddth(E, A, C).
ddth([_,T], A, B) :- ddth(T, A, B).

% Breadth-First Search (BFS)
bfs(A, B) :- write(A), bdth([[A]], B, T), print(T), !.

% Breadth-first search traversal
bdth([[H|T]|_], H, [H|T]).
bdth([H|T], A, B) :- findall(W, prolong(H, W), Z), append(T, Z, E), !, bdth(E, A, B).
bdth([_,T], A, B) :- bdth(T, A, B).

% Iterative Deepening Search (IDS)
search_id(A, B, W, D) :- depth_id([A], B, W, D).
depth_id([H|T], H, [H|T], 0).
depth_id(W, A, B, N) :- N > 0, prolong(W, Z), N1 is N - 1, depth_id(Z, A, B, N1).
search_id(A, B, C) :- num(T), search_id(A, B, C, T).
search_id(A, B) :- write(A), search_id(A, B, C), print(C), !.

% Print result
print([_]).
print([H|T]) :- print(T), nl, write(H).