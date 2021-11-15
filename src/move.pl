/* Final State -> Bergerak ke arah utara */
w :-
    runProgram(_),
    posisi(A,B),
    isWater(A,B-1),
    write('Kamu memasuki air, ayo keluar'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isBorder(A,B-1),
    write('Oow kamu nabrak dinding silahkan move ke tempat lain'),nl,
    !.


w :-
    runProgram(_),
    posisi(A,B),
    isMarket(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    /*asserta(inMarket(1)),*/
    write('Kamu sekarang berada di market'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isHouse(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    /*asserta(inHouse(1)),*/
    write('Kamu sekarang berada di house'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isQuest(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    /*asserta(inQuest(1)),*/
    write('Kamu sekarang berada di quest'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isRanch(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    /*asserta(inRanch(1)),*/
    write('Kamu sekarang berada di ranch'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A,B-1),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    /*asserta(inAlchemist(1)),*/
    write('Kamu sekarang berada di alchemist'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

w :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    write('Kamu berpindah 1 langkah ke utara.'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

w :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B-1,
    asserta(posisi(A,Bnew)),
    write('Kamu berpindah 1 langkah ke utara.'),nl,
    !.

/* Final State -> Bergerak ke arah selatan */
s :-
    runProgram(_),
    posisi(A,B),
    isWater(A,B+1),
    write('Kamu memasuki air, ayo keluar'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isBorder(A,B+1),
    write('Oow kamu nabrak dinding silahkan move ke tempat lain'),nl,
    !.


s :-
    runProgram(_),
    posisi(A,B),
    isMarket(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    /*asserta(inMarket(1)),*/
    write('Kamu sekarang berada di market'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isHouse(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    /*asserta(inHouse(1)),*/
    write('Kamu sekarang berada di house'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isQuest(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    /*asserta(inQuest(1)),*/
    write('Kamu sekarang berada di quest'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isRanch(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    /*asserta(inRanch(1)),*/
    write('Kamu sekarang berada di ranch'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A,B+1),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    /*asserta(inAlchemist(1)),*/
    write('Kamu sekarang berada di alchemist'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

s :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    write('Kamu berpindah 1 langkah ke selatan.'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

s :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Bnew is B+1,
    asserta(posisi(A,Bnew)),
    write('Kamu berpindah 1 langkah ke selatan.'),nl,
    !.

/* Final State -> Bergerak ke arah timur */
d :-
    runProgram(_),
    posisi(A,B),
    isWater(A+1,B),
    write('Kamu memasuki air, ayo keluar'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isBorder(A+1,B),
    write('Oow kamu nabrak dinding silahkan move ke tempat lain'),nl,
    !.


d :-
    runProgram(_),
    posisi(A,B),
    isMarket(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inMarket(1)),*/
    write('Kamu sekarang berada di market'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isHouse(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inHouse(1)),*/
    write('Kamu sekarang berada di house'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isQuest(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inQuest(1)),*/
    write('Kamu sekarang berada di quest'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isRanch(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inRanch(1)),*/
    write('Kamu sekarang berada di ranch'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inAlchemist(1)),*/
    write('Kamu sekarang berada di alchemist'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

d :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    write('Kamu berpindah 1 langkah ke timur.'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

d :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    write('Kamu berpindah 1 langkah ke timur.'),nl,
    !.


/* Final State -> Bergerak ke arah barat */
a :-
    runProgram(_),
    posisi(A,B),
    isWater(A-1,B),
    write('Kamu memasuki air, ayo keluar'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isBorder(A-1,B),
    write('Oow kamu nabrak dinding silahkan move ke tempat lain'),nl,
    !.


a :-
    runProgram(_),
    posisi(A,B),
    isMarket(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inMarket(1)),*/
    write('Kamu sekarang berada di market'),nl,
    write('Masukkan \'market.\' untuk melihat item dan melakukan pembelian.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isHouse(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    /*asserta(inHouse(1)),*/
    write('Kamu sekarang berada di house'),nl,
    write('Masukkan \'house.\' untuk melihat aktivitas yang dapat dilakukan di rumah.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isQuest(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inQuest(1)),*/
    write('Kamu sekarang berada di quest'),nl,
    write('Masukkan \'quest.\' untuk melihat hal yang dapat dilakukan di quest.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isRanch(A-1,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    /*asserta(inRanch(1)),*/
    write('Kamu sekarang berada di ranch'),nl,
    write('Masukkan \'ranch.\' untuk melihat kegiatan di peternakan.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    isAlchemist(A+1,B),
    retract(posisi(A,B)),
    Anew is A+1,
    asserta(posisi(Anew,B)),
    /*asserta(inAlchemist(1)),*/
    write('Kamu sekarang berada di alchemist'),nl,
    write('Masukkan \'alchemist.\' untuk melihat kegiatan di alchemist.'),nl,
    !.

a :-
    runProgram(_),
    posisi(A,B),
    \+cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    write('Kamu berpindah 1 langkah ke barat.'),nl,
    !.
    /* TODO: retracall semua yang memasuki rumah, market, ternak, dll*/

a :-
    runProgram(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    Anew is A-1,
    asserta(posisi(Anew,B)),
    write('Kamu berpindah 1 langkah ke barat.'),nl,
    !.


/* Mengecek apakah posisi X,Y bukan area yang terisi dengan air, house, market, quest, border, ranch, alchemist */
cekArea(X,Y) :-
    \+isWater(X,Y),
    \+isRanch(X,Y),
    \+isHouse(X,Y),
    \+isMarket(X,Y),
    \+isQuest(X,Y),
    \+isBorder(X,Y).
    \+isAlchemist(X,Y).