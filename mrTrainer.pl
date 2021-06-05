% RULE BASE FORMAT:
%
% rules([[keyword,importance of keybord], [
%     [pattern #, [pattern], last response used,
%         [response 1],
%         [response 2],
%         ...
%         [response n]]]])

% Greetting

rules([[hola,0],[
       [1,[_],0,
       [listo,para,empezar,con,el,plan,?]]]]).

rules([[none,0],[
       [1,[_],0,
        [no,te,entendi,bien,.],
        [podrias,repetirlo,?],
        [revisa,si,escribiste,bien,.,no,te,pude,entender]]]]).

rules([[ejercicio,#], [
       [1,[_,quiero,empezar],0,
        [excelente,iniciativa,.,tienes,pensado,algo,?],
        [buena,idea,.,tienes,ganas,de,alguna,actividad,?],
        [me,parece,perfecto,.,alguna,disciplina,que,quieras,hacer,?]],
       [2,[_,quiero,ejercitarme],0,
        [buena,idea,.,algo,en,concreto,?],
        [has,pensado,en,algun,ejercicio,?],
        [con,que,quieres,empezar,?]]]]).

rules([[sufro,#],[
       [1,[_,sufro,de,Enfermedad],0,
        [tendre,Enfermedad,en,cuenta,.,¿,que,tan,activo,eres,?],
        [Enfermedad,.,entendido,.,eres,activo,fisicamente,?]],
       [2,[no],0,
        [excelente,.,has,hecho,ejercicio,antes,?],
        [alguna,actividad,reciente,?],
        [eres,activo,fisicamente,?]]]]).

% char(char,type)
%  char is ASCII code
%  type is a whitespace, punctuation, alphanumeric or especial

char(46,period) :-!.
char(X,alphanumeric):- X >= 65, X =< 90, !.
char(X,alphanumeric):- X >= 97, X =< 123, !.
char(X,alphanumeric):- X >= 48, X =< 57, !.
char(X,whitespace):- X =< 32, !.
char(X,punctuation):- X >= 33, X =< 47, !.
char(X,punctuation):- X >= 58, X =< 64, !.
char(X,punctuation):- X >= 91, X =< 96, !.
char(X,punctuation):- X >= 123, X =< 126, !.
char(_,special).

% lower_case(C,L)
% C is a capital ASCII letter
% L its corresponding lower case letter
% Otherwise C is equal to L

lower_case(X,Y) :-
    X >= 65,
    X =< 90,
    Y is X + 32, !.

lower_case(X,Y).

% extract_word(String,Rest,Word)
% Gets the first word of String, Rest is the residual part of the string
% Word is a continuous letters or a series of digits
% Also, is a special character

extract_word([C|Chars],Rest,[C|RestOfWord]):-
    char(C,Type),
    extract_word_aux(Type,Chars,Rest,RestOfWord).

extract_word_aux(special,Rest,Rest,[]):-!.

extract_word_aux(Type,[C|Chars],Rest,[C|RestOfWord]):-
    char(C,Type), !,
    extract_word_aux(Type,Chars,Rest,RestOfWord).

extract_word_aux(_,Rest,Rest,[]).

% remove_starts_blanks(X,Y)
% Deletes first whitespaces from X given Y

remove_starts_blanks([C|Chars],Result):-
    char(C,whitespace), !,
    remove_start_blanks(Chars,Result).

remove_starts_blanks(X,X).

% digit_value(D,V)
% D is the ASCII code of some number
% V, its respective value

digit_value(48,0).
digit_value(49,1).
digit_value(50,2).
digit_value(51,3).
digit_value(52,4).
digit_value(53,5).
digit_value(54,6).
digit_value(55,7).
digit_value(56,8).
digit_value(57,9).

% string_to_number(S,N)
% Converts a string to the number it has
% Fails if S isn't a non-negative integer

string_to_number(S,N):-
    string_to_number_aux(S,0,N).

string_to_number_aux([D|Digits],ValueSoFar,Result) :-
    digit_value(D,V),
    NewValueSoFar is 10*ValueSoFar + V,
    string_to_number_aux(Digits,NewValueSoFar,Result).

string_to_number_aux([],Result,Result).

% string_to_atomic(S,A)
% Changes a string to the atom or number according to the representation

string_to_atomic([C|Chars], Number) :-
    string_to_number([C|Chars], Number), !.

string_to_atomic(String,Atom) :- name(Atom,String).

% get_atom(String,ListOfAtoms)
% Breaks a string into a list of atoms
% "hello my name is" into [hello,my,name,is]

get_atom(String,ListOfAtoms) :-
    remove_starts_blanks(String,NewString),
    get_atom_aux(NewString,ListOfAtoms).

get_atom_aux([C|Chars],[A|Atoms]) :-
    extract_word([C|Chars],Rest,Word),
    string_to_atomic(Word,A),
    get_atom(Rest,Atoms).

get_atom_aux([],[]).

% clean_string(String,CleanString)
% removes punctuations form strings and retures a clean string

clean_string([C|Chars], L) :-
    char(C,punctuation),
    clean_string(Chars,L), !.

clean_string([C|Chars],[C|L]) :-
    clean_string(Chars,L), !.

clean_string([C|[]],[]) :-
    char(C,punctuation), !.

clean_string([C|[]],[C]).

% isList(List)
% check if List is a list

isList([_|_]).

% last_elem(Last,List)
% returns last element of a list

last_elem(End,List) :- append(_,[End],List).

% search(List,Index,Element)
%  Returns the index member of Eelement

search([E|_],1,E).
search([_|T],N,T1) :- V is N - 1,
    search(T,V,T1).

% replace(Elem1,List1,Elem2,List2)
% replace all instances of elem1 in list1 with elem2 and returns
% a new list as list2

replace(_,[],_,[]).
replace(X,[H|T],A,[A|T2]) :-
    nonvar(H),
    H = X, !,
    replace(X,T,A,T2).

replace(X,[H|T],A,[H|T2]) :-
    replace(X,T,A,T2).

% simplify(List,Result)
% simplifies List into Result
%
% simplify(List,Result) :-  sr(List,Result,X,Y), !,
%    simplify(X,Y).
%
% simplify([W|Words],[W|NewWords]) :- simplify(Words,NewWords).
%
% simplify([],[]).

% match(MatchRule,InputList)
% matches MatchRule with the InputList. The match result are:
%  - Empty list
%  - Singe word
%  - List of words

match(A,C) :- match_aux(A,C),!.
match(A,C) :- match_aux2(A,C).

match_aux(A,C) :-
    member([*|T],A),
    nonvar(T),
    member(Tm,T),
    nonvar(T),
    replace([*|T],A,Tm,B),
    match_aux2(B,C),
    !, last_member(L,T), L = Tm.

match_aux2([],[]).

match_aux2([Item|Items],[Word|Words]) :-
    match_aux3(Item,Items,Word,Words),!.

match_aux2([Item1,Item2|Items],[Word,Words]) :-
    var(Item1),
    nonvar(Item2),
    Item2 == Word,!,
    match_aux2([Item1,Item2|Items],[[],Word|Words]).

match_aux2([Item1,Item2|Items],[Word,Words]):-
    var(Item1),
    var(Item2),!,
    match_aux2([Item1,Item2|Items],[[],Word|Words]).

match_aux2([[]],[]).

match_aux3(Word,Items,Word,Words) :-
    match_aux2(Items,Words),!.

match_aux3([Word|Seg], Items,Word,Words):-
    append(Seg,Words1,Words),
    match_aux2(Items,Words1).
