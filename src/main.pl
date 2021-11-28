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
        write('\33\[38;5;31m    inventory.          \33\[0m: cek inventory'), nl,!.

% save game
diaryWritterTranversal([]) :- !.
diaryWritterTranversal([H|T]) :- 
    write('diary('),
    write(H),
    write(').'),
    diaryWritterTranversal(T).

diaryWriter :-
    findall([A,B,C,D], diary(A,B,C,D), Result),
    diaryWritterTranversal(Result).

snapshotWritterTranversal([]) :- !.
snapshotWritterTranversal([H|T]) :- 
    write('daySnapshot('),
    write(H),
    write(').'),
    snapshotWritterTranversal(T).

snapshotWritter :- 
    findall([A,B,C,D], daySnapshot(A,B,C,D), Result),
    snapshotWritterTranversal(Result).

saveGame :- 
    \+runProgram(_),
	write('You have not started the game yet!!!'), nl,
	write('Gunakan perintah "startGame." untuk memulai permainan.'), nl, !.

saveGame :-
    write('Masukkan nama file (format .txt diapit tanda kutip) : '),read(FileName),
    tell(FileName),
        nama(Username),
        write(nama(Username)),write('.'),nl,
        gold(Gold),
        write(gold(Gold)),write('.'),nl,
        energi(Energi),
        write(energi(Energi)),write('.'),nl,
        player(A,B,C,D,E,F,G,H,I,J,K,L,M),
        write(player(A,B,C,D,E,F,G,H,I,J,K,L,M)),write('.'),nl,
        posisi(X,Y),
        write(posisi(X,Y)),write('.'),nl,
        kegiatan(K1),
        write(kegiatan(K1)),write('.'),nl,
        time(T1,T2,T3,T4,T5),
        write(time(T1,T2,T3,T4,T5)),write('.'),nl,
        inventory(V1),
        write('inventory('), write(V1),write(').'),nl,
        planted_list(P1),
        write(planted_list(P1)),write('.'),nl,
        % diaryWriter,
        % snapshotWritter,
        questList(Q1),
        write(questList(Q1)),write('.'),nl,
        tool(AA,BB,CC,DD,EE,FF,GG),
        write(tool(AA,BB,CC,DD,EE,FF,GG)),write('.'),nl,
        ranchProduct(R1,R2,R3,R4,R5,R6,R7,R8),
        write(ranchProduct(R1,R2,R3,R4,R5,R6,R7,R8)),write('.'),nl,
        ranchAll(RA),
        write(ranchAll(RA)),write('.'),nl,
        ranchCountDays(RC),
        write(ranchAll(RC)),write('.'),nl,
    told,
    write('File telah disimpan dengan nama : '), write(FileName),
    !.

% load permainan
loadGame :-
	runProgram(_),
	write('You have started the game.'), nl, !.

loadGame:-
  write('Masukkan nama file (format .txt diapit tanda kutip): '), read(FileName),
  (\+file_exists(FileName) -> write('\n!File tidak ditemukan!\n'), nl, !,fail
  ;open(FileName, read, Stream),
        readFileLines(Stream,Lines),
    close(Stream),
    assertaLine(Lines),
    asserta(runProgram(1))), write('\nFile berhasil di-load!\n'),!.

assertaLine([]) :- !.

assertaLine([X|L]):-
	asserta(X),
	assertaLine(L), !.

readFileLines(Stream,[]) :-
    at_end_of_stream(Stream).

readFileLines(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFileLines(Stream,L).
    
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
            deallocateFish,
            write('------------------Thank You For Playing----------------'),nl,
            write('Please Come and Play Again to Try Other Roles and Items'),nl,
            write('---------------------SEE YOU AGAIN---------------------'),nl,!.
