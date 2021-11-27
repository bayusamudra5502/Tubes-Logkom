:- dynamic(inAlchemist/1).

alchemistItem(a1, '🍾', 'Speciality Potion').
alchemistItem(a2, '🍾', 'Time Potion').

alchemistPrice(a1, 2000).
alchemistPrice(a2, 3000).

isPotionAvailable :-
	inventory(CurrentInventory)
	is_member(a1, CurrentInventory, _);
	inventory(CurrentInventory)
	is_member(a2, CurrentInventory, _).

printPotionList(ID) :-
	isPotionAvailable, !.

usePotion :- 
	runProgram(_).

/* alchemist masih belum sampai */
alchemist :-
	runProgram(_),
	\+inAlchemist(_),nl,
	write('Kamu masih terlalu jauh dari alchemist.'),
	!.

/* pemain sudah di alchemist */
alchemist :-
	runProgram(_),
	inAlchemist(_),
	nl,nl,
	write('--- Alchemist ---'), nl,
	write('1. Beli 🍾 Speciality Potion (2000 G)'),nl,
	write('2. Beli 🍾 Time Potion (3000 G)'),nl,
	write('3. Detail Item'), nl,
	write('4. Keluar'), nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> write('sleep');
				 X =:= 2 -> write('sleep');
				 X =:= 3 -> write('sleep');
         X =:= 4 -> s,nl,write('Kamu telah berada di luar alchemist')),!.

