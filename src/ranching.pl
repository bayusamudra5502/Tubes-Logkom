wr/* Ranching */
:- dynamic(inRanch/1).
:- dynamic(ranchCountDays/1).
:- dynamic(ranchAll/1).
:- dynamic(ranchItem/8).
:- dynamic(ranchProduct/8).

/*Facts*/
/*Product Ranching*/
/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu,jumlah sekarang */
ranchProduct(r1, r4, '🥚', 'Telur', 50, 10, 3, 0).
ranchProduct(r2, r5, '🧶', 'Wool', 100, 20, 4, 0).
ranchProduct(r3, r6, '🥛', 'Susu', 200, 40, 5, 0).

/*Animals*/
/*ID Animals, Icon, Nama, harga, waktu untuk harvest*/
ranchAnimals(r4, '🐔', 'Ayam', 500).
ranchAnimals(r5, '🐑', 'Domba', 1000).
ranchAnimals(r6, '🐄', 'Sapi', 1500).

/* Util */
/*ID Hewan, ID Item, icon, nama, price, level, exp, base exp*/
ranchItem(r4, r7, '📦', 'Crate', 300, 1, 5, 100).
ranchItem(r5, r8, '✂️', 'Sheer', 600, 1, 5, 150).
ranchItem(r6, r9, '🪣', 'Bucket', 800, 1, 5, 200).

/* ranch masih belum sampai */
ranch :-
	runProgram(_),
	\+inRanch(_),nl,
	write('Kamu masih terlalu jauh dari ranch.'),
	!.

/* pemain sudah di ranch */

/* ini diubah lagi ya sesuai menu yang sebenarnya ini cuman dummy ajaa biar program lain jalan hehehehe*/
ranch :-
	runProgram(_),
	inRanch(_),
	nl,nl,
	write('####################  Ranch  ####################'),nl,
    write('#                                               #'),nl,
    write('# Welcome to the ranch!                         #'),nl,
    write('#                                               #'),nl,
    write('# 1. Memasukkan semua binatang di inventory     #'),nl,
    write('#    ke ranch                                   #'),nl,
    write('# 2. Mengambil produk dari hewan                #'),nl,
    write('# 3. Exit                                       #'),nl,
    write('#                                               #'),nl,
	write('# Apa yang ingin Kamu lakukan?                  #'),nl,
	write('#                                               #'),nl,
	write('#################################################'),nl,nl,
	write('Masukkan angka : '),read(X),
        (X =:= 1 -> moved;
		X =:= 2 -> take;
        X =:= 3 -> s,nl,write('Kamu telah berada di luar ranch')),!.

% ranchCountDays([ID, Amount, Days])
ranchCountDays([]).
ranchAll([]).

insertCountDays(ID, Amount, Days) :- 
	ranchCountDays(Ranch),
	insert_last([ID, Amount, Days], Ranch, NewRanch),
	assertz(ranchCountDays(NewRanch)),
	retract(ranchCountDays(Ranch)), !.
insertAll(ID, Amount) :-
	ranchAll(CurRanch),
	\+is_member(ID, CurRanch, _),
	insert_last([ID, Amount], CurRanch, NewCur),
	assertz(ranchAll(NewCur)),
	retract(ranchAll(CurRanch)), !.
insertAll(ID, Amount) :-
	ranchAll(CurRanch),
	is_member(ID, CurRanch, Index),
	select_nth(CurRanch, Index, [X,N]),
	N1 is N+Amount,
	set_nth(CurRanch, Index, [ID, N1], NewRanch),
	assertz(ranchAll(NewRanch)),
	retract(ranchAll(CurRanch)), !.

printRanch([]) :- !.

printRanch([[ID, Amount]|T]) :-
	ranchAnimals(ID, UCode, Nama, _),
	format('~w. ~w ~w ~w', [ID, Amount, UCode, Nama]), nl,
	printRanch(T).

takeHewan(Kode) :-
	\+ranchAnimals(Kode, _, _, _),
	write('Itu bukan kode hewan :('), !.

takeHewan(Kode) :-
	ranchAll(Ranch),
	ranchAnimals(Kode, _, _, _),
	\+is_member(Kode, Ranch, _),
	write('Kamu tidak memiliki hewan itu!'), !.

