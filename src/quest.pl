:- dynamic(inQuest/1).
:- dynamic(questList/1).
:- dynamic(onQuest/1).
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

questList([]).

isSufficient(ID, N) :-
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M >= N.

checkQuest :-
	questList(X),
	traverseQuest(X), 
	write('Quest sudah terpenuhi !'),nl,!.

traverseQuest([]) :- !.
traverseQuest([[ID,N]|T]) :- 
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	isSufficient(ID, N),
	traverseQuest(T).	

traversePrintQuest([]) :- !.
traversePrintQuest([[ID,N]|T]) :-
	crops(ID,_,U,Nama,_,_),
	write(ID),write('. '), write(Nama), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

traversePrintQuest([[ID,N]|T]) :-
	fishItem(ID,UF,NamaF),
	write(ID),write('. '), write(NamaF), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

traversePrintQuest([[ID,N]|T]) :-
	ranchProduct(ID,_,UR,NamaR,_,_,_,_),
	write(ID),write('. '), write(NamaR), write(' : '), write(N), write(' X'),nl,
	traversePrintQuest(T).

printQuest :-
	write('-------------- \33\[38;5;76mKamu harus mengumpulkan :\33\[0m -------------- '),nl,
	questList(X),
	traversePrintQuest(X),!.
	
traverseValueQuest([],0) :- !.	
traverseValueQuest([[ID,N]|T],Sum) :-
	crops(ID,_,U,Nama,_,_),
	getHarvestExpGold(ID,EXP,GOLD),
	GOLDC is GOLD * N,
	traverseValueQuest(T,Sum1),
	Sum is Sum1 + GOLDC, !.

traverseValueQuest([[ID,N]|T],Sum) :-
	fishItem(ID,UF,NamaF),
	getFishSellPrice(ID,GOLD),
	GOLDC is GOLD * N,
	traverseValueQuest(T,Sum1),
	Sum is Sum1 + GOLDC, !.

traverseValueQuest([[ID,N]|T],Sum) :-
	ranchProduct(ID,_,UR,NamaR,GOLD,_,_,_),
	GOLDC is GOLD * N,
	traverseValueQuest(T,Sum1),
	Sum is Sum1 + GOLDC, !.

/* TODO : traverse untuk fish dan ranch, masih butuh getter untuk tiap produknya */

questValue(Sum) :-
	questList(X),
	traverseValueQuest(X,G), 
	G1 is G * 0.2,
	Sum is G1 + G,!.

traverseTakeItem([]) :- !.
traverseTakeItem([[ID,N]|T]) :-
	crops(ID,_,U,Nama,_,_),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).

traverseTakeItem([[ID,N]|T]) :-
	fishItem(ID,UF,NamaF),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).
	
traverseTakeItem([[ID,N]|T]) :-
	ranchProduct(ID,_,UR,NamaR,_,_,_,_),
	inventory(CurrentInventory),
	is_member(ID,CurrentInventory,Index),
	select_nth(CurrentInventory,Index,[ID,M]),
	M1 is M - N,
	set_nth(CurrentInventory,Index,[ID,M1],NewInventory),
	retract(inventory(CurrentInventory)),
	assertz(inventory(NewInventory)),
	traverseTakeItem(T).

/* TODO : takeQuest using randomizer? */
takeItemFromInv :- 
	questList(X),
	traverseTakeItem(X),
	retract(questList(X)),
	assertz(questList([])),!.

onQuest(0).

takeQuest :- 
	onQuest(Y),
	Y =:= 0,
	questFarmRandomizer(A,B),
	questFishRandomizer(C,D),
	questRanchRandomizer(E,F),
	questList(List),
	insert_quest(A,B),
	insert_quest(C,D),
	insert_quest(E,F),
	printQuest,
	questValue(X), 
	Y1 is 1,
	asserta(onQuest(Y1)),
	retract(onQuest(Y)),
	write('\33\[38;5;207mReward : '),write(X),write(' Gold\33\[0m'),!.

takeQuest :- 
	onQuest(Y),
	Y =:= 1,
	write('-------------- \33\[38;5;202mKamu sudah mengambil Quest, selesaikan quest yang ada terlebih dahulu!\33\[0m --------------') ,!.	

submitQuest :-
	questList([]),
	write('-------------- \33\[38;5;202mKamu sedang tidak mengambil Quest ! \33\[0m --------------'),!.
	
submitQuest :-
	checkQuest,
	questValue(Sum),
	takeItemFromInv,
	gold(G1),
	G2 is G1 + Sum,
	onQuest(Y),
	Y1 is 0,
	write('-------------- \33\[38;5;76mSelamat, Kamu telah menyelesaikan quest ! \33\[0m --------------'),nl,
	write('-------------- \33\[38;5;220m + '),write(Sum),write(' Gold\33\[0m -------------- '),
	winState,
	loseState,
	asserta(onQuest(Y1)),
	retract(onQuest(Y)),
	asserta(gold(G2)),
	retract(gold(G1)),!.

submitQuest :-
	\+checkQuest,
	write('-------------- \33\[38;5;202mSyarat quest belum terpenuhi ! \33\[0m --------------'),!.

/* TODO : get total gold from quest */


% menambah item yang belum ada ke questlist
insert_quest(ID, Amount) :- questList(List), 
	\+is_member(ID,List,_),
    insert_last([ID,Amount],List,NList),
    assertz(questList(NList)),
    retract(questList(List)), !.

insert_quest(ID, Amount) :- questList(List), 
    is_member(ID,List,Index),
    select_nth(List, Index, [X,N]),
    N1 is N + Amount,
    set_nth(List, Index, [ID,N1], NewList),
    assertz(questList(NewList)),
    retract(questList(List)), !.