/* include file yang dibutuhkan untuk main */

:- dynamic(crops/5).

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

/* Farming actions */
% list ID item seed
seed_list([e11,e12,e13,e14,e15,e16,e17,e18]).

% mengecek apakah kooordinat X,Y adalah tile soid/seed/plant

isSoilTile(X,Y) :- soilTile(X,Y).
isSeedTile(X,Y) :- seedTile(X,Y,_).
isPlantTile(X,Y) :- plantTile(X,Y,_).

% print semua seed yang ada di inventory

search_seed([]) :-!.
search_seed([Head|Tail]) :- inventory(CurrentInventory), 
    \+is_member(Head,CurrentInventory,Index),
    search_seed(Tail).

search_seed([Head|Tail]) :- inventory(CurrentInventory), 
    is_member(Head,CurrentInventory,Index),
    seed(ID,_,Nama,_,_,_),
    select_nth(CurrentInventory,Index,[ID,Amount]),
    write(ID),write('. '), write(Nama), write(' : '), write(Amount), write(' X'),nl,
    search_seed(Tail).

print_Seed :- seed_list(X),search_seed(X),!.

plant :- runProgram(_),
    posisi(X,Y),
    \+isSoilTile(X,Y),
    write('Tanah ini belum di gali! kamu harus menggalinya dulu dengan command dig'),nl,!.

plant :- runProgram(_),
    posisi(X,Y),
    isSoilTile(X,Y),
    inventory(CurrentInventory),
    write('Di Inventory Kamu punya :'),nl,
    print_Seed,nl,
    write('Apa yang ingin kamu tanam ? ( masukan id )'),nl,
    read(Input),
    is_member(Input,CurrentInventory,Index),
    seed(Input,U,Nama,W,H,M),
    write('Kamu telah menanam bibit '),write(Nama),nl,
    w,
    retract(soilTile(X,Y)),
    assertz(seedTile(X,Y,Input)),!.


plant :- runProgram(_),
    posisi(X,Y),
    isSoilTile(X,Y),
    inventory(CurrentInventory),
    write('Di Inventory Kamu punya :'),nl,
    print_Seed,nl,
    write('Apa yang ingin kamu tanam ? ( masukan id )'),
    read(Input),
    \+is_member(Input,CurrentInventory,Index),
    write('Item dengan id tersebut tidak ada di inventory !'),nl,!.




dig :- runProgram(_),
    posisi(X,Y),
    cekArea(X,Y),
    asserta(soilTile(X,Y)), w,!.