takeHewan(r4) :-
	inventory(CurrentInventory),
	ranchAll(Ranch),
	is_member(r4, Ranch, _),
	\+is_member(r7, CurrentInventory, _),
	write('Kamu tidak memiliki crate silahkan beli dulu!'), nl, !.

takeHewan(r5) :-
	inventory(CurrentInventory),
	ranchAll(Ranch),
	is_member(r5, Ranch, _),
	\+is_member(r8, CurrentInventory, _),
	write('Kamu tidak memiliki sheer, silahkan beli dulu!'), nl, !.

takeHewan(r6) :-
	inventory(CurrentInventory),
	ranchAll(Ranch),
	is_member(r6, Ranch, _),
	\+is_member(r9, CurrentInventory, _),
	write('Kamu tidak memiliki bucket, silahkan beli dulu!'), nl, !.

%%% Masih belum bisa iterasi buat cek yg mana yg bisa diambil
takeHewan(ID) :-
	inventory(CurrentInventory),
	ranchCountDays(Ranch),
	/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu,jumlah sekarang */
	ranchProduct(IDP,ID,_,Nama,_,EXP,_,Countz),
	/*ID Hewan, ID Item, icon, nama, price, level, exp, base exp*/
	ranchItem(ID, IDI, _, _, _, _, IExp, _),
	is_member(ID, Ranch, _),
	is_member(ID, CurrentInventory, _),
	checkRanch(Ranch, 0, ID, NewRanch),
	asserta(ranchCountDays(NewRanch)),
	retract(ranchcountDays(Ranch)),
	format('Kamu berhasil mendapatkan ~w ~w!', [Countz, Nama]),
	insert_item([IDP, Countz]),
	kegiatan(K), K1 is K+1,
	energi(E), E1 is E-1,
	player('Rancher',_,_,_,_,_,_,_,_,R,_,E,_),
	R1 is R+(EXP+10)*Countz,
	E1 is E+((EXP+10)/2)*Countz,
	NIExp is IExp + 10,
	format('Kamu mendapatkan ~w Exp untuk Ranching dan ~w Exp!', [R1-R, E1-E]),
	asserta(player(_, _, _, _, _, _, _, _, _, R1, _, E1, _)),
	asserta(kegitan(K1)),
	asserta(energi(E1)),
	/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu,jumlah sekarang */
	asserta(ranchProduct(IDP,ID,_,Nama,_,_,_,0)),
	/*ID Hewan, ID Item, icon, nama, price, level, exp, base exp*/
	asserta(ranchItem(IDI, ID, _, _, _, _, NIExp, _)),
	levelUp,
	levelUpItem(ID),
	retract(ranchProduct(IDP,ID,_,Nama,_,_,_,Countz)),
	retract(kegiatan(K)),
	retract(energi(E)),
	asserta(ranchItem(IDI, ID, _, _, _, _, IExp, _)),
	retract(player(_,_,_,_,_,_,_,_,_,_,_,_R,_,E,_)), !.

takeHewan(ID) :-
	inventory(CurrentInventory),
	ranchCountDays(Ranch),
	ranchProduct(IDP,ID,_,Nama,_,EXP,_,Countz),
	ranchItem(ID, IDI, _, _, _, _, IExp, _),
	is_member(ID, Ranch, _),
	is_member(IDP, CurrentInventory, _),
	checkRanch(Ranch, 0, ID, NewRanch),
	asserta(ranchCountDays(NewRanch)),
	retract(ranchcountDays(Ranch)),
	format('Kamu berhasil mendapatkan ~w ~w!', [Countz, Nama]),
	insert_item([IDP, Countz]),
	kegiatan(K), K1 is K+1,
	energi(E), E1 is E-1,
	player(_,_,_,_,_,_,_,_,_,R,_,E,_),
	R1 is R+(EXP)*Countz,
	E1 is E+((EXP)/2)*Countz,
	format('Kamu mendapatkan ~w Exp untuk Ranching dan ~w Exp!', [R1-R, E1-E]),
	asserta(player(_, _, _, _, _, _, _, _, _, R1, _, E1, _)),
	asserta(kegitan(K1)),
	asserta(energi(E1)),
	/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu,jumlah sekarang */
	asserta(ranchProduct(IDP,ID,_,Nama,_,_,_,0)),
	levelUp,
	levelUpItem(ID),
	retract(ranchProduct(IDP,ID,_,Nama,_,_,_,Countz)),
	retract(kegiatan(K)),
	retract(energi(E)),
	retract(player(_,_,_,_,_,_,_,_,_,_,_,_R,_,E,_)), !.

