:- dynamic(inQuest/1).
:- dynamic(questList/1).
/* quest masih belum sampai */
quest :-
	runProgram(_),
	\+inQuest(_),nl,
	write('Kamu masih terlalu jauh dari quest.'),
	!.

quest :- 
	runProgram(_),
	inQuest(_),
	write('# Selamat datang di Quest #'),nl,
	write('# 1. Ambil Quest #'),nl,
	write('# 2. Sumbit Quest #'),nl,
	write('# Apa yang ingin Kamu lakukan? #'),nl,
	read(X),(X =:= 1 -> takeQuest; X =:= 2 -> submitQuest),!.

/* pemain sudah di quest */

questList([[e1,1]]).

isSufficient(ID, N) :-
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M >= N.

checkQuest :-
	questList(X),
	traverseQuest(X), 
	write('Quest sudah terpenuhi !'),!.

traverseQuest([]) :- !.
traverseQuest([[ID,N]|T]) :- 
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	isSufficient(ID, N),
	traverseQuest(T).	

traversePrintQuest([]) :- !.
traversePrintQuest([[ID,N]|T]) :-
	crops(ID,_,U,Nama,_,_),
	\+fishItem(ID,UF,NamaF),
	\+ranchProduct(ID,_,UR,NamaR,_,_,_),
	write(ID),write('. '), write(Nama), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

traversePrintQuest([[ID,N]|T]) :-
	\+crops(ID,_,U,Nama,_,_),
	fishItem(ID,UF,NamaF),
	\+ranchProduct(ID,_,UR,NamaR,_,_,_),
	write(ID),write('. '), write(NamaF), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

traversePrintQuest([[ID,N]|T]) :-
	\+crops(ID,_,U,Nama,_,_),
	\+fishItem(ID,UF,NamaF),
	ranchProduct(ID,_,UR,NamaR,_,_,_),
	write(ID),write('. '), write(NamaR), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

printQuest :-
	write('-------------- \33\[38;5;202mKamu harus mengumpulkan :\33\[0m -------------- '),
	questList(X),
	traversePrintQuest(X),!.
	
traverseValueQuest([],0) :- !.	
traverseValueQuest([[ID,N]|T],Sum) :-
	crops(ID,_,U,Nama,_,_),
	\+fishItem(ID,UF,NamaF),
	\+ranchProduct(ID,_,UR,NamaR,_,_,_),
	getHarvestExpGold(ID,EXP,GOLD),
	GOLDC is GOLD * N,
	traverseValueQuest(T,Sum1),
	Sum1 is Sum, !.

/* TODO : traverse untuk fish dan ranch, masih butuh getter untuk tiap produknya */

questValue(Sum) :-
	questList(X),
	traverseValueQuest(X,Sum), !.

takeItemFromInv :- 
	questList(X),
	traverseTakeItem(X),
	retract(questList(X)),
	assertz(questList([])),!.

traverseTakeItem([]) :- !.
traverseTakeItem([[ID,N|T]]) :-
	crops(ID,_,U,Nama,_,_),
	\+fishItem(ID,UF,NamaF),
	\+ranchProduct(ID,_,UR,NamaR,_,_,_),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).

traverseTakeItem([[ID,N|T]]) :-
	\+crops(ID,_,U,Nama,_,_),
	fishItem(ID,UF,NamaF),
	\+ranchProduct(ID,_,UR,NamaR,_,_,_),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).
	
traverseTakeItem([[ID,N|T]]) :-
	\+crops(ID,_,U,Nama,_,_),
	\+fishItem(ID,UF,NamaF),
	ranchProduct(ID,_,UR,NamaR,_,_,_),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).

/* TODO : takeQuest using randomizer? */

takeQuest.
submitQuest :-
	checkQuest,
	questList,
	takeItemFromInv,
	questValue(Sum).

/* TODO : get total gold from quest */

