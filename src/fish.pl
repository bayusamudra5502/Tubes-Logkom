/* Fishing */

:- dynamic(fishingExp/1).
:- dynamic(fishPrice/1).
:- dynamic(fishAlias/2).
:- dynamic(rodLevel/2).

/* Facts */
/* Item Ikan */
/* Struktur : Item, Icon, Nama*/
fishItem(f1, '📦', 'Junk').
fishItem(f2, '🐟', 'Ikan Mas').
fishItem(f3, '🐟', 'Ikan Tongkol').
fishItem(f4, '🐟', 'Ikan Lele').
fishItem(f5, '🐟', 'Ikan Nila').
fishItem(f6, '🐡', 'Ikan Badut').
fishItem(f7, '🐠', 'Ikan Hias').
fishItem(f8, '🐟', 'Ikan Tuna').
fishItem(f9, '🐟', 'Ikan Kakap').
fishItem(f10, '🐟', 'Ikan Salmon').
fishItem(f11, '🐟', 'Ikan Sarden').
fishItem(f12, '🐬', 'Ikan Lumba-Lumba').
fishItem(f13, '🦈', 'Ikan hiu').

/* Definisi Fish Item */
fishItem(fu1, '🎣', 'Normal Fishing Rod').
fishItem(fu2, '🎣', 'Iron Fishing Rod').
fishItem(fu3, '🎣', 'Gold Fishing Rod').
fishItem(fu4, '🎣', 'Diamond Fishing Rod').


/* Informasi bahwa item tersebut berjenis ikan */
isFish(f1).
isFish(f2).
isFish(f3).
isFish(f4).
isFish(f5).
isFish(f6).
isFish(f7).
isFish(f8).
isFish(f9).
isFish(f10).
isFish(f11).
isFish(f12).
isFish(f13).

/* Informaai Ikan */
/* Harga dasar ikan */
/* Struktur:  ID dan harga ikan */
fishPrice(f1, 0).
fishPrice(f2, 15).
fishPrice(f3, 20).
fishPrice(f4, 25).
fishPrice(f5, 20).
fishPrice(f6, 40).
fishPrice(f7, 100).
fishPrice(f8, 150).
fishPrice(f9, 160).
fishPrice(f10, 200).
fishPrice(f11, 210).
fishPrice(f12, 350).
fishPrice(f13, 350).

/* Harga fish Utiliy */
fishPrice(fu1, 50).
fishPrice(fu2, 1000).
fishPrice(fu3, 2500).
fishPrice(fu4, 4000).

/* Peluang Memancing */
fishProbability(f1, 50, 0).
fishProbability(f2, 80, 1).
fishProbability(f3, 70, 1).
fishProbability(f4, 65, 1).
fishProbability(f5, 70, 1).
fishProbability(f6, 40, 1).
fishProbability(f7, 25, 1).
fishProbability(f8, 10, 1).
fishProbability(f9, 15, 1).
fishProbability(f10, 10, 1).
fishProbability(f11, 10, 1).
fishProbability(f12, 5, 1).
fishProbability(f13, 5, 1).

/* Exp Memancing */
fishExp(f1, 5).
fishExp(f2, 10).
fishExp(f3, 20).
fishExp(f4, 25).
fishExp(f5, 20).
fishExp(f6, 40).
fishExp(f7, 60).
fishExp(f8, 100).
fishExp(f9, 100).
fishExp(f10, 110).
fishExp(f11, 100).
fishExp(f12, 150).
fishExp(f13, 150).

/* Level Requirement */
fishLevelRequirement(f1, 1).
fishLevelRequirement(f2, 1).
fishLevelRequirement(f3, 1).
fishLevelRequirement(f4, 1).
fishLevelRequirement(f5, 1).
fishLevelRequirement(f6, 2).
fishLevelRequirement(f7, 2).
fishLevelRequirement(f8, 3).
fishLevelRequirement(f9, 3).
fishLevelRequirement(f10, 4).
fishLevelRequirement(f11, 4).
fishLevelRequirement(f12, 5).
fishLevelRequirement(f13, 5).

/* Fish Utility */
getLevelFish(X) :- player(_,_,_,_,_,X,_,_,_,_,_,_,_), !.
getFishingXP(X) :- player(_,_,_,_,_,_,X,_,_,_,_,_,_), !.

% Update XP
addFishingXP(Add) :- player(A,B,C,D,E,F,VAL,H,I,J,K,LEXP,M),
                      NewXP is VAL + Add,
                      NewLExp is LEXP + Add,
                      retract(player(_,_,_,_,_,_,VAL,_,_,_,_,LEXP,_)),
                      asserta(player(A,B,C,D,E,F,NewXP,H,I,J,K,NewLExp,M)).