% addItems(ID, Amount, Day)
addItems(r4, Amount, C) :-
	C > 0,
	/*ID Hewan, ID Item, icon, nama, price, level, exp, base exp*/
	ranchItem(r4,r7, _,_,_,L,_,_),
	ranchProduct(R1,r4,R2,R3,R4,R5,R6,A),
	NewA is (Amount*(3+L)+A),
	asserta(ranchProduct(R1,r4,R2,R3,R4,R5,R6,NewA)),
	retract(ranchProduct(R1,r4,R2,R3,R4,R5,R6,A)).
addItems(r5, Amount, C) :-
	C > 0,
	New is Today,
	ranchItem(r5,r8, _,_,_,L,_,_),
	ranchProduct(R1,r5,R2,R3,R4,R5,R6,A),
	NewA is (Amount*(3+L)+A),
	asserta(ranchProduct(R1,r5,R2,R3,R4,R5,R6,NewA)),
	retract(ranchProduct(R1,r5,R2,R3,R4,R5,R6,A)).
addItems(r6, Amount, C) :-
	C > 0,
	New is Today,
	ranchItem(r6,r9, _, _, _, L, _, _),
	ranchProduct(R1,r6,R2,R3,R4,R5,R6,A),
	NewA is (Amount*(3+L)+A),
	asserta(ranchProduct(R1,r6,R2,R3,R4,R5,R6,NewA)),
	retract(ranchProduct(R1,r6,R2,R3,R4,R5,R6,A)).
addItems(_, Amount, C) :-
	!.

% checkRanch(List, Kode, Result)
checkRanch([], _, []) :- !.

checkRanch([[ID, Amount, Days]|T], ID, ListBaru) :-
	time(_,D,S,_,Y),
	ranchProduct(_,ID,_,_,_,_,CD,_),
	Today is ((S-1)*30+D+120*(Y-1)),
	C is (Today-Days) div CD,
	write(C),
	addItems(ID, Amount, C, Today, Days, NewDays),
	NewHead = [ID, Amount, NewDays],
	checkRanch(T, ID, ListLast),
	ListBaru = [NewHead | ListLast], !.

checkRanch([H|T], ID, ListBaru) :-
	checkRanch(T, ID, ListLama),
	ListBaru = [H|ListLama].

take:-
	ranchAll(Ranch),
	is_empty(Ranch),
	write('Kamu belum memiliki hewan! Beli dulu di store!'), !.

take :-
	ranchAll(Ranch),
	\+is_empty(Ranch),
	write('Kamu memiliki : '), nl,
	printRanch(Ranch),
	write('Ketik kode hewan yang akan diambil produknya : '), read(Kode),
	takeHewan(Kode).

% Memasukan Hewan
insertChicken(Amount) :- 
	inventory(CurrentInventory),
	is_member(r4, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Amount),
	time(_,Day,Season,_,_),
	Days is (Season-1)*30+Day,
	insertCountDays(r4, Amount, Days),
	insertAll(r4, Amount),
	set_nth(CurrentInventory, Idx, [r4, 0], NewCurrent),
	retract(inventory(CurrentInventory)),
	asserta(inventory(NewCurrent)), !.

insertSheep(Amount) :-
	inventory(CurrentInventory),
	is_member(r5, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Amount),
	time(_,Day,Season,_,_),
	Days is (Season-1)*30+Day,
	insertCountDays(r5, Amount, Days),
	insertAll(r5, Amount),
	set_nth(CurrentInventory, Idx, [r5, 0], NewCurrent),
	retract(inventory(CurrentInventory)),
	asserta(inventory(NewCurrent)), !.

