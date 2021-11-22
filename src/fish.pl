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
fishProbability(f2, 80, 3).
fishProbability(f3, 70, 3).
fishProbability(f4, 65, 1).
fishProbability(f5, 70, 1).
fishProbability(f6, 40, 5).
fishProbability(f7, 25, 5).
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


/* Fish Utility */
/* Definisi Fish Item */
fishItem(fu1, '🎣', 'Iron Fishing Rod').
fishItem(fu2, '🎣', 'Pakan Ikan').

/* Harga fish Utiliy */
fishPrice(fu1, 1000).
fishPrice(fu2, 1000).

/* Utilitas */
resetFishLevel :- asserta(fishingExp(0)).

% Fishing Level
getLevelFish(X) :- fishingExp(EXP), LEVEL is EXP // 200, LEVEL < 5, X is LEVEL, !.
getLevelFish(X) :- X is 5, !.


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

% Mendapatkan lokasi di sekitar fishing pod

/* Fishing */
fish.