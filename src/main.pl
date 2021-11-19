:- dynamic(runProgram/1).
:- dynamic(nama/1).
:- dynamic(posisi/2).
:- dynamic(gold/1).
:- dynamic(energi/1).

/* include file yang dibutuhkan untuk main */
:- include('map.pl').
:- include('move.pl').
:- include('player.pl').
:- include('story.pl').
:- include('stateGame.pl').
:- include('farming.pl').
%memulai permainan
startGame :-
    runProgram(_),
    write('You have started the game, have fun!'),!.

startGame :-
    \+runProgram(_),    
    write('\33\[38;5;96m██╗░░██╗░█████╗░██████╗░██╗░░░██╗███████╗░██████╗████████╗  ██╗░░██╗██████╗░██╗░░░██╗░██████╗░░█████╗░██████╗░\33\[0m'),nl,
    write('\33\[38;5;96m██║░░██║██╔══██╗██╔══██╗██║░░░██║██╔════╝██╔════╝╚══██╔══╝  ██║░░██║██╔══██╗╚██╗░██╔╝██╔════╝░██╔══██╗╚════██╗\33\[0m'),nl,
    write('\33\[38;5;96m███████║███████║██████╔╝╚██╗░██╔╝█████╗░░╚█████╗░░░░██║░░░  ███████║██████╦╝░╚████╔╝░██║░░██╗░██║░░██║░█████╔╝\33\[0m'),nl,
    write('\33\[38;5;96m██╔══██║██╔══██║██╔══██╗░╚████╔╝░██╔══╝░░░╚═══██╗░░░██║░░░  ██╔══██║██╔══██╗░░╚██╔╝░░██║░░╚██╗██║░░██║░╚═══██╗\33\[0m'),nl,
    write('\33\[38;5;96m██║░░██║██║░░██║██║░░██║░░╚██╔╝░░███████╗██████╔╝░░░██║░░░  ██║░░██║██████╦╝░░░██║░░░╚██████╔╝╚█████╔╝██████╔╝\33\[0m'),nl,
    write('\33\[38;5;96m╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░░╚═════╝░░╚════╝░╚═════╝░\33\[0m'),nl,                                                          
    nl,
    asserta(quest(0,0,0)),
    repeat,
    write('Welcome to Harvest HBYG03, this game will make your day better!!!'),nl,
    write('************* Enjoy and be the winner of this game *************!'),nl,
    write('\33\[38;5;91m1. New Game.\33\[0m'),nl,
    write('\33\[38;5;96m2. Load Game.\33\[0m'),nl,nl,
    write('Insert number : '),read(X),
    (X =:= 1 -> newGame ;X =:= 2 -> loadGame),
    asserta(runProgram(1)),
    write('\nplese type \'help.\' to find out what commands can be used in this game!!!'),!.

% new game
newGame :- runProgram(_), write('The game has started!'),!.

newGame:- write('let me know, who are you? (tulis di antara tanda petik dan diakhiri titik. Contoh: \'hbyg\'.)'),nl,
          write('Your name is '), read(Username),
          asserta(nama(Username)),nl,
          write('Hi '), write(Username),write('! Enjoy and be the winner of this game!!!.'),nl,nl,
          asserta(runProgram(1)),
          asserta(gold(100)),
          asserta(energi(50)),
          initPemain,
          initMap,
          story0,
          levelUp,
          !.
% menampilkan command yang dapat digunakan
help :- runProgram(_),
        write('\33\[38;5;93mCommand: \33\[0m'), nl,
        write('\33\[38;5;31m    startGame.          \33\[0m: memulai permainan'), nl,
        write('\33\[38;5;31m    quitGame.           \33\[0m: keluar dari permainan'), nl,
        write('\33\[38;5;31m    help.               \33\[0m: melihat command apa saja yang dapat digunakan'), nl,
        write('\33\[38;5;31m    map.                \33\[0m: melihat peta game'),nl,
        write('\33\[38;5;31m    w.                  \33\[0m: gerak ke utara 1 langkah'),nl,
        write('\33\[38;5;31m    s.                  \33\[0m: gerak ke selatan 1 langkah'),nl,
        write('\33\[38;5;31m    d.                  \33\[0m: gerak ke timur 1 langkah'),nl,
        write('\33\[38;5;31m    a.                  \33\[0m: gerak ke barat 1 langkah'),nl,
        write('\33\[38;5;31m    saveGame            \33\[0m: melakukan penyimpanan game'), nl,
      	write('\33\[38;5;31m    status.             \33\[0m: cek status player'), nl,
        write('\33\[38;5;31m    getter.             \33\[0m: Melihat command getter apa saja yang tersedia'), nl,
        write('\33\[38;5;31m    periTidur.          \33\[0m: Berpindah ke posisi mana saja di map'), nl,
        write('\33\[38;5;31m    quest.              \33\[0m: cek progress quest'), nl,
        write('\33\[38;5;31m    cekInventory.       \33\[0m: cek inventory'), nl,!.
/*sementara itu dulu buat command help*/

% keluar dari program 
quitGame :- 
            \+runProgram(_),
            write('You have not started the game yet!!!'),!.

quitGame :-
            retract(runProgram(1)),
            retractall(runProgram(_)),
            retractall(posisi(_)),
            retractall(length(_)),
            retractall(width(_)),
            retractall(width(_)),
            retractall(nama(_)),
            retractall(gold(_)),
            retractall(energi(_)),
            retractall(player(_,_,_,_,_,_,_,_,_,_,_,_,_)),
            write('------------------Thank You For Playing----------------'),nl,
            write('Please Come and Play Again to Try Other Roles and Items'),nl,
            write('---------------------SEE YOU AGAIN---------------------'),nl,!.
