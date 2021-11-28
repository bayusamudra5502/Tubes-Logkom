
[main].
startGame.
1.
'Gilang'.
2.
1.
retract(posisi(_,_)).
asserta(posisi(15,16)).
asserta(inMarket(1)).
market.
---
[main].
startGame.
1.
'Udin'.
2.
1.
retract(posisi(_,_)).
asserta(posisi(2,2)).
insert_item(e10,2).
ranch.

--- Fish
[main].
quitGame.
startGame.
1.
'Udin'.
1.
1.
retract(posisi(_,_)).
asserta(posisi(9,9)).
insert_item(fu2,1).

-Nitip
[main].
startGame.
1.
'a'.
1.
1.
retract(posisi(_,_)).
asserta(posisi(3,17)).
insert_item(r4,2).
ranch.

--- Nitip hehe
harvest :- runProgram(_),
    posisi(X,Y),
    plantTile(X,Y,ID),
    crops(ID,_,U,Nama,_,_),
    inventory(CurrentInventory),
    \+is_member(i2,CurrentInventory,Index),!,
    insert_item(ID,1),
    getHarvestExpGold(ID,EXP,GOLD),
    kegiatan(K), K1 is K + 1,
    energi(E), E1 is E-1, 
    player(_,_,_,D,_,_,_,_,_,_,_,L,_),
    D1 is D + EXP,
    L1 is L + EXP,
    levelUp,
    write('-------------- \33\[38;5;76mKamu memanen : '), write(Nama), write(' '), write(U), write(' 1 X'),write('\33\[0m --------------'),nl,
    write('-------------- \33\[38;5;111m+\33\[0m '), write(EXP), write(' \33\[38;5;111mExp\33\[0m --------------'),nl,
    asserta(player(_,_,_,D1,_,_,_,_,_,_,_,L1,_)),
    asserta(kegiatan(K1)),
    asserta(energi(E1)),
    retract(kegiatan(K)),
    retract(energi(E)),
    retract(player(_,_,_,D,_,_,_,_,_,_,_,L,_)),
    retract(plantTile(X,Y,ID)),!.

harvest :- runProgram(_),
    posisi(X,Y),
    plantTile(X,Y,ID),
    crops(ID,_,U,Nama,_,_),!,
    inventory(CurrentInventory),
    is_member(i2,CurrentInventory,Index),!,
    tool(i2,_,_,_,LV,_,_),
    N is 1 + LV,
    insert_item(ID,N),
    getHarvestExpGold(ID,EXP,GOLD),
    kegiatan(K), K1 is K + 1,
    energi(E), E1 is E-1, 
    player(_,_,_,D,_,_,_,_,_,_,_,L,_),
    D1 is D + (EXP * N),
    L1 is L + (EXP * N),
    levelUp,
    NEXP is EXP * N,
    write('-------------- \33\[38;5;76mKamu memanen : '), write(Nama), write(' '), write(U),write(' '),write(N), write(' X'),write('\33\[0m --------------'),nl,
    write('-------------- \33\[38;5;111m+\33\[0m '), write(NEXP), write(' \33\[38;5;111mExp\33\[0m --------------'),nl,
    asserta(player(_,_,_,D1,_,_,_,_,_,_,_,L1,_)),
    asserta(kegiatan(K1)),
    asserta(energi(E1)),
    retract(kegiatan(K)),
    retract(energi(E)),
    retract(player(_,_,_,D,_,_,_,_,_,_,_,L,_)),
    retract(plantTile(X,Y,ID)),!.



getLevelFish(_Level),
fishItemRandomable(1, _List),
levelSum(_List, _Level, _Sum),
Upper is _Sum + 1,
random(0, Upper, Weight).

fishItemRandomable(1, _List),
levelSum(_List, 1, Sum).

insert_item(r4,3), insert_item(r5,2), insert_item(r7,1).
retract(time(A,B,C,D,E)), asserta(time(A,11,C,D,E)).
ranchCountDays(X), checkRanch(X, 0, r4, Y).




    (
        (
            is_member(Input,CurrentInventory,Index),
            seed(Input,U,Nama,W,H,M),
            time(_,_,Season,Musim,_),
            (
                (
                    Season =:= M,
                    select_nth(CurrentInventory,Index,[ID,N]),
                    N1 is N - 1,
                    set_nth(CurrentInventory,Index,[ID,N1],NewInventory),
                    write('-------------- \33\[38;5;76mKamu telah menanam : \33\[0m'),write(Nama),write(' --------------'),nl,
                    w,
                    kegiatan(K), K1 is K + 1,
                    energi(E), E1 is E-1, 
                    planted_list(PL),
                    insert_last([X,Y],PL,NewPL),
                    retract(planted_list(PL)),
                    retract(kegiatan(K)),
                    retract(soilTile(X,Y)),
                    retract(inventory(CurrentInventory)),
                    retract(energi(E)),
                    asserta(planted_list(NewPL)),
                    asserta(kegiatan(K1)),
                    asserta(energi(E1)),
                    assertz(inventory(NewInventory)),
                    assertz(seedTile(X,Y,Input,W))
                );
                (
                    Season =/= M,
                    write('-------------- \33\[38;5;202mKamu tidak bisa menanam '),write(Nama),write(' di Musim '),write(Musim),write(' \33\[0m--------------'),nl
                )
            )
            
        );
        (
            \+is_member(Input,CurrentInventory,Index),
            seed(Input,U,Nama,W,H,M),
            \+is_in_seed(Input,CurrentInventory,_),
            write('-------------- \33\[38;5;76mBibit tersebut tidak ada di inventory  : \33\[0m'),write(Nama),write(' --------------'),nl
        )
    )