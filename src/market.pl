:- dynamic(inMarket/1).

/* market masih belum sampai */
market :-
	runProgram(_),
	\+inMarket(_),nl,
	write('Kamu masih terlalu jauh dari market.'),
	!.

/* pemain sudah di market */
market :-
	runProgram(_),
	inMarket(_),
	nl,nl,
	write('##################  Market  ##################'),nl,
    write('# 1. Buy                                     #'),nl,
    write('# 2. Sell                                    #'),nl,
    write('# 3. Exit                                    #'),nl,
	write('# Apa yang ingin Kamu lakukan?               #'),nl,
	write('#                                            #'),nl,
	write('##############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
        (X =:= 1 -> buy;
		X =:= 2 -> sell;
        X =:= 3 -> s,nl,write('Kamu telah berada di luar market')),!.

buyItem(1) :- 
	market.

buyItem(Pil) :-
	inventory(CurrentInventory),
	is_member(Pil, CurrentInventory, _),
	equipments(Pil, _, _, _, _),
	write('Kamu sudah memiliki equipment itu! Silakan beli yang lain :D'), nl.
buyItem(Pil) :- 
		sold(Pil,Ucode,Nama,Harga,_),
			write('Berapa banyak?  : '),
			read(Count),
			gold(Uang),
			Totalharga is Harga*Count,
			(
				(
					Uang < Totalharga, !, nl,
					write('Kamu tidak memiliki uang yang cukup untuk membeli ini :( '), nl,
					write('Hasilkan lebih banyak uang lalu kembali lagi kesini!'), nl
				);
				(
					Baru is Uang - Totalharga,
					retractall(gold(_)),
					asserta(gold(Baru)),
					write('Kamu telah berhasil membeli '), write(Count), write(' '), write(Nama), write(' Ditunggu pembelian selanjutnya!'), nl,
					insert_item(Pil, Count), !
				)
			), !.

buyItem(_) :- 
				nl,
				write('Kode yang kamu masukkan tidak ada!'), nl.
buy :-
		gold(Uang),
		write('##################  Market  ###################'),nl,
		write('#                                             #'),nl,
		format('# Uang Tersedia: ~w                          #',[Uang]),nl,
		write('# i1. ⛏ Pick (10 G)                          #'),nl,
		write('# i2. 🚛 Harvester (2500 G)                   #'),nl,
    	write('# e10. 🌱 Bibit Padi (30 G)                   #'),nl,
    	write('# e11. 🌱 Bibit Wortel (80 G)                 #'),nl,
    	write('# e12. 🌱 Bibit Kentang (120 G)               #'),nl,
    	write('# e13. 🌱 Bibit Tomat (45 G)                  #'),nl,
    	write('# e14. 🌱 Bibit Bawang (80 G)                 #'),nl,
    	write('# e15. 🌱 Bibit Jagung (40 G)                 #'),nl,
    	write('# e16. 🌱 Bibit Brokoli (40 G)                #'),nl,
    	write('# e17. 🌱 Bibit Terong (90 G)                 #'),nl,
    	write('# e18. 🌱 Bibit Cabai (150 G)                 #'),nl,
    	write('# fu1. 🎣 Normal Fishing Rod (100 G)          #'),nl,
    	write('# fu2. 🎣 Iron Fishing Rod (1000 G)           #'),nl,
    	write('# fu3. 🎣 Gold Fishing Rod (2500 G)           #'),nl,
    	write('# fu4. 🎣 Diamond Fishing Rod (4000 G)        #'),nl,
    	write('# r7. 📦 Crate (300 G)                        #'),nl,
    	write('# r8. ✂️ Sheer (600 G)                        #'),nl,
    	write('# r9. 🪣 Bucket (800 G)                       #'),nl,
    	write('# r4. 🐔 Chicken (500 G)                      #'),nl,
    	write('# r5. 🐑 Sheep (1000 G)                       #'),nl,
    	write('# r6. 🐄 Cow (1500 G)                         #'),nl,
    	write('# 1. Back                                      #'),nl,
		write('#                                              #'),nl,
		write('# Apa yang ingin Kamu beli ?                   #'),nl,
		write('#                                              #'),nl,
		write('##############################################'),nl,nl,
		write('Masukkan Kode (contoh : e10, e11) : '), nl,
		write('Ketik 1 untuk kembali'), nl,read(Pil),
		buyItem(Pil).

sellNambah(1) :-
	market.

sellNambah(Kode) :-
	\+is_member(Kode,CurrentInventory,_),
	write('Kamu tidak memiliki item itu!'), nl.

sellNambah(Kode) :-
	write('Masukkan jumlah yang mau dijual : '), read(Amount),
	sellLagi(Kode, Amount).

sellLagi(Kode, Amount) :-
	inventory(CurrentInventory),
	is_member(Kode, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Qty),
	Amount > Qty,
	item(Kode, _, Nama, _, _),
	format('Kamu hanya memiliki ~w ~w :(', [Qty, Nama]).

sellLagi(Kode, Amount) :-
	inventory(CurrentInventory),
	isFish(Kode),
	is_member(Kode, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Qty),
	Amount =< Qty,
	gold(UangSekarang),
	getFishSellPrice(Kode, Harga),
	SubTotal is Harga*Qty,
	Baru is UangSekarang + SubTotal,
	NewQty is Qty - Amount,
	winState,
	loseState,
	retractall(gold(_)),
	asserta(gold(Baru)),
	format('Kamu berhasil menjual ~w ~w seharga ~w Gold', [Amount, Nama, SubTotal]), nl,
	set_nth(CurrentInventory, Idx, [Kode,NewQty], NewInventory),
	assertz(inventory(NewInventory)),
	retract(inventory(CurrentInventory)), !.

sellLagi(Kode, Amount) :-
	inventory(CurrentInventory),
	is_member(Kode, CurrentInventory, Idx),
	getItemAmount(CurrentInventory, Idx, Qty),
	Amount =< Qty,
	gold(UangSekarang),
	item(Kode, _, Nama, _, Harga),
	SubTotal is Harga*Qty,
	Baru is UangSekarang + SubTotal,
	NewQty is Qty - Amount,
	retractall(gold(_)),
	asserta(gold(Baru)),
	winState,
	loseState,
	format('Kamu berhasil menjual ~w ~w seharga ~w Gold', [Amount, Nama, SubTotal]), nl,
	set_nth(CurrentInventory, Idx, [Kode,NewQty], NewInventory),
	assertz(inventory(NewInventory)),
	retract(inventory(CurrentInventory)), !.


sell :-
	inventory(CurrentInventory),
	write('Kamu memiliki item ini :'), nl,
	print_inventory(CurrentInventory),
	write('Ketik kode barang yang kamu mau jual (contoh : e1, e2, e3) : '), nl,
	write('Jika ingin kembali, ketik 1'), nl,
	read(Kode),
	sellNambah(Kode).


