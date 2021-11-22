/* House */

/* Fungsi dasar */
sleepMessage :- write('🌙 Selamat Malam...'), sleep(2), 
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
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 0, 'Spring', NewT)),
         sleepMessage, nl,
         dayStat(1, 'Spring', NewT), !.

tidur :- time('Malam', 30, 2, _, T), 
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 3, 'Winter', T)),
         sleepMessage, nl,
         dayStat(1, 'Winter', T), !.

tidur :- time('Malam', 30, 1, _, T), 
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 2, 'Fall', T)),
         sleepMessage, nl,
         dayStat(1, 'Fall', T), !.

tidur :- time('Malam', 30, 0, _, T), 
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 2, 'Summer', T)),
         sleepMessage, nl,
         dayStat(1, 'Summer', T), !.

tidur :- time('Malam', D, S, SL, T),
         retract(time(_,_,_,_,_)),
         NewDay is D + 1,
         asserta(time('Siang', NewDay, S, SL, T)),
         sleepMessage, nl,
         dayStat(NewDay, SL, T).

tidur :- !.
         