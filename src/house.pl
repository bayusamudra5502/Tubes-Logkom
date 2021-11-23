/* House */
:- dynamic(inHouse/1).
/* house masih belum sampai */
house :-
	runProgram(_),
	\+inHouse(_),nl,
	write('Kamu masih terlalu jauh dari house.'),
	!.

/* pemain sudah di house */
house :-
	runProgram(_),
	inHouse(_),
	nl,nl,
	write('##################  House  ##################'),nl,
    	write('# 1. Sleep 🌙                               #'),nl,
    	write('# 2. WriteDiary 📚                          #'),nl,
    	write('# 3. ReadDiary 📚                           #'),nl,
    	write('# 4. Exit                                   #'),nl,
	write('# Apa yang ingin Kamu lakukan?              #'),nl,
	write('#                                           #'),nl,
	write('#############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> sleepMessage 
        ;X =:= 2 -> sleepMessage;
        X =:= 3 -> sleepMessage;
        X =:= 4 -> s,nl,write('Kamu telah berada di luar house')),!.

/* yg diatas ubah aja yaa heehehheeee sesuain ajaaa itu cuman dummy biar program lain jalan heheeh */

/* Fungsi dasar */
sleepMessage :- write('🌙 Selamat Malam...'), sleep(1), 
                nl, write('🐓 Kukuruyuk...'), nl, nama(X), 
                write('Halo, '), write(X), 
                write('! Selamat pagi. Selamat menjalani hari ini...'), nl.

writeSeasonIcon('Spring') :- write('🍀'), !.
writeSeasonIcon('Summer') :- write('☀️'), !.
writeSeasonIcon('Fall') :- write('🍂'), !.
writeSeasonIcon('Winter') :- write('☃️'), !.

dayStat(Day, Season, Year) :- 
        write('⏰ Waktu saat ini...'), nl,
        write('Musim : '), writeSeasonIcon(Season), write(' '), write(Season), nl,
        write('Day   : '), write(Day), nl,
        write('Year  : '), write(Year), nl.

tidur :- \+ runProgram(_), !, fail.
tidur :- posisi(X,Y), \+ isHouse(X, Y), !, fail.
tidur :- time('Malam', 30, 3, _, T), 
         inHouse(_),
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 0, 'Spring', NewT)),
         sleepMessage, nl,
         dayStat(1, 'Spring', NewT), !.

tidur :- time('Malam', 30, 2, _, T), 
         inHouse(_),
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 3, 'Winter', T)),
         sleepMessage, nl,
         dayStat(1, 'Winter', T), !.

tidur :- time('Malam', 30, 1, _, T), 
         inHouse(_),
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 2, 'Fall', T)),
         sleepMessage, nl,
         dayStat(1, 'Fall', T), !.

tidur :- time('Malam', 30, 0, _, T), 
         inHouse(_),
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 2, 'Summer', T)),
         sleepMessage, nl,
         dayStat(1, 'Summer', T), !.

tidur :- time('Malam', D, S, SL, T),
         inHouse(_),
         retract(time(_,_,_,_,_)),
         NewDay is D + 1,
         asserta(time('Siang', NewDay, S, SL, T)),
         sleepMessage, nl,
         dayStat(NewDay, SL, T).

tidur :- !.
         