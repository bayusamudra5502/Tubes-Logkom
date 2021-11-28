:- dynamic(inAlchemist/1).
:- dynamic(inEffect/1).

alchemistItem(a1, '🍾', 'Speciality Potion').
alchemistItem(a2, '🍾', 'Time Potion').

alchemistPrice(a1, 2000).
alchemistPrice(a2, 500).
energiPrice(a3, 2000).

isPotionAvailable(ID) :-
	inventory(CurrentInventory),
	is_member(ID, CurrentInventory, _), !.

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
	% inEffect(_),
	inventory(CurrentInventory),
	isPotionAvailable(a1),
	player(A,_,_,_,_,_,_,_,_,_,_,_,_),
	write('Menerapkan Speciality Potion'),nl,
	addXPSpeciality(A), 
	is_member(a1,CurrentInventory, Idx),
	select_nth(CurrentInventory,Idx,[C,B]),
	NewVal is B - 1,
	set_nth(CurrentInventory, Idx,[C,NewVal],NewInventory),
	asserta(inventory(NewInventory)),
	retract(inventory(CurrentInventory)),
	levelUp.

specialityEffect :-
	\+ isPotionAvailable(al),
	write('Anda tidak memiliki Speciality Potion'), nl, !.

goToMorning :-
	% inEffect(_),
	isPotionAvailable(a2),
	time(_, Hari, Musim, NamaMusim, Tahun),
	retract(time(_, _, _, _, _)),
	retract(kegiatan(_)),
	asserta(kegiatan(0)),
	asserta(time('Siang', Hari, Musim, NamaMusim, Tahun)), !.

timeEffect :-
	inEffect(_),
	inventory(CurrentInventory),
	isPotionAvailable(a2),
	write('Menerapkan Time Potion'), nl,
	goToMorning,
	is_member(a2,CurrentInventory, Idx),
	select_nth(CurrentInventory,Idx,[A,B]),
	NewVal is B - 1,
	set_nth(CurrentInventory, Idx, [A,NewVal], NewInventory),
	asserta(inventory(NewInventory)),
	retract(inventory(CurrentInventory)), !.

timeEffect :-
	\+ isPotionAvailable(a2),
	write('Anda tidak memiliki Time Potion'), nl, !.

getPotionAmount(ID, Amount) :-
	inventory(CurrentInventory),
	is_member(ID, CurrentInventory, IDX),
	getItemAmount(CurrentInventory, IDX, Amount), !.
	

printPotionStatus(ID) :- 
	inventory(CurrentInventory),
	is_member(ID, CurrentInventory,Idx),
	select_nth(CurrentInventory,Idx, [_,B]),
	alchemistItem(ID,Icon,Nama),
	write(ID), write('. '), write(Icon), write(' '),
	write(Nama), nl, !.
	
printPotionStatus(ID) :- !.

applyingPotion(a1) :- specialityEffect, !.
applyingPotion(a2) :- timeEffect, !.
applyingPotion(3) :- !.
applyingPotion(_) :- write('ID Tidak tepat. Silahkan coba lagi.'), nl, !, fail.

usePotion :- 
	write('Daftar Potion:'), nl,
	printPotionStatus(a1),
	printPotionStatus(a2),nl,
	write('Pilihan (masukan ID item) : '), read(X), nl,
	asserta(inEffect(1)),
	applyingPotion(X),
	retractall(inEffect(_)),!.

usePotion :-
	write('Saat ini kamu masih belum punya potion.'),
	!, fail.

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

buyEnergi(ID) :-
	energiPrice(ID, Price),
	gold(Gold),
	Price > Gold,
	write('Uang kamu tidak cukup untuk membeli energi'),
	!, fail.

buyEnergi(ID) :-
	energiPrice(ID, Price),
	gold(Gold), energi(Energi),
	write('Berhasil Membeli energi'),nl,
	write('Energi Anda sekarang bertambah 50 '),
	NewGold is Gold - Price,
	NewEnergi is Energi + 50,
	retract(energi(Energi)),
	asserta(energi(NewEnergi)),
	retract(gold(Gold)),
	asserta(gold(NewGold)),
	!.

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
	write('------------ Alchemist --------------'), nl,
	write('1. Beli 🍾 Speciality Potion (2000 G)'),nl,
	write('2. Beli 🍾 Time Potion (500 G)'),nl,
	write('3. Beli 🍾 Energy Potion (2000 G)'),nl,
	write('4. Keluar'), nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> buyPotion(a1);
				 X =:= 2 -> buyPotion(a2);
				 X =:= 3 -> buyEnergi(a3);
         X =:= 4 -> s,nl,write('Kamu telah berada di luar alchemist')),!.

