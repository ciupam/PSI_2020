brAnd(0, 0, 0).
brAnd(0, 1, 0).
brAnd(1, 1, 1).
brAnd(1, 0, 0).
brOr(0, 0, 0).
brOr(0, 1, 1).
brOr(1, 1, 1).
brOr(1, 0, 1).
brXor(0, 1, 1).
brXor(1, 0, 1).
brXor(0, 0, 0).
brXor(1, 1, 0).

ukl(A, B, C, D, E, F, G, H, I, J, K) :-
    brAnd(A, B, G),
    brOr(C, D, H),
    brAnd(E, F, J),
    brXor(G, H, I),
    brOr(I, J, K).