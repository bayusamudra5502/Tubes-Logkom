:- dynamic(player/13).
:- dynamic(inventory/1).

% inventory ([list])
% list elemen : ID, amount


% player(Job, level, levelFarming, expFarming, base expFarming, levelFishing, expFishing, base expFishing, levelRanching, expRanching, base expRanching, exp, base exp)
% player(A,B,C,D,E,F,G,H, I, J, K,L,M)

initPemain :- 
            write('\33\[38;5;220mHii, before start the game, Please Choose Your Job\33\[0m'),nl,
            write('1. Fisherman.'),nl,
            write('2. Farmer.'),nl,
            write('3. Rancher.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(player('Fisherman', 1,1,56,150,1,76,150,1,56,150,0,250)) ;
            X =:= 2 ->asserta(player('Farmer', 1,1,56,150,1,76,150,1,56,150,0,250)), insert_item(i1,1);
            X =:= 3 ->asserta(player('Rancher', 1,1,56,150,1,76,150,1,56,150,0,250))).


levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G >= H, J >= K, L >= M,
          Bnew is B+1,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G >= H, J < K, L >= M,
          Bnew is B+1,
          Cnew is C+1,
          Dnew is D ,
          Enew is E*2,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G < H, J >= K, L >= M,
          Bnew is B+1,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D < E, G >= H, J >= K, L >= M,
          Bnew is B+1,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D< E, G < H, J >= K, L >= M,
          Bnew is B+1,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D < E, G >= H, J < K, L >= M,
          Bnew is B+1,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G < H, J < K, L >= M,
          Bnew is B+1,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D < E, G < H, J < K, L >= M,
          Bnew is B+1,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G >= H, J >= K, L < M,
          Bnew is B,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G >= H, J < K, L < M,
          Bnew is B,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G < H, J >= K, L < M,
          Bnew is B,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D < E, G >= H, J >= K, L < M,
          Bnew is B,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D< E, G < H, J >= K, L < M,
          Bnew is B,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I+1,
          Jnew is J,
          Knew is K*2,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D < E, G >= H, J < K, L < M,
          Bnew is B,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F+1,
          Gnew is G,
          Hnew is H*2,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G < H, J < K, L < M,
          Bnew is B,
          Cnew is C+1,
          Dnew is D,
          Enew is E*2,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I,
          Jnew is J,
          Knew is K,
          Lnew is L,
          Mnew is M,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L,M)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          nl,!.

levelUp :- !.
/* TODO : level up untuk masing2 parameter ranch,farmer, fish, sesuai exp dan levelnya */

status :- player(A,B,C,D,E,F,G,H,I,J,K,L,M),gold(Gold),energi(Energi),
	      write('\33\[38;5;76m####################################################\33\[0m'),nl,
	      write('\33\[38;5;76m#                   \33\[0m STATUS PEMAIN                 \33\[38;5;76m#\33\[0m'),nl,
	      write('\33\[38;5;76m####################################################\33\[0m'),nl,
          write('Job           : '), write(A),nl,
          write('Level         : '), write(B),nl,
          write('Level Farming : '), write(C),nl,
          write('Exp Farming   : '), write(D),write('/'),write(E),nl,
          write('Level Fishing : '), write(F),nl,
          write('Exp Fishing   : '), write(G),write('/'),write(H),nl,
          write('Level Ranching: '), write(I),nl,
          write('Exp Ranching  : '), write(J),write('/'),write(K),nl,
          write('Exp           : '), write(L),write('/'),write(M),nl,
          write('Gold          : '), write(Gold),nl,
          write('Energi Tersisa: '), write(Energi),nl,!.

/* Management Inventory */
% is_empty (list)
is_empty([]).

% insert_last( elemen, list, result)
insert_last(X, [], [X]) :- !.
insert_last(X, [H|T1], [H|T2]):- insert_last(X,T1, T2).

% delete_at_n( n, list, result)
delete_at_n(0, [_|T], T) :- !.
delete_at_n(N, [H|T1], [H|T2]) :- N1 is N-1, delete_at_n(N1, T1, T2).

% select_nth (list, n, result)
select_nth([H|_],0, H).
select_nth([_|T],N, X) :- N1 is N-1, select_nth(T, N1, X).

% set_nth(list, n, newval, updatedlist)
% update : jika newval = 0 maka akan otomatis dihapus dari inventory
set_nth([_|T], 0, [A,B], T) :- B =:= 0.
set_nth([_|T], 0, [A,B], [[A,B]|T]) :- B > 0.
set_nth([H|T1], N, X, [H|T2]):-N1 is N-1, set_nth(T1, N1, X, T2).

% cek apakah item dengan id ID atau idx Index sudah ada di inventory
% is_member(ID,list,index)
head([H|_], H).
is_member(X, [Y|_],0) :- head(Y,X), !.
is_member(X, [_|T],Index) :- is_member(X,T,Index1), Index is Index1 + 1, !.

is_same_coordinate([X,Y],X1,Y1) :- X =:= X1, Y =:= Y1.
is_member_XY([A,B], [Y|_],0) :- is_same_coordinate(Y,A,B).
is_member_XY([A,B], [_|T],Index) :- is_member_XY([A,B],T,Index1), Index is Index1 + 1.



% inv_len (list, length)
inv_len([],0).
inv_len([_|T],L) :- inv_len(T,LT), L is LT + 1.

% menambah item yang belum ada ke inventory
insert_item(ID, Amount) :- inventory(CurrentInventory), 
    \+is_member(ID,CurrentInventory,_),
    insert_last([ID,Amount],CurrentInventory,NewInventory),
    assertz(inventory(NewInventory)),
    retract(inventory(CurrentInventory)), !.

% menambah item yang sudah ada ke inventory
insert_item(ID, Amount) :- inventory(CurrentInventory), 
    is_member(ID,CurrentInventory,Index),
    select_nth(CurrentInventory, Index, [X,N]),
    N1 is N + Amount,
    set_nth(CurrentInventory, Index, [ID,N1], NewInventory),
    assertz(inventory(NewInventory)),
    retract(inventory(CurrentInventory)), !.

% mengurangi item yang sudah ada di inventory
delete_item(ID, Amount) :-
    inventory(CurrentInventory),
    is_member(ID, CurrentInventory, Idx),
    NNew is N - Amount,
    NNew > 0,
    set_nth(CurrentInventory, Index, [ID,N1], NewInventory),
    assertz(inventory(NewInventory)),
    retract(inventory(CurrentInventory)), !.

delete_item(ID, Amount) :-
    inventory(CurrentInventory),
    is_member(ID, CurrentInventory, Idx),
    NNew is N - Amount,
    delete_at_n(Idx, CurrentInventory, NewInventory),
    assertz(inventory(NewInventory)),
    retract(inventory(CurrentInventory)), !.

print_first_item:-
    inventory(X),
    select_nth(X,0,Y1),
    write(Y1).

% Get Amount
getItemAmount(List, Idx, Amount) :- select_nth(List, Idx, [_, Amount]).

print_inventory([]).
print_inventory([[ID, Amount]|T]) :-
    item(ID, UCode, Nama, _, Harga),
    write(ID), write('. '),
    write(Amount), write(' x '),
    write(Nama), write(' ('),
    write(Harga),write(' Gold / item)'), nl,
    print_inventory(T).

