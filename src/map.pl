:- dynamic(width/1).
:- dynamic(length/1).
:- dynamic(runProgram/1).

/* Menginisialisasi Map */
initMap:-
    asserta(length(20)),
    asserta(width(20)),
    length(P),
    width(L),
    initPlayer.

/* Menginisialisasi Posisi Awal Player */
initPlayer :-
    asserta(posisi(1,1)).

/* Mengecek apakah kooordinat X,Y posisi Player */
isPlayer(X,Y) :-
    posisi(A,B),
    X =:= A,
    Y =:= B.

/* Mengecek apakah kooordinat X,Y posisi Quest */
isQuest(X,Y) :-
    X =:= 8,
    Y =:= 7.

/* Mengecek apakah kooordinat X,Y posisi Market */
isMarket(X,Y) :-
    X =:= 15,
    Y =:= 16.

/* Mengecek apakah kooordinat X,Y posisi House */
isHouse(X,Y) :-
    X =:= 16,
    Y =:= 4.

/* Mengecek apakah kooordinat X,Y posisi Ranch */
isRanch(X,Y) :-
    X =:= 3,
    Y =:= 17.


/* Mengecek apakah kooordinat X,Y posisi Alchemist*/
isAlchemist(X,Y) :-
    X =:= 18,
    Y =:= 11.


/* Mengecek apakah kooordinat X,Y posisi Border atau Ujung Map */
isBorder(X,_) :-
    X =:= 0.
isBorder(X,_) :-
    length(P),
    X =:= P.
isBorder(_,Y) :-
    Y =:= 0.
isBorder(_,Y) :-
    width(L),
    Y =:= L.

/* menampilkan air atau lokasi untuk memancing*/
isWater(X,Y) :-
    X =:= 9,
    Y =:= 10;
    X =:= 10,
    Y =:= 10;
    X =:= 11,
    Y =:= 10;
    X =:= 8,
    Y =:= 11;
    X =:= 9,
    Y =:= 11;
    X =:= 10,
    Y =:= 11;
    X =:= 11,
    Y =:= 11;
    X =:= 12,
    Y =:= 11;
    X =:= 9,
    Y =:= 12;
    X =:= 10,
    Y =:= 12;
    X =:= 11,
    Y =:= 12.

/* Menampilkan lokasi setiap tempat pada map */
cetakMap(X,Y) :-
    length(P),
    width(L),
    isBorder(X,Y),
    X =:= P,
    Y =:= L,
    write('🗿').

cetakMap(X,Y) :-
    length(P),
    isBorder(X,Y),
    X =:= P,
    write('🗿'),nl,
    NextX is 0,
    NextY is Y+1,
    cetakMap(NextX,NextY).

cetakMap(X,Y) :-
    isBorder(X,Y),
    write('🗿'),
    NextX is X+1,
    cetakMap(NextX,Y).

/* api artinya quest untuk setiap misi*/
cetakMap(X,Y) :-
    isQuest(X,Y),
    write('🔥'), 
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isMarket(X,Y),
    write('🛒'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isHouse(X,Y),
    write('🏠'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isRanch(X,Y),
    write('🐄'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isAlchemist(X,Y),
    write('🧪'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isPlayer(X,Y),
    write('💂'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    isWater(X,Y),
    write('🌊'),
    NextX is (X+1),
    cetakMap(NextX,Y).

cetakMap(X,Y) :-
    \+isBorder(X,Y),
    write(' -'),
    NextX is (X+1),
    cetakMap(NextX,Y).

/* Menampilkan Map */
map :-
    runProgram(_),
    cetakMap(0,0),!.