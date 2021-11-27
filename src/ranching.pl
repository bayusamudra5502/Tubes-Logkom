/* Ranching */
:- dynamic(inRanch/1).
:- dynamic(ranch/1).

/*Facts*/
/*Product Ranching*/
/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu */
ranchProduct(r1, r4, '🥚', 'Telur', 50, 10, 3).
ranchProduct(r2, r5, '🧶', 'Wool', 100, 20, 4).
ranchProduct(r3, r6, '🥛', 'Susu', 200, 40, 5).

/*Animals*/
/*ID Animals, Icon, Nama, harga, waktu untuk harvest*/
ranchAnimals(r4, '🐔', 'Ayam', 500).
ranchAnimals(r5, '🐑', 'Domba', 1000).
ranchAnimals(r6, '🐄', 'Sapi', 1500).

/* Util */
/*ID Item, icon, nama, price, exp*/
ranchItem(r7, '📦', 'Crate', 300, 5).
ranchItem(r8, '✂️', 'Sheer', 600, 5).
ranchItem(r9, '🪣', 'Bucket', 800, 5).

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

ranchAll([]).
% isThere(ID, Days, List, Index)
headRanch([H|_], H).
isThere(ID, D,[H|_], 0) :- headRanch(H, ID).

insert_ranch(ID, Amount, Days) :-
	ranchAll(Ranch).


printRanch([]) :- !.

printRanch([[ID, Amount]|T]) :-
	ranchAnimals(ID, UCode, Nama, _),
	format('~w. ~w ~w ~w', [ID, Amount, UCode, Nama]), nl,
	printRanch([T]).

takeHewan(Kode) :-
	\+ranchAnimals(Kode, _, _, _),
	write('Itu bukan kode hewan :(').

takeHewan(Kode) :-
	ranch(Ranch),
	ranchAnimals(Kode, _, _, _),
	\+isThere(Kode, Ranch, _),
	write('Kamu tidak memiliki hewan itu!').

takeHewan(r4) :-
	ranch(Ranch),
	isThere(r4, Ranch, _),
	\+is_member(r7, CurrentInventory, _),
	write('Kamu tidak memiliki crate, silahkan beli dulu!'), nl.

takeHewan(r5) :-
	ranch(Ranch),
	isThere(r5, Ranch, _),
	\+is_member(r8, CurrentInventory, _),
	write('Kamu tidak memiliki sheer, silahkan beli dulu!'), nl.

takeHewan(r6) :-
	ranch(Ranch),
	isThere(r6, Ranch, _),
	\+is_member(r9, CurrentInventory, _),
	write('Kamu tidak memiliki bucket, silahkan beli dulu!'), nl.

takeHewan(r4) :-
	ranch(Ranch),
	isThere(r4, Ranch, _),
	is_member(r7, CurrentInventory, _).

take :-
	write('Kamu memiliki : '), nl,
	ranch(Ranch),
	printRanch(Ranch),
	write('Ketik kode hewan yang akan diambil produknya : '), read(Kode),
	takeHewan(Kode).
	
haveCrate :-
	inventory(CurrentInventory),
	is_member(r7, CurrentInventory,_), !.
haveSheer :-
	inventory(CurrentInventory),
	is_member(r8, CurrentInventory,_), !.
haveBucket :-
	inventory(CurrentInventory),
	is_member(r9, CurrentInventory,_), !.

moved :-
	\+is_member(r1, CurrentInventory, _),
	\+is_member(r2, CurrentInventory, _),
	\+is_member(r3, CurrentInventory, _),
	!, 
	write('Kamu tidak memiliki hewan apapun dalam inventory-mu :)'), nl.
moved :-
	is_member(r1, CurrentInventory, Idx),
	\+is_member(r2, CurrentInventory, _),
	\+is_member(r3, CurrentInventory, _),
	getItemAmount(Idx, CurrentInventory, Amount),
	time(_,Day,Season,_,_),
	!, 
	format('Berhasil menambahkan ~w Ayam ke dalam Ranch!', [Amount]), nl.
