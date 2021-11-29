
[main].
startGame.
1.
'Gilang'.
2.
1.
retract(posisi(_,_)).
asserta(posisi(16,4)).
asserta(inHouse(1)).

---
[main].
startGame.
1.
'Udin'.
2.
1.
retract(posisi(_,_)).
asserta(posisi(2,2)).
insert_item(e10,2).
ranch.

--- Fish
[main].
quitGame.
startGame.
1.
'Udin'.
1.
1.
retract(posisi(_,_)).
asserta(posisi(9,9)).
insert_item(fu2,1).

-Nitip
[main].
startGame.
1.
'a'.
3.
1.
retract(posisi(_,_)).
asserta(posisi(3,17)).
asserta(inRanch(1)).
insert_item(r4,2), insert_item(r7,1).
ranch.
1.
retract(time(A,B,C,D,E)), asserta(time(A,11,C,D,E)).
ranchCountDays(X), checkRanch(X, r4, Y), retract(time(A,B,C,D,E)), asserta(time(A,12,C,D,E)), checkRanch(Y, r4,Z).
ranch.
2.
r4.

insert_item(r4,3), insert_item(r5,2), insert_item(r7,1).
retract(time(A,B,C,D,E)), asserta(time(A,1,C,D,E)).
ranchCountDays(X), checkRanch(X, r4, Y),retract(time(A,B,C,D,E)), asserta(time(A,13,C,D,E)), checkRanch(Y, r4, Z).

ranch.

--- alchemist
[main].
startGame.
1.
'a'.
1.
1.
retract(posisi(_,_)).
asserta(posisi(16,16)).
retract(gold(_)).
asserta(gold(10000)).

