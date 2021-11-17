/* include file yang dibutuhkan untuk main */

:- dynamic(crops/5).
:- dynamic(soil/2).


/* Farming item */
% crop (ID,IDSeed, Unicode, nama, harga jual, exp gained)
crops(e1,e10, '🌾', 'Padi',60,10).
crops(e2,e11, '🥕', 'Wortel',150,20).
crops(e3,e12, '🥔', 'Kentang',200,60).
crops(e4,e13, '🍅', 'Tomat',90,10).
crops(e5,e14, '🧅', 'Bawang',170,30).
crops(e6,e15, '🌽', 'Jagung',300,80).
crops(e7,e16, '🥦', 'Brokoli',75,20).
crops(e8,e17, '🍆', 'Terong',175,40).
crops(e9,e18, '🌶️', 'Cabai',275,50).

% seed (IDSeed, Unicode, nama, waktu tumbuh,harga bibit, musim)
seed(e10, '🌱','Bibit Padi',3,30,1).
seed(e18, '🌱','Bibit Wortel',5,80,1).
seed(e11, '🌱','Bibit Kentang',7,120,1).
seed(e12, '🌱','Bibit Tomat',4,45,2).
seed(e13, '🌱','Bibit Bawang',6,80,2).
seed(e14, '🌱','Bibit Jagung',10,150,2).
seed(e15, '🌱','Bibit Brokoli',4,40,3).
seed(e16, '🌱','Bibit Terong',6,90,3).
seed(e17, '🌱','Bibit Cabai',8,150,3).

/* blm kelar */

isSeed(X) :- X is e10;X is e11;X is e12;X is e12;X is e13;X is e14;X is e15;X is e16;X is e17;X is e18.

isSoilTile(X,Y) :- soilTile(X,Y).
isSeedTile(X,Y) :- seedTile(X,Y).
isPlantTile(X,Y) :- plantTile(X,Y).

isSeedExist([]).
isSeedExist([Item,Amount]) :- isSeed(Item), write(seed(Item,_,_,_,_,_), write(Amount),nl).
printSeed :- inventory([Head|Tail], _), isSeedExist(Head), printSeed(Tail).

plant :- runProgram(_),
    posisi(X,Y),
    isSoilTile(X,Y),
    write('Kamu punya :'),nl,
    printSeed,nl,
    write('Apa yang ingin ditanam :').


dig :- runProgram(_),
    posisi(X,Y),
    cekArea(X,Y),
    asserta(soilTile(X,Y)), w,!.
