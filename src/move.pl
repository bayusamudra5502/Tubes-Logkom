/* Final State -> Bergerak ke arah utara */
w :-
    (inAlchemist(_);
    inRanch(_);
    inQuest(_);
    inHouse(_);
    inMarket(_)),
    write('Kamu saat ini sedang ada di sebuah bangunan'),nl,
    write('Silahkan akses commandnya dan keluar dari bangunan tersebut'), !.

w :-
    runProgram(_),
    posisi(A,B),
    isWater(A,B-1),
    write('-------------- \33\[38;5;220mKamu memasuki air, ayo keluar \33\[0m--------------'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isBorder(A,B-1),
    write('---\33\[38;5;76mOow kamu nabrak dinding silahkan move ke tempat lain\33\[0m----'),nl,
    !.


w :-
    runProgram(_),
    posisi(A,B),
    isMarket(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    asserta(inMarket(1)),
    write('----------------- \33\[38;5;207mKamu sekarang berada di market \33\[0m---------------'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isHouse(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    asserta(inHouse(1)),
    write('--------------------- \33\[38;5;10mKamu sekarang berada di house \33\[0m----------------------'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isQuest(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    asserta(inQuest(1)),
    write('------------------ \33\[38;5;10mKamu sekarang berada di quest \33\[0m-------------------'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isRanch(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    asserta(inRanch(1)),
    write('------------ \33\[38;5;10mKamu sekarang berada di ranch \33\[0m--------------'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    asserta(inAlchemist(1)),
    write('------------- \33\[38;5;10mKamu sekarang berada di alchemist \33\[0m------------'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke utara. \33\[0m-------------'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

w :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke utara.\33\[0m -------------'),nl,
    !.

/* Final State -> Bergerak ke arah selatan */
s :-
    (inAlchemist(_);
    inRanch(_);
    inQuest(_);
    inHouse(_);
    inMarket(_)),
    write('Kamu saat ini sedang ada di sebuah bangunan'),nl,
    write('Silahkan akses commandnya dan keluar dari bangunan'), !.

s :-
    runProgram(_),
    posisi(A,B),
    isWater(A,B+1),
    write('-------------- \33\[38;5;220mKamu memasuki air, ayo keluar \33\[0m--------------'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isBorder(A,B+1),
    write('---\33\[38;5;76mOow kamu nabrak dinding silahkan move ke tempat lain\33\[0m----'),nl,
    !.


s :-
    runProgram(_),
    posisi(A,B),
    isMarket(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    asserta(inMarket(1)),
    write('----------------- \33\[38;5;207mKamu sekarang berada di market \33\[0m---------------'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isHouse(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    asserta(inHouse(1)),
    write('--------------------- \33\[38;5;10mKamu sekarang berada di house \33\[0m----------------------'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isQuest(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    asserta(inQuest(1)),
    write('------------------ \33\[38;5;10mKamu sekarang berada di quest \33\[0m-------------------'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isRanch(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    asserta(inRanch(1)),
    write('------------ \33\[38;5;10mKamu sekarang berada di ranch \33\[0m--------------'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    asserta(inAlchemist(1)),
    write('------------- \33\[38;5;10mKamu sekarang berada di alchemist \33\[0m------------'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke selatan.\33\[0m -------------'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

s :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke selatan.\33\[0m -------------'),nl,
    !.

/* Final State -> Bergerak ke arah timur */
d :-
    (inAlchemist(_);
    inRanch(_);
    inQuest(_);
    inHouse(_);
    inMarket(_)),
    write('Kamu saat ini sedang ada di sebuah bangunan'),nl,
    write('Silahkan akses commandnya dan keluar dari bangunan'), !.

d :-
    runProgram(_),
    posisi(A,B),
    isWater(A+1,B),
    write('-------------- \33\[38;5;220mKamu memasuki air, ayo keluar \33\[0m--------------'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isBorder(A+1,B),
    write('---\33\[38;5;76mOow kamu nabrak dinding silahkan move ke tempat lain\33\[0m----'),nl,
    !.


d :-
    runProgram(_),
    posisi(A,B),
    isMarket(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    asserta(inMarket(1)),
    write('----------------- \33\[38;5;207mKamu sekarang berada di market \33\[0m---------------'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isHouse(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    asserta(inHouse(1)),
    write('--------------------- \33\[38;5;10mKamu sekarang berada di house \33\[0m----------------------'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isQuest(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    asserta(inQuest(1)),
    write('------------------ \33\[38;5;10mKamu sekarang berada di quest \33\[0m-------------------'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isRanch(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    asserta(inRanch(1)),
    write('------------ \33\[38;5;10mKamu sekarang berada di ranch \33\[0m--------------'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    asserta(inAlchemist(1)),
    write('------------- \33\[38;5;10mKamu sekarang berada di alchemist \33\[0m------------'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke timur.\33\[0m -------------'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

d :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke timur.\33\[0m -------------'),nl,
    !.


/* Final State -> Bergerak ke arah barat */
a :-
    (inAlchemist(_);
    inRanch(_);
    inQuest(_);
    inHouse(_);
    inMarket(_)),
    write('Kamu saat ini sedang ada di sebuah bangunan'),nl,
    write('Silahkan akses commandnya dan keluar dari bangunan'), !.

a :-
    runProgram(_),
    posisi(A,B),
    isWater(A-1,B),
    write('-------------- \33\[38;5;220mKamu memasuki air, ayo keluar \33\[0m--------------'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isBorder(A-1,B),
    write('---\33\[38;5;76mOow kamu nabrak dinding silahkan move ke tempat lain\33\[0m----'),nl,
    !.


a :-
    runProgram(_),
    posisi(A,B),
    isMarket(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    asserta(inMarket(1)),
    write('----------------- \33\[38;5;207mKamu sekarang berada di market \33\[0m---------------'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isHouse(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    asserta(inHouse(1)),
    write('--------------------- \33\[38;5;10mKamu sekarang berada di house \33\[0m----------------------'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isQuest(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    asserta(inQuest(1)),
    write('------------------ \33\[38;5;10mKamu sekarang berada di quest \33\[0m-------------------'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isRanch(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    asserta(inRanch(1)),
    write('------------ \33\[38;5;10mKamu sekarang berada di ranch \33\[0m--------------'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    asserta(inAlchemist(1)),
    write('------------- \33\[38;5;10mKamu sekarang berada di alchemist \33\[0m------------'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke barat.\33\[0m -------------'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

a :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    write('------------- \33\[38;5;220mKamu berpindah 1 langkah ke barat.\33\[0m -------------'),nl,
    !.


/* Mengecek apakah posisi X,Y bukan area yang terisi dengan air, house, market, quest, border, ranch, alchemist */
cekArea(X,Y) :-
    \+isWater(X,Y),
    \+isRanch(X,Y),
    \+isHouse(X,Y),
    \+isMarket(X,Y),
    \+isQuest(X,Y),
    \+isBorder(X,Y),
    \+isAlchemist(X,Y).