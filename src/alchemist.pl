:- dynamic(inAlchemist/1).
:- dynamic(inEffect/0).

alchemistItem(a1, '🍾', 'Speciality Potion').
alchemistItem(a2, '🍾', 'Time Potion').

alchemistPrice(a1, 2000).
alchemistPrice(a2, 3000).

isPotionAvailable(ID) :-
	inventory(CurrentInventory)
	is_member(ID, CurrentInventory, _).

isAnyPotionInventory :-
	isPotionAvailable(a1) ; isPotionAvailable(a2).

addXPSpeciality('Fisherman') :-
	player(A,B,C,D,E,F,G,H,I,J,K,L,M),
	GNew is G + 250,
	retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)),
	asserta(player(A,B,C,D,E,F,GNew,H,I,J,K,L,M)),
	levelUp.

addXPSpeciality('Farmer') :-
	player(A,B,C,D,E,F,G,H,I,J,K,L,M),
	DNew is D + 250,
	retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)),
	asserta(player(A,B,C,DNew,E,F,G,H,I,J,K,L,M)),
	levelUp.

addXPSpeciality('Rancher') :-
	player(A,B,C,D,E,F,G,H,I,J,K,L,M),
	JNew is J + 250,
	retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)),
	asserta(player(A,B,C,D,E,F,G,H,I,JNew,K,L,M)),
	levelUp, !.

specialityEffect :-
	inEffect,
	isPotionAvailable(a1),
	player(A,_,_,_,_,_,_,_,_,_,_,_,_),
	write('Menerapkan Speciality Potion'),nl,
	addXPSpeciality(A).

specialityEffect :-
	\+ isPotionAvailable(al),
	write('Anda tidak memiliki Speciality Potion'), nl, !, fail.

moveOneSeasonBackward :-
	inEffect,
	isPotionAvailable(a2),
	time(Waktu, Hari, 1, 'Spring', 1),
	retract(Waktu, Hari, 1, 'Spring', 1),
	asserta(time(Waktu, 1, 1, 'Spring', 1)), !.

moveOneSeasonBackward :-
	inEffect,
	isPotionAvailable(a2),
	time(Waktu, Hari, 1, 'Spring', Year),
	retract(time(Waktu, Hari, 1, 'Spring', Year)),
	asserta(time(Waktu, Hari, 4, 'Winter', Year)), !.

moveOneSeasonBackward :-
	inEffect,
	isPotionAvailable(a2),
	time(Waktu, Hari, 2, 'Summer', Year),
	retract(time(Waktu, Hari, 2, 'Summer', Year)),
	asserta(time(Waktu, Hari, 1, 'Spring', Year)), !.

moveOneSeasonBackward :-
	inEffect,
	isPotionAvailable(a2),
	time(Waktu, Hari, 3, 'Fall', Year),
	retract(time(Waktu, Hari, 3, 'Fall', Year)),
	asserta(time(Waktu, Hari, 2, 'Summer', Year)), !.

moveOneSeasonBackward :-
	inEffect,
	isPotionAvailable(a2),
	time(Waktu, Hari, 4, 'Winter', Year),
	retract(time(Waktu, Hari, 4, 'Winter', Year)),
	NewYear is Year - 1,
	asserta(time(Waktu, Hari, 3, 'Fall', Year)), !.

timeEffect :-
	inEffect,
	isPotionAvailable(a2),
	write('Menerapkan Time Potion'), nl,
	moveOneSeasonBackward, !.

timeEffect :-
	\+ isPotionAvailable(a2),
	write('Anda tidak memiliki Time Potion'), nl, !, fail.

getPotionAmount(ID, Amount) :-
	inventory(CurrentInventory),
	is_member(ID, CurrentInventory, IDX),
	getItemAmount(CurrentInventory, IDX, Amount), !.

printPotionStatus(ID) :-
	getPotionAmount(ID, Amount),
	alchemistItem(ID, Icon, Label),
	write(Icon),
	write(' '),
	write(Label),
	write(' ('),
	write(Amount),
	write('x)'), nl, !.

usePotion :- 
	write('Daftar Potion:'), nl,
	write('1. '),
	printPotionStatus(a1),
	write('2. '),
	printPotionStatus(a2),
	write('3. Keluar'), nl,nl,
	write('Pilihan : '), read(X),
	asserta(inEffect),
	(
		X =:= 1 -> specialityEffect,
		X =:= 2 -> timeEffect,
		X =:= 3 -> s,write('Kamu telah berada di luar alchemist')),
	retract(inEffect),!.

buyPotion(ID) :-
	alchemistPrice(ID, Price),
	gold(Gold),
	Price > Gold,
	write('Uang kamu ga cukup. Maaf.'),
	!, fail.

buyPotion(ID) :-
	alchemistPrice(ID, Price),
	gold(Gold),
	alchemistItem(ID, Icon, Label),
	write('Berhasil Membeli '),
	write(Icon),
	write(' '),
	write(Label), nl,
	NewGold is Gold - Price,
	insert_item(ID, 1),
	retract(gold(Gold)),
	asserta(gold(NewGold)),
	!.

usePotion :-
	write('Saat ini kamu masih belum punya potion.'),
	!, fail.

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
	write('3. Keluar'), nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> buyPotion(a1);
				 X =:= 2 -> buyPotion(a2);
         X =:= 3 -> s,nl,write('Kamu telah berada di luar alchemist')),!.

