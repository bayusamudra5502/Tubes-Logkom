:- dynamic(inQuest/1).
:- dynamic(questList/1).
/* quest masih belum sampai */
quest :-
	runProgram(_),
	\+inQuest(_),nl,
	write('Kamu masih terlalu jauh dari quest.'),
	!.


/* pemain sudah di quest */

questList([]).

