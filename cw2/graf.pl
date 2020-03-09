d(a, b, 1).
d(b, e, 2).
d(b, c, 1).
d(d, e, 2).
d(c, d, 3).
d(e, f, 1).
d(g, e, 4).

tel(g).

go(X, X, T, _) :-
    write(T),
    nl.

neigh(X, Y, C) :- d(X, Y, C).
neigh(X, Y, C) :- d(Y, X, C).

go(X, Y, T, Len) :- 
    neigh(X, Z, C),
    \+ member(Z, T),
    write(Len),
    nl,
    Sum is Len + C,
    go(Z, Y, [Z|T], Sum).

member(X, [X|_]).
member(X, [_|H]) :- member(X, H).