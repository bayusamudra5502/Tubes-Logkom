/* Ranching */
:- dynamic(ranchProduct/7).
:- dynamic(ranchAnimals/4).
:- dynamic(ranchItem/5).
:- dynamic(inRanch/1).
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
	write('##################  Ranch  ##################'),nl,
    	write('# Welcome to the ranch!                     #'),nl,
    	write('# 1. Sleep 🌙                               #'),nl,
    	write('# 2. WriteDiary 📚                          #'),nl,
    	write('# 3. ReadDiary 📚                           #'),nl,
    	write('# 4. Exit                                   #'),nl,
	write('# Apa yang ingin Kamu lakukan?              #'),nl,
	write('#                                           #'),nl,
	write('#############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
        (X =:= 1 -> write('sleep')
        ;X =:= 2 -> write('sleep');
        X =:= 3 -> write('sleep');
        X =:= 4 -> s,nl,write('Kamu telah berada di luar ranch')),!.

/*Facts*/
/*Product Ranching*/
/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu */
ranchProduct(r1, r4, '🥚', 'Telur', 50, 10, 3).
ranchProduct(r2, r5, '🧶', 'Wool', 100, 20, 4).
ranchProduct(r3, r6, '🥛', 'Susu', 200, 40, 5).

/*Animals*/
/*ID Animals, Icon, Nama, harga*/
ranchAnimals(r4, '🐔', 'Ayam', 500).
ranchAnimals(r5, '🐑', 'Domba', 1000).
ranchAnimals(r6, '🐄', 'Sapi', 1500).

/* Util */
/*ID Item, icon, nama, price, exp*/
ranchItem(r7, '📦', 'Crate', 300, 5).
ranchItem(r8, '✂️', 'Sheer', 600, 5).
ranchItem(r9, '🪣', 'Bucket', 800, 5).
