/* include file yang dibutuhkan untuk main */

:- dynamic(crops/5).

/* Farming item for Non-Farmer Speciality*/

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
seed(e11, '🌱','Bibit Wortel',5,80,1).
seed(e12, '🌱','Bibit Kentang',7,120,1).
seed(e13, '🌱','Bibit Tomat',4,45,2).
seed(e14, '🌱','Bibit Bawang',6,80,2).
seed(e15, '🌱','Bibit Jagung',10,150,2).
seed(e16, '🌱','Bibit Brokoli',4,40,3).
seed(e17, '🌱','Bibit Terong',6,90,3).
seed(e18, '🌱','Bibit Cabai',8,150,3).

/* Farming item exp and selling price info */
getHarvestExpGold(ID, EXP, GOLD) :- crops(ID,_,_,_,G,E),
    player('Fisherman',L,_,_,_,_,_,_,_,_,_,_,_),
    EXP is E + 5 * L,
    GOLD is G + 5 * L,!.

getHarvestExpGold(ID, EXP, GOLD) :- crops(ID,_,_,_,G,E),
    player('Rancher',L,_,_,_,_,_,_,_,_,_,_,_),
    EXP is E + 5 * L,
    GOLD is G + 5 * L,!.

getHarvestExpGold(ID, EXP, GOLD) :- crops(ID,_,_,_,G,E),
    player('Farmer',L,FL,_,_,_,_,_,_,_,_,_,_),
    EXP is E + 5 * (L+FL),
    GOLD is G + 5 * (L+FL),!.

/* Farming actions */
% list ID item seed
seed_list([e10,e11,e12,e13,e14,e15,e16,e17,e18]).

% mengecek apakah kooordinat X,Y adalah tile soid/seed/plant
% soilTile(X, Y)
% seedTile(X, Y, IDSeed,  Time remaining to harvest)
% plantTile(X, Y, IDSeed)

isSoilTile(X,Y) :- soilTile(X,Y).
isSeedTile(X,Y) :- seedTile(X,Y,_,_).
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
    is_empty(CurrentInventory),
    write('Kamu tidak punya bibit di inventory !'),nl,!.
    
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
    select_nth(CurrentInventory,Index,[ID,N]),
    N1 is N - 1,
    set_nth(CurrentInventory,Index,[ID,N1],NewInventory),
    write('Kamu telah menanam bibit '),write(Nama),nl,
    w,
    kegiatan(K), K1 is K + 1,
    energi(E), E1 is E-1, 
    retract(kegiatan(K)),
    retract(soilTile(X,Y)),
    retract(inventory(CurrentInventory)),
    retract(energi(E)),
    asserta(kegiatan(K1)),
    asserta(energi(E1)),
    assertz(inventory(NewInventory)),
    assertz(seedTile(X,Y,Input,W)),!.


dig :- runProgram(_),
    posisi(X,Y),
    cekArea(X,Y),
    asserta(soilTile(X,Y)), w,!.

harvest :- runProgram(_),
    posisi(X,Y),
    plantTile(X,Y,ID),
    crops(ID,_,U,Nama,_,_),
    insert_item(ID,1),
    getHarvestExpGold(ID,EXP,GOLD),
    kegiatan(K), K1 is K + 1,
    energi(E), E1 is E-1, 
    player(_,_,_,D,_,_,_,_,_,_,_,L,_),
    gold(G),
    D1 is D + EXP,
    L1 is L + EXP,
    G1 is G + GOLD,
    levelUp,
    write('Kamu memanen : '), write(Nama), write(' '), write(U), write(' 1 X'),nl,
    write('+ '), write(GOLD), write(' Gold'),nl,
    write('+ '), write(EXP), write(' Exp'),nl,
    asserta(player(_,_,_,D1,_,_,_,_,_,_,_,L1,_)),
    asserta(gold(G1)),
    asserta(kegiatan(K1)),
    asserta(energi(E1)),
    retract(kegiatan(K)),
    retract(energi(E)),
    retract(player(_,_,_,D,_,_,_,_,_,_,_,L,_)),
    retract(gold(G)),
    retract(plantTile(X,Y,ID)),!.


/* Update waktu sisa seed sampai siap panen */
/* dipake di ganti time */

update_seed_tile([]) :- !.

update_seed_tile([Head|Tail]) :- 
    \+seedTile(X,Y,Head,W),
    update_seed_tile(Tail).

update_seed_tile([Head|Tail]) :- 
    seedTile(X,Y,Head,W),
    W > 1,
    W1 is W - 1,
    asserta(seedTile(X,Y,Head,W1)),
    retract(seedTile(X,Y,Head,W)),
    update_seed_tile(Tail).

update_seed_tile([Head|Tail]) :- 
    seedTile(X,Y,Head,W),
    W = 1,
    crops(ID,Head,_,_,_,_),
    asserta(plantTile(X,Y,ID)),
    retract(seedTile(X,Y,Head,W)),
    update_seed_tile(Tail).

updateSeed :-
    seed_list(X),
    update_seed_tile(X), !.

