% Command getter
getter :- runProgram(_),
        write('\33\[38;5;93mCommand: \33\[0m'), nl,
        write('\33\[38;5;31m    getRole.          \33\[0m: melihat role dari pemain'), nl,
        write('\33\[38;5;31m    getGold.          \33\[0m: melihat uang yang tersedia'), nl,
        write('\33\[38;5;31m    getExp.           \33\[0m: melihat exp total pada game'), nl,
        write('\33\[38;5;31m    getExpFarmer.     \33\[0m: melihat exp farmer'),nl,
        write('\33\[38;5;31m    getExpRancher.    \33\[0m: melihat exp rancher'),nl,
        write('\33\[38;5;31m    getExpFisher.     \33\[0m: melihat exp fisher'),nl,
        write('\33\[38;5;31m    getLevel.         \33\[0m: melihat level game saat ini'),nl,
        write('\33\[38;5;31m    getLevelFarmer.   \33\[0m: melihat level farmer saat ini'),nl,
        write('\33\[38;5;31m    getLevelRancher.  \33\[0m: melihat level rancher saat ini'),nl,
        write('\33\[38;5;31m    getLevelFisher.   \33\[0m: melihat level fisher saat ini'),nl,
        write('\33\[38;5;31m    getEnergi.        \33\[0m: melihat energi yang tersisa'),nl,
        write('\33\[38;5;31m    getLocation.      \33\[0m: melihat lokasi pemain saat ini'),nl,
        write('\33\[38;5;31m    getTime.          \33\[0m: melihat waktu pada game saat ini'),nl,
        write('\33\[38;5;31m    getDiary.         \33\[0m: melihat diary.'), nl,!.


% getter untuk role
getRole :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Role Anda pada game kali ini adalah sebagai '),write(A),write(','),nl,!.
        
% getter untuk gold
getGold :- runProgram(_),gold(Gold),
        write('Jumlah uang Anda saat ini adalah '),write(Gold),write(' G.'),nl,!.

% getter untuk exp
getExp :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(L),write('.'),nl,!.

% getter untuk exp farming
getExpFarmer :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(D),write('.'),nl,!.

% getter untuk exp ranching
getExpRancher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(G),write('.'),nl,!.

% getter untuk exp fishing
getExpFisher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Exp Anda saat ini adalah '),write(J),write('.'),nl,!.

% getter untuk level
getLevel :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level '),write(B),write('.'),nl,!.

% getter untuk level farming
getLevelFarmer :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level farming '),write(C),write('.'),nl,!.

% getter untuk level ranching
getLevelRancher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level ranching '),write(F),write('.'),nl,!.

% getter untuk level fishing
getLevelFisher :- runProgram(_),player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write('Anda sekarang berada di level fishing '),write(I),write('.'),nl,!.

% getter untuk energi
getEnergi :- runProgram(_),energi(Energi),
        write('Energi Anda yang tersisa saat ini adalah '),write(Energi),write('.'),nl,!.

% getter untuk location
getLocation :- runProgram(_),posisi(X,Y),\+isHouse(X,Y),\+isMarket(X,Y),\+isRanch(X,Y),\+isWater(X,Y),\+isBorder(X,Y),\+isQuest(X,Y),\+isAlchemist(X,Y),
        write('Posisi Anda saat ini adalah '),write(X),write(','),write(Y),write('.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isHouse(X,Y),
        write('Sekarang Anda berada di rumah.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isMarket(X,Y),
        write('Sekarang Anda berada di market.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isRanch(X,Y),
        write('Sekarang Anda berada di peternakan.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isQuest(X,Y),
        write('Sekarang Anda berada di quest.'),nl,!.

getLocation :- runProgram(_),posisi(X,Y),isAlchemist(X,Y),
        write('Sekarang Anda berada di alchemist.'),nl,!.

/*TODO: */
% getter diary -> setelah realisasi rumah selesai
% getter time dan fungsi timenya -> pikirin lagi caranya


