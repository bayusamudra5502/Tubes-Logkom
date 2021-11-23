
:- dynamic(inMarket/1).
/* market masih belum sampai */
market :-
	runProgram(_),
	\+inMarket(_),nl,
	write('Kamu masih terlalu jauh dari market.'),
	!.

/* pemain sudah di market */
/* ini diubah lagi ya sesuai menu yang sebenarnya ini cuman dummy ajaa biar program lain jalan hehehehe*/

market :-
	runProgram(_),
	inMarket(_),
	nl,nl,
	write('##################  Market  ##################'),nl,
    write('# 1. Buy                                     #'),nl,
    write('# 2. Sell                                    #'),nl,
    write('# 3. Exit                                    #'),nl,
	write('# Apa yang ingin Kamu lakukan?               #'),nl,
	write('#                                            #'),nl,
	write('##############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
        (X =:= 1 -> write('sleep')
        ;X =:= 2 -> write('sleep');
        X =:= 3 -> s,nl,write('Kamu telah berada di luar market')),!.
