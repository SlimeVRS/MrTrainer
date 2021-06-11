startConvesation(List,Empty):-
    greeting(List,Rest),
    trainer(Rest,Empty).

startConvesation(List,Empty):-
    greeting(List,Rest),
    time(Rest,Empty).

startConvesation(List,Empty):-
    greeting(List,Empty).

startConversationAux(List,[]):-
    startConvesation(List,[]),
    userSport(Sport),
    userLevel(Level),
    userIllness(Illness),
    getRoutine(Name,Sport,Illness,Level,Days,Details).

% userSport(Sport).
% Aqui se le pide al usuario si ha pensado en algún deporte
% se pasa a minusucalas y se llama a la funciong getSport
% También si no se detecta un deporte y repite la pregunta

getSport(List,Empty,Sport):-
    yes(List,Empty),
    % Aquí van las opciones de deporte
    listSports(Sport).

getSport(List,Empty,Sport):-
    no(List,Empty).
    % Si pone no, se cierra la aplicacion con una despedida

getSport(List,Empty,Sport):-
    yes(List,Empty),
    sport(Rest,Empty),
    atomics_to_string(Rest,Sport).

% listSports(Sport):-
% aquí se lee el deporte del usuario, se pasa a minusculas tambien y se
% pasa a sport

% userIllness(Illness).
% Aqui se pide el padecimiento, se pasa a minusculas y se llama a
% userIllness
% Tambien si no se entiende la enfermedad y se repite la pregunta

getIllness(List,Empty,Illness):-
    yes(List,Rest),
    illness(Rest,Empty),
    atomics_to_string(Rest,Illness).

getIllness(List,Empty,Illness):-
    yes(List,Rest),
    illnessList(Illness).

getIllness(List,Empty,Illness):-
    illness(List,Empty),
    atomics_to_string(List,Illness).

% illnessList(Illness).
% Aqui se pregunta qué padecimientos tiene y se llama a illness

% userLevel(Level)
% Aqui se pregunta el nivel de principiante y eso, se llama a getLevel

getLevel(Level,Days):-
    level(Level,Quantity),
    member(Days,Quantity).

member(X,[X|_]).
member(X,[_|Y]):-
    member(X,Y).

getRoutine(Name,Sport,Illness,Level,Days,Details):-
    excercise(Name,Sport,)

% All posible sports of the user
sport(['correr'|S],S).
sport(['ciclismo'|S],S).
sport(['natacion'|S],S).
sport(['triatlon'|S],S).
sport(['yoga'|S],S).
sport(['funcional'|S],S).

% All posible illness of the user
illness(['cardeopata'|S],S).
illness(['articulaciones'|S],S).
illness(['columna'|S],S).
illness(['asmatico'|S],S).
illness(['no'|S],S).
illness(['No'|S],S).

% All posible sports of the user
level('principiante',["0","1"]).
level('intermedio',["2","3"]).
level('avanzado',["4","5"]).

% All posible greetings of the user
greeting(['hola'|S],S).
greeting(['buenos'|S],S).
greeting(['buenas'|S],S).

% All posible time's day of the user
time(['dias'|S],S).
time(['tardes'|S],S).
time(['noches'|S],S).

% All posible names of the user
trainer(['Mr.Trainer'|S],S).
trainer(['mr.Trainer'|S],S).
trainer(['Mr.trainer'|S],S).
trainer(['mr.trainer'|S],S).
trainer(['mr trainer'|S],S).
trainer(['Mr Trainer'|S],S).
trainer(['mr Trainer'|S],S).
trainer(['Mr trainer'|S],S).
trainer(['Trainer'|S],S).
trainer(['trainer'|S],S).

yes(['si'|S],S).
no(['no'|S],S).