% Harga Beli ikan
getFishSellPrice(X, Price) :- fishAlias(X, I), 
                              isFish(I), 
                              fishPrice(X, P), 
                              getLevelFish(L), 
                              Price is P + 5 * L, !.

getFishSellPrice(X, Price) :- isFish(X), 
                              fishPrice(X, P),
                              getLevelFish(L),
                              Price is P + 5 * L, !.

getFishBuyPrice(X, Price) :- \+ isFish(X), fishPrice(X, Price), !.

% Mendapatkan Informasi Fish Item
getFishItem(X,Y,Z) :- fishItem(X,Y,Z), !.
getFishItem(X,Y,Z) :- fishAlias(X,A), fishItem(A,Y,Z), !.

/* Item Randomizer */
fishItemRandomable(0, [f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13]).
fishItemRandomable(1, [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13]).
getRandomItem(1, [_H|_T], _H).
getRandomItem(Idx, [_|T], Result) :- _LIdx is Idx - 1, getRandomItem(_LIdx, T, Result).

questFishRandomizer(X, Cnt) :- 
            random(1,13, _Idx), 
            fishItemRandomable(0, _L), 
            getRandomItem(_Idx, _L, X), 
            random(1,4, Cnt), !.

/* Penghitung Jumlah Probabilitas */
sumCounter([], _, 0) :- !.
sumCounter([H|T], Level, Sum) :- fishLevelRequirement(H, Lvl),
                            Lvl =< Level, sumCounter(T, Level, LastSum),
                            fishProbability(H, Prob, Multiplier),
                            Sum is LastSum + Prob + Multiplier * Level, !.

sumCounter([_|T], Level, Sum) :- sumCounter(T, Level, Sum), !.

levelSum(L, Level, Result) :- sumCounter(L, Level, Result).

fishFinder([H|_], Weight, Level, H) :- 
            fishLevelRequirement(H, Lvl),
            Lvl =< Level,
            fishProbability(H, Prob, Multiplier),
            ItemProb is Prob + Multiplier * Level,
            Weight =< ItemProb, !.

fishFinder([H|T], Weight, Level, Result) :- 
            fishLevelRequirement(H, Lvl),
            Lvl =< Level,
            fishProbability(H, Prob, Multiplier),
            ItemProb is Prob + Multiplier * Level,
            NewWeight is Weight - ItemProb,
            fishFinder(T, NewWeight, Level, Result).

getFishRandom(Result) :-
      getLevelFish(_Level),
      fishItemRandomable(1, _List),
      levelSum(_List, _Level, _Sum),
      _Upper is _Sum + 1,
      random(0, _Upper, _Weight),
      fishFinder(_List, _Weight, _Level, Result).


/* Message Util */
printMessage(f1, _) :- 
      write('Yay sudah dapat...'),nl, nl, sleep(1),
      write('Kamu mendapatkan item berikut'), nl,
      write('Nama Item : 📦 Junk'), nl,
      nl,
      write('Gapapa.. Coba lagi'), !.

printMessage(X, Cnt) :-
      fishItem(X, Label, Name),
      write('Yay sudah dapat...'),nl, nl, sleep(1),
      write('Kamu mendapatkan item berikut'), nl,
      write('Nama Item : '), write(Label), write(' '),
      write(Name), nl, 
      write('Jumlah : '), write(Cnt), nl, nl,
      write('🎉 Selamatt...').

/* State Game Driver */
% Driver setelah melakukan memancing
afterFishing :-
    kegiatan(K), KNew is K + 1,
    energi(E), ENew is E - 1,
    retract(kegiatan(K)),
    retract(energi(E)),
    asserta(kegiatan(KNew)),
    asserta(energi(ENew)),
    levelUp.
  
% Driver Pengubah XP Equipment
addRodExp(Item, Exp) :-
    rodLevel(Item, LastExp),
    retract(rodLevel(Item, LastExp)),
    NewExp is Exp + LastExp,
    asserta(rodLevel(Item, NewExp)), !.

addRodExp(Item, Exp) :-
    asserta(rodLevel(Item, Exp)).

getEquipmentLevel(Item, Level) :-
    rodLevel(Item, Exp),
    Exp < 300,
    Level is (Exp div 150) + 1, !.

getEquipmentLevel(Item, 3) :- rodLevel(Item, Exp),
    Exp > 300, !.

getEquipmentLevel(Item, 1) :- 
    \+ rodLevel(Item, _).

delayMancing(Item, Delay) :-
    getEquipmentLevel(Item, 1),
    Delay is 3, !.

delayMancing(Item, Delay) :-
    getEquipmentLevel(Item, 2),
    Delay is 2, !.

delayMancing(Item, Delay) :-
    getEquipmentLevel(Item, 3),
    Delay is 1, !.

additionalExp(Item, Additional) :-
    getEquipmentLevel(Item, Level),
    Additional is Level * 5, !.

