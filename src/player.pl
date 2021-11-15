:- dynamic(player/12).

% player(Job, level, levelFarming, expFarming, levelFishing, expFishing, levelRanching, expRanching, exp, base exp, gold, energi tersisa)
% player(A,B,C,D,E,F,G,H, I, J, K,L)

initPemain :- 
            write('\33\[38;5;220mHii, before start the game, Please Choose Your Job\33\[0m'),nl,
            write('1. Fisherman.'),nl,
            write('2. Farmer.'),nl,
            write('3. Rancher.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(player('Fisherman', 1,1,56,1,76,1,56,0,250,100,50)) ;
            X =:= 2 ->asserta(player('Farmer', 1,1,56,1,76,1,56,0,250,100,50));
            X =:= 3 ->asserta(player('Rancher', 1,1,56,1,76,1,56,0,250,100,50))).


levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), I >= J,
          Bnew is B+1,
          Cnew is C,
          Dnew is D,
          Enew is E,
          Fnew is F,
          Gnew is G,
          Hnew is H,
          Inew is I mod J,
          Jnew is J*2,
          Knew is K,
          Lnew is L,
          retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew,Hnew,Inew,Jnew,Knew,Lnew)),
          write('Level up from '), write(B), write(' -> '),write(Bnew),nl,!.
levelUp :-!.
/* TODO : level up untuk masing2 parameter ranch,farmer, fish, sesuai exp dan levelnya */

status :- player(A,B,C,D,E,F,G,H,I,J,K,L),
	      write('\33\[38;5;76m####################################################\33\[0m'),nl,
	      write('\33\[38;5;76m#                   \33\[0m STATUS PEMAIN                 \33\[38;5;76m#\33\[0m'),nl,
	      write('\33\[38;5;76m####################################################\33\[0m'),nl,
          write('Job           : '), write(A),nl,
          write('Level         : '), write(B),nl,
          write('Level Farming : '), write(C),nl,
          write('Exp Farming   : '), write(D),nl,
          write('Level Fishing : '), write(E),nl,
          write('Exp Fishing   : '), write(F),nl,
          write('Level Ranching: '), write(G),nl,
          write('Exp Ranching  : '), write(H),nl,
          write('Exp           : '), write(I),write('/'),write(J),nl,
          write('Gold          : '), write(K),nl,
          write('Energi Tersisa: '), write(L),nl,!.

