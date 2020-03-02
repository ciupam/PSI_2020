fib(0, 0).
fib(1, 1).

fib(N, Nfib) :-
    N > 1,
    A is N - 1,
    fib(A, Afib),
    B is A - 1,
    fib(B, Bfib),
    Nfib is Afib + Bfib.