% Driver menambahkan ke inventori
addFishInventory(f1, _) :- !.
addFishInventory(Item, Qty) :-
    insert_item(Item, Qty).

% Helper Pemeriksa Item
isThereFishingRod :- 
    inventory(CurrentInventory),
    is_member(fu1, CurrentInventory,_),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    is_member(fu2, CurrentInventory, _),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    is_member(fu3, CurrentInventory, _),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    is_member(fu4, CurrentInventory, _),
    !.

isThereFishingRod :- 
    fail,!.

% Helper Pencari jumlah ikan yang didapat
fishCatchCount(X, fu1) :- 
    inventory(CurrentInventory),
    is_member(fu1, CurrentInventory, _),
    X is 1, !.

fishCatchCount(X, fu2) :- 
    inventory(CurrentInventory),
    is_member(fu2, CurrentInventory,_),
    random(1, 3, X), !.

fishCatchCount(X, fu3) :- 
    inventory(CurrentInventory),
    is_member(fu3, CurrentInventory,_),
    random(1, 6, X), !.

fishCatchCount(X, fu4) :- 
    inventory(CurrentInventory),
    is_member(fu4, CurrentInventory,_),
    random(1, 10, X), !.

% Helper penghitung XP
getAdderXP(f1, 5) :- !.

getAdderXP(Item, Exp) :-
    player('Fisherman',_,_,_,_,_,_,_,_,_,_,_,_),
    getLevelFish(_L),
    fishExp(Item, _ExpBase),
    Exp is  _ExpBase + 5 * _L + 10, !.

getAdderXP(Item, Exp) :-
    getLevelFish(_L),
    fishExp(Item, _ExpBase),
    Exp is  _ExpBase + 5 * _L, !.

fishable :-
    posisi(_X,_Y),
    NextX is _X + 1,
    isWater(NextX,_Y), !.

fishable :-
    posisi(_X,_Y),
    LastX is _X - 1,
    isWater(LastX,_Y), !.

fishable :-
    posisi(_X,_Y),
    NextY is _Y + 1,
    isWater(_X,NextY), !.

fishable :-
    posisi(_X,_Y),
    LastY is _Y - 1,
    isWater(_X,LastY), !.

fishable :-
    posisi(_X,_Y),
    LastX is _X - 1,
    LastY is _Y - 1,
    isWater(LastX,LastY), !.
fishable :-
    posisi(_X,_Y),
    LastX is _X + 1,
    LastY is _Y - 1,
    isWater(LastX,LastY), !.
fishable :-
    posisi(_X,_Y),
    LastX is _X + 1,
    LastY is _Y + 1,
    isWater(LastX,LastY), !.

fishable :-
    posisi(_X,_Y),
    LastX is _X - 1,
    LastY is _Y + 1,
    isWater(LastX,LastY), !.

writeRodData(Item) :-
    inventory(X),
    is_member(Item, X, _),
    fishItem(Item, Icon, Name),
    getEquipmentLevel(Item, Level),
    format('~w. ~w ~w (Level ~w)', [Item, Icon, Name, Level]), nl, !.

writeRodData(_) :- !.

validateRod(Item) :-
    inventory(X),
    is_member(Item, X, _),
    fishItem(Item, _, _),
    !.

validateRod(_) :- !, fail.

selectRod(SelectedRod) :- 
    write('Pilih alat pancing yang ingin kamu gunakan'), nl,
    writeRodData(fu1),
    writeRodData(fu2),
    writeRodData(fu3),
    writeRodData(fu4),
    nl,
    (
        repeat,
        write('Masukan kode alat pancing : '),
        read(SelectedRod), validateRod(SelectedRod)), !. 

/* Fishing */
fish :- \+ fishable,
      write('Kamu belum bisa memancing karena tidak berada di sekitar air'),
      nl, !, fail.

fish :- \+ isThereFishingRod,
        write('Kamu ga punya alat pancing di inventori..'),
        nl,  write('Beli dulu sana..'), !, fail.

fish :- runProgram(_),
        fishable,
        write('--- Daerah Pemancingan ---'), nl,
        selectRod(Rod),
        write('[Suara Alat Pancing]'), nl,
        write('Tunggu sebentar'),
        write('........'),
        delayMancing(Rod, Time),
        sleep(Time),
        nl, nl,
        fishCatchCount(Cnt, Rod),
        getFishRandom(FishID),
        getAdderXP(FishID, AddExp),
        additionalExp(Rod, ItemExp),
        NettoExp is AddExp + ItemExp,
        addFishingXP(NettoExp),
        addFishInventory(FishID, Cnt),
        addRodExp(Rod, NettoExp),
        printMessage(FishID, Cnt),
        afterFishing,
        !.

deallocateFish :-
    retractall(rodLevel(_,_)), !.