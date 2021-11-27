/* Fishing */

:- dynamic(fishingExp/1).
:- dynamic(fishPrice/1).
:- dynamic(fishAlias/2).

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
fishLevelRequirement(f4, 25).
fishLevelRequirement(f5, 20).
fishLevelRequirement(f6, 40).
fishLevelRequirement(f7, 60).
fishLevelRequirement(f8, 100).
fishLevelRequirement(f9, 100).
fishLevelRequirement(f10, 110).
fishLevelRequirement(f11, 100).
fishLevelRequirement(f12, 150).
fishLevelRequirement(f13, 150).

/* Fish Utility */
/* Definisi Fish Item */
fishItem(fu1, '🎣', 'Normal Fishing Rod').
fishItem(fu2, '🎣', 'Iron Fishing Rod').
fishItem(fu3, '🎣', 'Gold Fishing Rod').
fishItem(fu4, '🎣', 'Diamond Fishing Rod').

/* Harga fish Utiliy */
fishPrice(fu1, 100).
fishPrice(fu2, 1000).
fishPrice(fu3, 2500).
fishPrice(fu4, 4000).

/* Utilitas */
resetFishLevel :- changeFishingLevel(1, 0).

changeFishingLevel(X, EXP) :- player(A,B,C,D,E,F,G,H,I,J,K,L,M),
                  retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), 
                  asserta(player(A,B,C,D,E,X,EXP,H,I,J,K,L,M)).


% Fishing Level
getLevelFish(X) :- player(_,_,_,_,_,_,_,_,X,_,_,_,_), !.

% Update XP
getFishingXP(X) :- player(_,_,_,_,_,_,X,_,_,_,_,_,_), !.

% Update XP
addFishingXP(Add) :- player(_,_,_,_,_,_,VAL,_,_,_,_,LEXP,_),
                      NewXP is VAL + Add,
                      NewLExp is  LEXP + Add,
                      retract(player(_,_,_,_,_,_,VAL,_,_,_,_,LEXP,_)),
                      asserta(player(_,_,_,_,_,_,NewXP,_,_,_,_,NewLExp,_)),
                      levelUp.

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
getRandomItem(Idx, [H|T], Result) :- _LIdx is Idx - 1, getRandomItem(LIdx, T, Result).

questFishRandomizer(X) :- 
            random(1,13, _Idx), fishItemRandomable(0, _L), getRandomItem(_Idx, _L, X), !.

sumCounter([], _, 0).
sumCounter([H|T], Level, Sum) :- fishLevelRequirement(H, Lvl),
                            Lvl >= Level, sumCounter(T, Level, LastSum),
                            fishProbability(H, Prob, Multiplier)
                            Sum is LastSum + Prob + Multiplier * Level, !.
sumCounter([_|T], Level, Sum) :- sumCounter(T, Level, LastSum), !.

levelSum(L, Level, Result) :- sumCounter(L, Level, Result).

fishFinder([H|T], Weight, Level, H) :- 
            fishLevelRequirement(H, Lvl),
            Lvl >= Level,
            fishProbability(H, Prob, Multiplier),
            ItemProb is Prob + Multiplier * Level,
            Weight <= ItemProb, !.

fishFinder([H|T], Weight, Level, Result) :- 
            fishLevelRequirement(H, Lvl),
            Lvl >= Level,
            fishProbability(H, Prob, Multiplier),
            ItemProb is Prob + Multiplier * Level,
            NewWeight is Weight - ItemProb,
            fishFinder(T, NewWeight, Level, Result).

getFishRandom(Result) :-
      getLevelFish(_Level),
      fishItemRandomable(1, _List),
      levelSum(_List, _Level, _Sum),
      random(0, _Sum, _Weight),
      fishFinder(_List, _Weight, _Level, Result).


/* Message Util */
printMessage(f1, Cnt) :- 
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
    asserta(kegiatan(ENew)).
  
% Driver Pengubah XP

% Driver menambahkan ke inventori
addFishInventory(f1, _) :- !.
addFishInventory(Item, Qty) :-
    insert_item(Item, Qty).

% Helper Pemeriksa Item
isThereFishingRod :- 
    inventory(CurrentInventory),
    member(fu1, CurrentInventory),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    member(fu2, CurrentInventory),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    member(fu3, CurrentInventory),
    !.

isThereFishingRod :- 
    inventory(CurrentInventory),
    member(fu4, CurrentInventory),
    !.

isThereFishingRod :- 
    fail,!.

% Helper Pencari jumlah ikan yang didapat
fishCatchCount(X) :- 
    inventory(CurrentInventory),
    member(fu1, CurrentInventory),
    X is 1.

fishCatchCount(X) :- 
    inventory(CurrentInventory),
    member(fu2, CurrentInventory),
    random(1, 3, X).

fishCatchCount(X) :- 
    inventory(CurrentInventory),
    member(fu3, CurrentInventory),
    random(1, 6, X).

fishCatchCount(X) :- 
    inventory(CurrentInventory),
    member(fu4, CurrentInventory),
    random(1, 10, X).

% Helper penghitung XP
getAdderXP(f1, 5) :- !.
getAdderXP(Item, Exp) :-
    getLevelFish(_L),
    fishExp(Item, _ExpBase),
    Exp is  _ExpBase + 5 * _L, !.

/* Fishing */
fish :- \+ inWater(_),
      write('Kamu belum bisa memancing karena tidak berada di sekitar air'),
      nl, !, fail.

fish :- \+ isThereFishingRod,
        write('Kamu ga punya alat pancing di inventori..'),
        nl,  write('Beli dulu sana..'), !, fail.

fish :- runProgram(_),
        inWater(_),
        write('--- Daerah Pemancingan ---'), nl,
        write('[Suara Alat Pancing]'), nl,
        write('Tunggu sebentar'),
        sleep(1),
        write('.'),
        sleep(1),
        write('.'),
        sleep(1),
        write('.'),
        sleep(1),
        write('.'),
        sleep(1),
        write('.'),
        nl, nl,
        fishCatchCount(Cnt),
        getFishRandom(FishID),
        printMessage(FishID, Cnt),
        getAdderXP(FishID, AddExp),
        addFishingXP(AddExp),
        addFishInventory(FishID, Cnt),
        !.
        