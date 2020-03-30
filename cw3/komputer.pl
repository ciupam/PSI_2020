:-dynamic komputer/5.

wykPrg:-
    write('1 - biezacy stan bazy danych'), nl,
    write('2 - dopisanie nowego komputera'), nl,
    write('3 - usuniecie komputera'), nl,
    write('4 - obliczenie sredniej ceny komputerów'), nl,
    write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
    write('6 - zapisanie bazy w pliku'), nl,
    write('7 - dane oraz liczba komputerow o podanej nazwie procestoea'), nl,
    write('8 - dane oraz liczba komputerow o cenie mniejszej niz podana'), nl,
    write('0 - koniec programu'), nl, nl,
    read(I),
    I > 0,
    opcja(I),
    wykPrg.

wykPrg.

opcja(1) :- wyswietl.

opcja(2) :- 
    write('Podaj nazwę procesora:'), read(NazwaProcesora),
    write('Podaj typ procesora:'), read(TypProcesora),
    write('Podaj częstotliwość:'), read(Czestotliwosc),
    write('Podaj rozmiar HDD'), read(Rozmiar),
    write('Podaj cenę:'), read(Cena), nl,
    \+ komputer(NazwaProcesora, TypProcesora, Czestotliwosc, Rozmiar, Cena),
    assert(komputer(NazwaProcesora, TypProcesora, Czestotliwosc, Rozmiar, Cena)).

opcja(3) :- 
    write('Podaj nazwe usuwanego procesora:'), read(NazwaProcesora),
    retract(komputer(NazwaProcesora,_,_,_,_)),! ;
    write('Brak takiego komputera').

opcja(4) :- sredniaCena.

opcja(5) :- 
    write('Podaj nazwe pliku:'), read(Nazwa),
    exists_file(Nazwa), !, consult(Nazwa);
    write('Brak pliku o podanej nazwie'), nl.

opcja(6) :- 
    write('Podaj nazwe pliku:'), read(Nazwa),
    open(Nazwa, write, X), zapis(X), close(X).

opcja(7) :-
    write('Podaj nazwe procesora:'), read(Nazwa),
    szukajNazwa(Nazwa), nl.

opcja(8) :-
    write('Podaj cene procesora:'), read(Cena),
    szukajCena(Cena), nl.

opcja(_) :- write('Zly numer opcji'), nl.

szukajNazwa(Nazwa) :-
     findall([Nazwa, Typ, Czestotliwosc, Rozmiar, Cena], komputer(Nazwa, Typ, Czestotliwosc, Rozmiar, Cena), Lista),
     write('Ile znaleziono:'),
     length(Lista, Ilosc),
     write(Ilosc), nl,
     wypisz(Lista), nl.

szukajCena(SzukanaCena) :-
     findall([Nazwa, Typ, Czestotliwosc, Rozmiar, Cena], (komputer(Nazwa, Typ, Czestotliwosc, Rozmiar, Cena), Cena < SzukanaCena), Lista),
     write('Ile znaleziono:'),
     length(Lista, Ilosc),
     write(Ilosc), nl,
     wypisz(Lista), nl.

wyswietl :- 
    write('Elementy bazy:'), nl,
    komputer(NazwaProcesora, TypProcesora, Czestotliwosc, Rozmiar, Cena),
    write(NazwaProcesora), write(' '), 
    write(TypProcesora), write(' '),
    write(Czestotliwosc), write(' '),
    write(Rozmiar), write(' '),
    write(Cena), write(' '),
    nl, fail.

wyswietl :- nl.

sredniaCena :- 
    findall(Cena, komputer(_,_,_,_,Cena), Lista),
    suma(Lista, Suma, LiczbaKomputerow),
    SredniaCena is Suma / LiczbaKomputerow,
    write('Srednia cena:'), write(SredniaCena), nl, nl.

zapis(X) :- 
    komputer(NazwaProcesora, TypProcesora, Czestotliwosc, Rozmiar, Cena),
    write(X, 'komputer('),
    write(X, NazwaProcesora), write(X, ','), 
    write(X, TypProcesora), write(X, ','),
    write(X, Czestotliwosc), write(X, ','),
    write(X, Rozmiar), write(X, ','),
    write(X, Cena),
    write(X, ').'), nl(X), fail.

zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- 
    suma(Og, S1, N1),
    Suma is G + S1,
    N is N1+1.

wypisz([]).
wypisz([G|Og]) :-
    wypisz(Og),
    write(G), nl.

%komputer(nazwa_procesora, typ_procesora, 1500, 256, 3000).
%komputer(nazwa1, typ1, 500, 128, 1500).