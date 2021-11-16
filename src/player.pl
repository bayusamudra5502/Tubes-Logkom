:- dynamic(player/13).

% player(Job, level, levelFarming, expFarming, base expFarming, levelFishing, expFishing, base expFishing, levelRanching, expRanching, base expRanching, exp, base exp)
% player(A,B,C,D,E,F,G,H, I, J, K,L,M)

initPemain :- 
            write('\33\[38;5;220mHii, before start the game, Please Choose Your Job\33\[0m'),nl,
            write('1. Fisherman.'),nl,
            write('2. Farmer.'),nl,
            write('3. Rancher.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(player('Fisherman', 1,1,56,150,1,76,150,1,56,150,0,250)) ;
            X =:= 2 ->asserta(player('Farmer', 1,1,56,150,1,76,150,1,56,150,0,250));
            X =:= 3 ->asserta(player('Rancher', 1,1,56,150,1,76,150,1,56,150,0,250))).


levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L,M), D >= E, G >= H, J >= K, L >= M,
          Bnew is B+1,
          Cnew is C+1,
          Dnew is D mod E,
          Enew is E*2,
          Fnew is F+1,
          Gnew is G mod H,
          Hnew is H*2,
          Inew is I+1,
          Jnew is J mod K,
          Knew is K*2,
          Lnew is L mod M,
          Mnew is M*2,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew,Mnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.
levelUp :-!.
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

