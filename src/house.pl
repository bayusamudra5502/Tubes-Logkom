/* House */
:- dynamic(inHouse/1).
:- dynamic(diary/4).
:- dynamic(daySnapshot/4).

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
        repeat,
	nl,
	write('##################  House  ##################'),nl,
    	write('# 1. Sleep 🌙                               #'),nl,
    	write('# 2. Write Diary 📚                         #'),nl,
    	write('# 3. Read Diary 📚                          #'),nl,
    	write('# 4. Exit                                   #'),nl,
	write('# Apa yang ingin Kamu lakukan?              #'),nl,
	write('#                                           #'),nl,
	write('#############################################'),nl,nl,
	write('Masukkan angka : '),read(X),nl,
       	(X =:= 1 -> tidur 
        ;X =:= 2 -> diaryWriter;
        X =:= 3 -> diaryReader;
        X =:= 4 -> s,
                   nl,
                   write('Kamu telah berada di luar house'),
                   retract(inHouse(_))
        ),!.

/* yg diatas ubah aja yaa heehehheeee sesuain ajaaa itu cuman dummy biar program lain jalan heheeh */

/* Fungsi dasar */
sleepMessage :- nl, write('🐓 Kukuruyuk...'), nl, nama(X), 
                write('Halo, '), write(X), 
                write('! Selamat pagi. Selamat menjalani hari ini...'), nl.

writeSeasonIcon('Spring') :- write('🍀'), !.
writeSeasonIcon('Summer') :- write(''), !.
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
         write('🌙 Selamat Malam...'), nl, sleep(1),
         periTidur,
         retract(time(_,_,_,_,_)),
         NewT is T + 1,
         asserta(time('Siang', 1, 0, 'Spring', NewT)),
         sleepMessage, nl,
         dayStat(1, 'Spring', NewT), updater, !.

tidur :- time('Malam', 30, 2, _, T), 
         inHouse(_),
         write('🌙 Selamat Malam...'), sleep(1),
         periTidur,
         retract(time(_,_,_,_,_)),
         asserta(time('Siang', 1, 3, 'Winter', T)),
         sleepMessage, nl,
         dayStat(1, 'Winter', T), updater, !.

tidur :- time('Malam', 30, 1, _, T), 
         inHouse(_),
         write('🌙 Selamat Malam...'), sleep(1),
         periTidur,
         retract(time(_,_,_,_,_)),
         asserta(time('Siang', 1, 2, 'Fall', T)),
         sleepMessage, nl,
         dayStat(1, 'Fall', T), updater, !.

tidur :- time('Malam', 30, 0, _, T), 
         inHouse(_),
         write('🌙 Selamat Malam...'), sleep(1),
         periTidur,
         retract(time(_,_,_,_,_)),
         asserta(time('Siang', 1, 2, 'Summer', T)),
         sleepMessage, nl,
         dayStat(1, 'Summer', T), updater,!.

tidur :- time('Malam', D, S, SL, T),
         inHouse(_),
         write('🌙 Selamat Malam...'), sleep(1),
         periTidur,
         retract(time(_,_,_,_,_)),
         NewDay is D + 1,
         asserta(time('Siang', NewDay, S, SL, T)),
         sleepMessage, nl,
         dayStat(NewDay, SL, T), updater, !.

tidur :- write('Hari masih siang. Kamu belum bisa tidur'), !, fail.

/* Diary Utility */
writeDiary(Day, Season, Year, Message) :-
        retract(diary(Day, Season, Year, _)),
        asserta(diary(Day, Season, Year, Message)), !.

writeDiary(Day, Season, Year, Message) :-
        asserta(diary(Day, Season, Year, Message)).

writeSnapshot(Day, Season, Year, Data) :-
        retract(daySnapshot(Day, Season, Year, _)),
        asserta(daySnapshot(Day, Season, Year, Data)), !.

writeSnapshot(Day, Season, Year, Data) :-
        asserta(daySnapshot(Day, Season, Year, Data)).

readSnapshot(Day, Season, Year) :-
        daySnapshot(Day, Season, Year, [Money, Level, Exp]),
        nl,
        write('Status pada masa ini :'), nl,
        write('💰 Uang  : '), write(Money), nl,
        write('💼 Level : '), write(Level), nl,
        write('⚒️ Exp    : '), write(Exp), nl.

writeCurrentSnapshot :- 
        player(_,Level,_,_,_,_,_,_,_,_,_,Exp,_), gold(Money),
        time(_, Day, _, Season, Year),
        writeSnapshot(Day, Season, Year, [Money, Level, Exp]),
        !.

readDiary(Day, Season, Year) :- 
        diary(Day, Season, Year, Message),
        write('📅 Tanggal : '),
        writeSeasonIcon(Season),
        write(Season),
        write(','),
        write(Day),
        write(', Year '),
        write(Year),
        nl,nl,
        write(Message), nl.

readDiary(_) :- write('Diary tidak ditemukan.').

diaryWriter :-
        time(_, Day, _, Season, Year),
        write('--- 🪶 Diary Writter ---'),nl,
        write('📅 Tanggal : '),
        writeSeasonIcon(Season),
        write(Season),
        write(','),
        write(Day),
        write(', Year '),
        write(Year),
        nl,nl,
        write('Petunjuk : Apitlah teks diarymu dengan petik tunggal (\') dan diakhiri titik'),
        nl,nl,
        read(Message),
        writeDiary(Day, Season, Year, Message), 
        writeCurrentSnapshot, !, fail.

allDiary(Result) :- findall([Day, Season, Year], diary(Day, Season, Year, _), Result).

writeDiaries([], _) :- !.
writeDiaries([[Day, Season, Year]|T], Iterator) :-
        write(Iterator),
        write('. '),
        writeSeasonIcon(Season),
        write(' '),
        write(Season),
        write(', '),
        write(Day),
        write(', Year '),
        write(Year),
        nl,
        NIterator is Iterator + 1,
        writeDiaries(T, NIterator), !.

getDiary(Idx, Day, Season, Year) :- 
        allDiary(DiaryData),
        nth1(Idx, DiaryData, [Day, Season, Year]).

printWrittenDiaries :-
        allDiary(DiaryData),
        writeDiaries(DiaryData, 1), nl.

printDiaryData(Day, Season, Year) :-
        diary(Day, Season, Year, _),
        daySnapshot(Day, Season, Year, _),
        readDiary(Day, Season, Year),
        readSnapshot(Day, Season, Year), !.

printDiaryData(_,_,_) :- write('Tidak ditemukan data'), nl.

diaryReader :- 
        write('--- 📓 Diary Reader ---'),nl,
        write('Diary yang tersedia :'),nl,
        printWrittenDiaries,
        write('Indeks diary yang ingin dibaca : '),
        read(Idx),
        nl, nl,
        getDiary(Idx, Day, Season, Year),
        printDiaryData(Day, Season, Year), !, fail.
