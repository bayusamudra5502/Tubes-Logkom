:- dynamic(runProgram/1).
:- dynamic(nama/1).
:- dynamic(posisi/2).
:- dynamic(gold/1).
:- dynamic(energi/1).
:- dynamic(sleep/1).
:- dynamic(kegiatan/1).
:- dynamic(time/5).
:- dynamic(item/5).
:- dynamic(sold/5).

/* include file yang dibutuhkan untuk main */
:- include('map.pl').
:- include('move.pl').
:- include('player.pl').
:- include('story.pl').
:- include('stateGame.pl').
:- include('farming.pl').
:- include('house.pl').
:- include('ranching.pl').
:- include('fish.pl').
:- include('items.pl').
:- include('market.pl').
:- include('alchemist.pl').
:- include('quest.pl').

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
          asserta(kegiatan(0)),
          asserta(inventory([])),
          insert_item(fu1,1),
          initPemain,
          initTime,
          initMap,
          story0,
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
        write('\33\[38;5;31m    saveGame.           \33\[0m: melakukan penyimpanan game'), nl,
        write('\33\[38;5;31m    loadGame.           \33\[0m: melakukan load terhadap game'), nl,
      	write('\33\[38;5;31m    status.             \33\[0m: cek status player'), nl,
        write('\33\[38;5;31m    getter.             \33\[0m: Melihat command getter apa saja yang tersedia'), nl,
        write('\33\[38;5;31m    quest.              \33\[0m: cek progress quest'), nl,
        write('\33\[38;5;31m    getFarm.            \33\[0m: Melihat command apa saja yang digunakan pada farming'), nl,
        write('\33\[38;5;31m    house.              \33\[0m: Melihat apa saja yang dilakukan di house'), nl,
        write('\33\[38;5;31m    market.             \33\[0m: Melihat apa saja yang dilakukan di market'), nl,
        write('\33\[38;5;31m    ranch.              \33\[0m: Melihat apa saja yang dilakukan di ranch'), nl,
        write('\33\[38;5;31m    fish.               \33\[0m: Melihat apa saja yang dilakukan di fish'), nl,
        write('\33\[38;5;31m    alchemist.          \33\[0m: Melihat apa saja yang dilakukan di alchemist'), nl,
        write('\33\[38;5;31m    inventory.       \33\[0m: cek inventory'), nl,!.


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
            retractall(time(_,_,_,_,_)),
            retractall(kegiatan(_)),
            retractall(inHouse(_)),
            retractall(inMarket(_)),
            retractall(inQuest(_)),
            retractall(inventory(_)),
            retractall(inAlchemist(_)),
            retractall(item(_,_,_,_,_)),
            write('------------------Thank You For Playing----------------'),nl,
            write('Please Come and Play Again to Try Other Roles and Items'),nl,
            write('---------------------SEE YOU AGAIN---------------------'),nl,!.
