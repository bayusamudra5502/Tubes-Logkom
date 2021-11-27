:- dynamic(inAlchemist/1).
/* alchemist masih belum sampai */
alchemist :-
	runProgram(_),
	\+inAlchemist(_),nl,
	write('Kamu masih terlalu jauh dari alchemist.'),
	!.

/* pemain sudah di alchemist */

alchemist :-
	runProgram(_),
	inAlchemist(_),
	nl,nl,
	write('#################  Alchemist  ###############'),nl,
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
        X =:= 4 -> s,nl,write('Kamu telah berada di luar alchemist')),!.