insertCow(Amount) :-
	inventory(CurrentInventory),
	is_member(r6, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Amount),
	time(_,Day,Season,_,_),
	Days is (Season-1)*30+Day,
	insertCountDays(r6, Amount, Days),
	insertAll(r6, Amount),
	set_nth(CurrentInventory, Idx, [r6, 0], NewCurrent),
	retract(inventory(CurrentInventory)),
	asserta(inventory(NewCurrent)), !.

% Move hewan ke 
moved :-
	inventory(CurrentInventory),
	is_member(r4, CurrentInventory, _),
	\+is_member(r5, CurrentInventory, _),
	\+is_member(r6, CurrentInventory, _),
	insertChicken(Amount),
	!, 
	format('Berhasil menambahkan ~w Ayam ke dalam Ranch!', [Amount]), nl.

moved :-
	inventory(CurrentInventory),
	\+is_member(r4, CurrentInventory, _),
	is_member(r5, CurrentInventory, Idx),
	\+is_member(r6, CurrentInventory, _),
	insertSheep(Amount),
	!, 
	format('Berhasil menambahkan ~w Domba ke dalam Ranch!', [Amount]), nl.
	
moved :-
	inventory(CurrentInventory),
	\+is_member(r4, CurrentInventory, _),
	\+is_member(r5, CurrentInventory, _),
	is_member(r6, CurrentInventory, Idx),
	insertCow(Amount),
	!, 
	format('Berhasil menambahkan ~w Sapi ke dalam Ranch!', [Amount]), nl.

moved :-
	inventory(CurrentInventory),
	is_member(r4, CurrentInventory, _),
	is_member(r5, CurrentInventory, _),
	\+is_member(r6, CurrentInventory, Idx),
	insertChicken(AmountChicken),
	insertSheep(AmountSheep),
	!, 
	format('Berhasil menambahkan ~w Ayam dan ~w Domba ke dalam Ranch!', [AmountChicken, AmountSheep]), nl.
moved :-
	inventory(CurrentInventory),
	is_member(r4, CurrentInventory, _),
	\+is_member(r5, CurrentInventory, _),
	is_member(r6, CurrentInventory, Idx),
	insertChicken(AmountChicken),
	insertCow(AmountCow),
	!, 
	format('Berhasil menambahkan ~w Ayam dan ~w Sapi ke dalam Ranch!', [AmountChicken, AmountCow]), nl.

moved :-
	inventory(CurrentInventory),
	\+is_member(r4, CurrentInventory, _),
	is_member(r5, CurrentInventory, _),
	is_member(r6, CurrentInventory, Idx),
	insertCow(AmountCow),
	insertSheep(AmountSheep),
	!, 
	format('Berhasil menambahkan ~w Domba dan ~w Sapi ke dalam Ranch!', [AmountSheep, AmountCow]), nl.

moved :-
	inventory(CurrentInventory),
	is_member(r4, CurrentInventory, _),
	is_member(r5, CurrentInventory, _),
	is_member(r6, CurrentInventory, Idx),
	insertChicken(AmountChicken),
	insertSheep(AmountSheep),
	insertCow(AmountCow),
	!, 
	format('Berhasil menambahkan ~w Ayam, ~w Domba, dan ~w Sapi ke dalam Ranch!', [AmountChicken, AmountSheep, AmountCow]), nl.

% Level Up
levelUpItem(ID) :- 
	ranchItem(ID,_,_,Nama,_, L, E, B),
	E >= B,
	Lnew is L+1,
	Enew is E-B,
	Bnew is B+100,
	retract(ranchItem(ID,_,_,_,_,L,E,B)),
	asserta(ranchItem(ID,_,_,_,_,Lnew,Enew,Bnew)),
	write(Nama), write(' level up! Sekarang level '), write(Lnew), nl.

levelUpItem(ID) :-
	ranchItem(ID,_,_,Nama,_, L, E, B),
	E < B, !.

ranch_product_list([r1,r2,r3]).

questRanchRandomizer(A,B) :- 
    ranch_product_list(X),
    random(0,3,Idx),
    select_nth(X,Idx,A),
    random(1,3,B), !.
