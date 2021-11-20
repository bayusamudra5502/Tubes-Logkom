
% Command getter
getter :- runProgram(_),
        write('\33\[38;5;93mCommand: \33\[0m'), nl,
        write('\33\[38;5;31m    getRole.          \33\[0m: melihat role dari pemain'), nl,
        write('\33\[38;5;31m    getGold.          \33\[0m: melihat uang yang tersedia'), nl,
        write('\33\[38;5;31m    getExp.           \33\[0m: melihat exp total pada game'), nl,
        write('\33\[38;5;31m    getExpFarmer.     \33\[0m: melihat exp farmer'),nl,
        write('\33\[38;5;31m    getExpRancher.    \33\[0m: melihat exp rancher'),nl,
        write('\33\[38;5;31m    getExpFisher.     \33\[0m: melihat exp fisher'),nl,
        write('\33\[38;5;31m    getLevel.         \33\[0m: melihat level game saat ini'),nl,
        write('\33\[38;5;31m    getLevelFarmer.   \33\[0m: melihat level farmer saat ini'),nl,
        write('\33\[38;5;31m    getLevelRancher.  \33\[0m: melihat level rancher saat ini'),nl,
        write('\33\[38;5;31m    getLevelFisher.   \33\[0m: melihat level fisher saat ini'),nl,
        write('\33\[38;5;31m    getEnergi.        \33\[0m: melihat energi yang tersisa'),nl,
        write('\33\[38;5;31m    getLocation.      \33\[0m: melihat lokasi pemain saat ini'),nl,
        write('\33\[38;5;31m    getTime.          \33\[0m: melihat waktu pada game saat ini'),nl,
        write('\33\[38;5;31m    getDiary.         \33\[0m: melihat diary.'), nl,!.


% getter untuk role
getRole :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Role Anda pada game kali ini adalah sebagai '),write(A),write(','),nl,!.
        
% getter untuk gold
getGold :- runProgram(_),gold(Gold),
        write('Jumlah uang Anda saat ini adalah '),write(Gold),write(' G.'),nl,!.

% getter untuk exp
getExp :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(L),write('.'),nl,!.

% getter untuk exp farming
getExpFarmer :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(D),write('.'),nl,!.

% getter untuk exp ranching
getExpRancher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(G),write('.'),nl,!.

% getter untuk exp fishing
getExpFisher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(J),write('.'),nl,!.

% getter untuk level
getLevel :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level '),write(B),write('.'),nl,!.

% getter untuk level farming
getLevelFarmer :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level farming '),write(C),write('.'),nl,!.

% getter untuk level ranching
getLevelRancher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level ranching '),write(F),write('.'),nl,!.

% getter untuk level fishing
getLevelFisher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level fishing '),write(I),write('.'),nl,!.

% getter untuk energi
getEnergi :- runProgram(_),energi(Energi),
        write('Energi Anda yang tersisa saat ini adalah '),write(Energi),write('.'),nl,!.

