
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
'Gilang'.
3.
1.
retract(posisi(_,_)).
asserta(posisi(2,2)).
market.


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