moved :-
	\+is_member(r1, CurrentInventory, _),
	is_member(r2, CurrentInventory, Idx),
	\+is_member(r3, CurrentInventory, _),
	getItemAmount(Idx, CurrentInventory, Amount),
	ranch(_, R2, _),
	R2new is R2 + Amount,
	asserta(ranch(_, R2new, _)),
	retract(ranch(_, R2, _)),
	!, 
	format('Berhasil menambahkan ~w Domba ke dalam Ranch!', [Amount]), nl.
moved :-
	\+is_member(r1, CurrentInventory, _),
	\+is_member(r2, CurrentInventory, _),
	is_member(r3, CurrentInventory, Idx),
	getItemAmount(Idx, CurrentInventory, Amount),
	ranch(_, _, R3),
	R3new is R3 + Amount,
	asserta(ranch(_, _, R3new)),
	retract(ranch(_, _, R3)),
	!, 
	format('Berhasil menambahkan ~w Sapi ke dalam Ranch!', [Amount]), nl.
moved :-
	is_member(r1, CurrentInventory, Idx),
	is_member(r2, CurrentInventory, Idx2),
	\+is_member(r3, CurrentInventory, _),
	getItemAmount(Idx, CurrentInventory, Amount),
	getItemAmount(Idx2, CurrentInventory, Amount2),
	ranch(R1, R2, _),
	R1new is R1 + Amount,
	R2new is R2 + Amount2,
	asserta(ranch(R1new, R2new, _)),
	retract(ranch(R1, R2, _)),
	!, 
	format('Berhasil menambahkan ~w Ayam dan ~w Domba ke dalam Ranch!', [Amount], [Amount2]), nl.
moved :-
	is_member(r1, CurrentInventory, Idx),
	\+is_member(r2, CurrentInventory, _),
	is_member(r3, CurrentInventory, Idx3),
	getItemAmount(Idx, CurrentInventory, Amount),
	getItemAmount(Idx3, CurrentInventory, Amount3),
	ranch(R1, _, R3),
	R1new is R1 + Amount,
	R3new is R3 + Amount3,
	asserta(ranch(R1new, _, R3new)),
	retract(ranch(R1, _, R3)),
	!, 
	format('Berhasil menambahkan ~w Ayam dan ~w Sapi ke dalam Ranch!', [Amount], [Amount3]), nl.
moved :-
	\+is_member(r1, CurrentInventory, _),
	is_member(r2, CurrentInventory, Idx),
	is_member(r3, CurrentInventory, Idx3),
	getItemAmount(Idx, CurrentInventory, Amount),
	getItemAmount(Idx3, CurrentInventory, Amount3),
	ranch(_, R2, R3),
	R2new is R2 + Amount,
	R3new is R3 + Amount3,
	asserta(ranch(_, R2new, R3new)),
	retract(ranch(_, R2, R3)),
	!, 
	format('Berhasil menambahkan ~w Domba dan ~w Sapi ke dalam Ranch!', [Amount], [Amount3]), nl.
moved :-
	is_member(r1, CurrentInventory, Idx),
	is_member(r2, CurrentInventory, Idx2),
	is_member(r3, CurrentInventory, Idx3),
	getItemAmount(Idx, CurrentInventory, Amount),
	getItemAmount(Idx2, CurrentInventory, Amount2),
	getItemAmount(Idx3, CurrentInventory, Amount3),
	ranch(R1, R2, R3),
	R1new is R1 + Amount,
	R2new is R2 + Amount2,
	R3new is R3 + Amount3,
	asserta(ranch(R1new, R2new, R3new)),
	retract(ranch(R1, R2, R3)),
	!, 
	format('Berhasil menambahkan ~w Ayam, ~w Domba, ~w Sapi ke dalam Ranch!', [Amount], [Amount2], [Amount3]), nl.
	
ranch_product_list([r1,r2,r3]).

questRanchRandomizer(A,B) :- 
    ranch_product_list(X),
    random(0,3,Idx),
    select_nth(X,Idx,A),
    random(1,3,B), !.