% getter untuk location
getLocation :- runProgram(_),posisi(X,Y),\+isHouse(X,Y),\+isMarket(X,Y),\+isRanch(X,Y),\+isWater(X,Y),\+isBorder(X,Y),\+isQuest(X,Y),\+isAlchemist(X,Y),
        write('Posisi Anda saat ini adalah '),write(X),write(','),write(Y),write('.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isHouse(X,Y),
        write('Sekarang Anda berada di rumah.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isMarket(X,Y),
        write('Sekarang Anda berada di market.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isRanch(X,Y),
        write('Sekarang Anda berada di peternakan.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isQuest(X,Y),
        write('Sekarang Anda berada di quest.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isAlchemist(X,Y),
        write('Sekarang Anda berada di alchemist.'),nl,!.

getTime :- runProgram(_),time(A,B,C,D,E), 
        write('Kamu sekarang berkegiatan di '), write(A), write(' hari'),nl,
        write('Kamu sekarang berada di day '),write(B),write(', Season ke - '), write(C), write(', Musim '),write(D), write(', Tahun ke - '),write(E),!.

/*TODO: */
% getter diary -> setelah realisasi rumah selesai
% getter time dan fungsi timenya -> pikirin lagi caranya

/* Tambahin keteranngan klo dia sleep dg inSleep(_), untuk semua rules di bawah ini*/
periTidur :- runProgram(_),nama(Nama),
            write('********** Halo '),write(Nama), write(' Selamat datang di dunia mimpi **********'),nl,
            write('Aku adalah peri tidur yang akan membuatmu terbangun di posisi yang kamu inginkan'),nl,
            write('Berikut adalah tempat dan lokasi yang bisa kamu kunjungi:.......................'),nl,
            commandPeri,
            write('Selamat terbangun di tempat impian Anda, sampai jumpa di mimpi berikutnya :)))))'),nl,nl,!.

commandPeri :- runProgram(_),
             write('Silakan inputkan sesuai perintah'),nl,
             write('1. House'),nl,
             write('2. Market'),nl,
             write('3. Ranch'),nl,
             write('4. Quest'),nl,
             write('5. Alchemist'),nl,
             write('6. Lainnya'),nl,
             write('Insert number: '), read(X),
        (X =:= 1 -> housePosisi;
        X =:= 2 -> marketPosisi;
        X =:= 3 -> ranchPosisi;
        X =:= 4 -> questPosisi;
        X =:= 5 -> alchemistPosisi;
        X =:= 6 -> lainnya),!.

housePosisi :- runProgram(_),
                posisi(A,B),
                retract(posisi(A,B)),
                Anew is 16,
                Bnew is 4,
                asserta(posisi(Anew,Bnew)),
                /*asserta(inHouse(1)),*/
                write('--------------------- \33\[38;5;10mKamu sekarang berada di house \33\[0m----------------------'),nl,
                write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,!.

marketPosisi :- runProgram(_),
        posisi(A,B),
        retract(posisi(A,B)),
        Anew is 15,
        Bnew is 16,
        asserta(posisi(Anew,Bnew)),
        /*asserta(inMarket(1)),*/
        write('----------------- \33\[38;5;207mKamu sekarang berada di market \33\[0m---------------'),nl,
        write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,!.

ranchPosisi :- runProgram(_),
        posisi(A,B),
        retract(posisi(A,B)),
        Anew is 3,
        Bnew is 17,
        asserta(posisi(Anew,Bnew)),
        /*asserta(inRanch(1)),*/
        write('------------ \33\[38;5;10mKamu sekarang berada di ranch \33\[0m--------------'),nl,
        write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,!.

questPosisi :- runProgram(_),
        posisi(A,B),
        retract(posisi(A,B)),
        Anew is 8,
        Bnew is 7,
        asserta(posisi(Anew,Bnew)),
        /*asserta(inQuest(1)),*/
        write('------------------ \33\[38;5;10mKamu sekarang berada di quest \33\[0m-------------------'),nl,
        write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,!.

alchemistPosisi :- runProgram(_),
        posisi(A,B),
        retract(posisi(A,B)),
        Anew is 18,
        Bnew is 11,
        asserta(posisi(Anew,Bnew)),
         /*asserta(inAlchemist(1)),*/
        write('------------- \33\[38;5;10mKamu sekarang berada di alchemist \33\[0m------------'),nl,
        write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,!.

lainnya :- runProgram(_),posisi(A,B), 
            write('Silakan masukkan ke posisi mana Anda ingin pergi..............'),nl,
            write('Jika lokasi tidak dapat dikunjungi maka inputkan lagi X dan Y.'),nl,
            write('insert X: '), read(X),
            write('insert Y: '), read(Y),
            X<20,Y<20,
            \+isBorder(X,Y),
            \+isHouse(X,Y),
            \+isMarket(X,Y),
            \+isRanch(X,Y),
            \+isQuest(X,Y),
            \+isAlchemist(X,Y),
            \+isWater(X,Y),
            retract(posisi(A,B)),
            Anew is X,
            Bnew is Y,
            asserta(posisi(Anew,Bnew)),
            write('Sekarang Anda berada di koordinat '),write(Anew),write(','),write(Bnew),write('.'),nl,!.

% time(waktu,hari,season,musim,tahun)
initTime :- write('Halo '), nama(Username),write(Username), write(', sebelum bermain silakan aktifkan waktu'), nl,
            write('1. lanjutkan game dengan aktifkan waktu'),nl,
            write('Silakan masukkan angka 1 untuk melanjutkan'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(time('Siang',1,1,'Summer',1))).


/* implementasi gantiTime masi belom dicoba karena sleep belum diimplementasikan */
gantiTime :- runProgram(_),time(A,B,C,D,E), kegiatan(Jumlah), Jumlah >= 5, retract(time(A,B,C,D,E)),
                asserta(time("Malam",B,C,D,E)),!.

gantiTime :- runProgram(_),time(A,B,C,D,E), sleep(_),A is "Malam", kegiatan(Jumlah), Jumlah < 5,retract(time(A,B,C,D,E)),
                asserta(time("Siang",B+1,C,D,E)),!.

gantiTime :- runProgram(_),time(A,B,C,D,E), sleep(_),A is "Malam", kegiatan(Jumlah), Jumlah < 5,retract(time(A,B,C,D,E)),
                B > 30, Bnew is B mod 30, C is 1,
                asserta(time("Siang",Bnew,C+1,"Spring",E)),!.

gantiTime :- runProgram(_),time(A,B,C,D,E), sleep(_),A is "Malam", kegiatan(Jumlah), Jumlah < 5,retract(time(A,B,C,D,E)),
                B > 30, Bnew is B mod 30, C is 2,
                asserta(time("Siang",Bnew,C+1,"Fall",E)),!.

gantiTime :- runProgram(_),time(A,B,C,D,E), sleep(_),A is "Malam", kegiatan(Jumlah), Jumlah < 5,retract(time(A,B,C,D,E)),
                B > 30, Bnew is B mod 30, C is 3,
                asserta(time("Siang",Bnew,C+1,"Winter",E)),!.

gantiTime :- runProgram(_),time(A,B,C,D,E), sleep(_),A is "Malam", kegiatan(Jumlah), Jumlah < 5,retract(time(A,B,C,D,E)),
                C > 4, Cnew is C mod 4, 
                asserta(time("Siang",B+1,Cnew,"Summer",E+1)),!.

gantiTime :- !.

    


