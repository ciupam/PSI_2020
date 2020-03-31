:- dynamic xpositive/2.
:- dynamic xnegative/2.

%1. Opis obiektów (ich cech charakterystycznych) 

game_is(witcher3) :-
    it_is(rpg),
    it_is(action),
    it_is(card_game),
    positive(has, cruelty),
    positive(has, nudity),
    negative(has, multiplayer),
    negative(has, microstransactions).

game_is(slay_the_spire)
    it_is(strategy),
    it_is(card_game),
    negative(has, multiplayer),
    negative(has, microstransactions).

game_is(minecraft) :-
    it_is(sandbox),
    positive(has, multiplayer),
    positive(has, microstransactions).

game_is(terraria) :-
    it_is(sandbox),
    positive(has, multiplayer).

game_is(f1) :-
    it_is(racing),
    positive(has, multiplayer).

game_is(battlefield) :-
    it_is(shooter),
    it_is(action),
    positive(has, multiplayer).

game_is(cod) :- 
    it_is(shooter),
    it_is(action),
    positive(has, multiplayer).

game_is(mario_kart) :-
    it_is(racing),
    positive(has, multiplayer).

game_is(animal_crossing) :-
    it_is(sandbox),
    positive(has, microstransactions),
    positive(has, multiplayer).

game_is(hearthstone) :-
    it_is(strategy),
    it_is(card_game),
    positive(has, microstransactions),
    positive(has, multiplayer).

%2. Opis cech charakterystycznych dla klas obiektów

it_is(rpg) :-
    positive(has, fictional_setting),
    positive(has, advanced_narrative),
    positive(has, npcs),
    positive(has, decision_making).

it_is(strategy) :-
    positive(has, advanced_decision_making).

it_is(racing) :-
    positive(has, vehicles),
    positive(has, tracks),
    positive(has, scoreboard).

it_is(shooter) :-
    positive(has, firearms),
    positive(has, opponents),
    positive(has, multiple_game_maps).

it_is(action) :-
    positive(has, physical_challenge),
    positive(has, hand_eye_coordination),
    positive(has, reaction_time),
    positive(is, challenging).

it_is(card_game) :-
    positive(has, cards).

it_is(sandbox) :-
    positive(has, tools),
    positive(has, big_map),
    negative(has, advanced_narrative).

%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie

positive(X, Y) :- xpositive(X,Y), !.

positive(X, Y) :- not(xnegative(X, Y)), ask(X, Y, yes).

negative(X, Y) :- xnegative(X, Y), !.

negative(X, Y) :-
    not(xpositive(X, Y)),
    ask(X, Y, no).

%4. Zadawanie pytań użytkownikowi

ask(X, Y, yes) :-
    write(X), write(' it '), write(Y), write('\n'),
    read(Reply),
    sub_string(Reply, 0, 1, _, 'y'), !,
    remember(X, Y, yes).

ask(X, Y, yes) :- remember(X, Y, no), fail.

ask(X, Y, no) :-
    write(X), write(' it '), write(Y), write('\n'),
    read(Reply),
    sub_string(Reply, 0, 1, _, 'n'), !,
    remember(X, Y, no).

ask(X, Y, no) :- remember(X, Y, yes), fail.

%5. Zapamiętanie odpowiedzi w dynamicznej bazie

remember(X, Y, yes) :- asserta(xpositive(X, Y)).

remember(X, Y, no) :- asserta(xnegative(X, Y)).

%6. Uruchomienie programu

run :-
    game_is(X), !,
    write('\nYour game may be a(n) '), write(X),
    nl, nl, clear_facts.

run :-
    write('\nUnable to determine what'),
    write('your game is.\n\n'), clear_facts.

%7. Wyczyszczenie zawartości dynamicznej bazy

clear_facts :- retract(xpositive(_, _)), fail.

clear_facts :- retract(xnegative(_, _)), fail.

clear_facts :- write('\n\nPlease press the space bar to exit\n'). 