:- dynamic(inQuest/1).
/* quest masih belum sampai */
quest :-
	runProgram(_),
	\+inQuest(_),nl,
	write('Kamu masih terlalu jauh dari quest.'),
	!.


/* pemain sudah di quest */

/* sesuain aja sama menu sebenarnya yah ini cuman dummy aja biar program lain jalan heheheheh */
quest :-
	runProgram(_),
	inQuest(_),
	nl,nl,
	write('##################  Quest  ##################'),nl,
    write('# 1. Sleep 🌙                               #'),nl,
    write('# 2. WriteDiary 📚                          #'),nl,
    write('# 3. ReadDiary 📚                           #'),nl,
    write('# 4. Exit                                   #'),nl,
	write('# Apa yang ingin Kamu lakukan?              #'),nl,
	write('#                                           #'),nl,
	write('#############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> write('sleep')
        ;X =:= 2 -> write('sleep');
        X =:= 3 -> write('sleep');
        X =:= 4 -> s,nl,write('Kamu telah berada di luar quest')),!.