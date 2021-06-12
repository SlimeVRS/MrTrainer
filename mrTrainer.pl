begin:-
    read_string(user_input, '\n', '.',_,Q),
    string_lower(Q,Lowercase),
    atomic_list_concat(List,' ',Lowercase),
    startConversationAux(List,[]).

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
    getRoutine(Number,Sport,Illness,Level,Days,Routine).

startConversationAux(List,[]):-
    write("Me estas saludando? Porque no te entendi \n"),
    begin.

userSport(Sport):-
    write("Hola!!! Como estas? \n Te gustaria empezar a entrenar?"), nl,
    read_string(user_input, '\n', '.', _, Q),
    string_lower(Q,Lowercase),
    atomic_list_concat(List,' ',Lowercase),
    getSport(List,[],Sport).

userSport(Sport):-
    write("No te entendi. Prueba las siguientes respuestas: \n
    Si / Si correr \n"),
    userSportAux(Sport).

userSportAux(Sport):-
    write("Te gustaria empezar a entrenar?"), nl,
    read_string(user_input, '\n', '.', _, Q),
    string_lower(Q,Lowercase),
    atomic_list_concat(List,' ',Lowercase),
    getSport(List,[],Sport).

getSport(List,Empty,Sport):-
    yes(List,Empty),
    write("Tenemos las siguientes categorias:\n
    \t - Correr \n
    \t - Natacion \n
    \t - Ciclismo \n
    \t - Triatlon \n"),
    listSports(Sport).

getSport(List,Empty,Sport):-
    no(List,Empty),
    write("Avisame cuando quieras entrenar. Adios!"), nl,
    break.

getSport(List,Empty,Sport):-
    yes(List,Rest),
    sport(Rest,Empty),
    atomics_to_string(Rest,Sport).

listSports(SportSelected):-
    read_string(user_input, '\n', '.', _, Q),
    string_lower(Q,SportSelected),
    atomic_list_concat(Sport, ' ',SportSelected),
    sport(Sport,Empty).

userIllness(Illness):-
    write("Has tenido alguna patologia que te impida hacer ejercicio con normalidad? \n"), nl,
    read_string(user_input, '\n', '.', _, Q),
    string_lower(Q,Lowercase),
    atomic_list_concat(List,' ', Lowercase),
    getIllness(List,[],Illness).

userIllness(Illness):-
    write("No entendi tu respuesta. "),
    userIllness(Illness).


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

illnessList(Illness):-
    write("Cual de las siguientes? \n
    \t - Cardeopata \n
    \t - Problemas de articulaciones \n
    \t - Problemas de columna \n
    \t - Asmatico \n
    \t - Ninguno"), nl,
    read_string(user_input, '\n', '.', _, Q),
    string_lower(Q,Lowercase),
    atomic_list_concat(Illness, ' ',Lowercase),
    illness(Illness,Empty).

userLevel(Level):-
    write("Que tan frecuente practicas deporte?"), nl,
    read_string(user_input, '\n', '.', _,Q),
    sub_atom(Q,0,1,After,Days),
    getLevel(Level,Days).

getLevel(Level,Days):-
    level(Level,Quantity),
    miembro(Days,Quantity).

miembro(X,[X|_]).
miembro(X,[_|Y]):-
    miembro(X,Y).

getRoutine(Number,Sport,Illness,Level,Days,Rutine):-
    rutine(Number,Sport,Illness2,Level,Days,Rutine),
    Illness\=Illness2,
    write("Tenemos la siguiente rutina de ejercicios para usted"), nl,
    write("Rutina "),write(Number),nl,
    write("Intensida de rutina: "),write(Level),
    write(" con "),write(Days),write(" dias a la semana"),nl,
    write(Rutine),
    write("Espero haberte ayudadoa a encontrar una rutina adecuada para tu condicion fisica \n
    Nos vemos y entrena duro!"),nl,
    break.

getRoutine(Name,Sport,Illness,Level,Days,Details):-
   write("Disculpame, no pude encontrar una rutina adecuada para tu condicion fisica. \n Adios"),nl,
   break.

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
level('principiante',['0'.'1'.'2']).
level('intermedio',['3'.'4']).
level('avanzado',['5'.'6'.'7']).

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
trainer(['mr.trainer'|S],S).
trainer(['mrtrainer'|S],S).
trainer(['MrTrainer'|S],S).

yes(['si'|S],S).
no(['no'|S],S).
no(['ninguno'|S],S).

% Rutinas
rutine('#1', "correr", "no", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 5km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Trote suave de 5km. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Corre intensivamente 10 minutos y descansa 1 min hasta llegar a los 5 km. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#2', "correr", "no", 'intermedio', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 7km de manera continua. \n
Martes: Corre 7km de manera intensa.\n
Miercoles: Descansa, pero sigue haciendo estiramientos. \n
Jueves: Corre 7km de manera continua. \n
Viernes: Corre 7km de manera intensa 10 minutos y trote 1 min. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#3', "correr", "no", 'avanzado', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 10km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Corre 10km de manera intensa. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Corre 10km de manera continua. \n
Sabado: Descansa, pero sigue haciendo estiramientos. \n
Domingo: Corre 10km de manera intensa durante 10 minutos, corre 1 min. \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#4', "correr", "cardeopata", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Corre 2km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 2km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#5', "correr", "cardeopata", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 4km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Corre 4km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 4km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#6', "correr", "cardeopata", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 6km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Corre 6km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 6km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#7', "correr", "articulacion", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 1km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 1km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#8', "correr", "articulacion", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 2km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 2km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#9', "correr", "articulacion", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 3km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 3km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#10', "correr", "columna", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 1km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 1km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#11', "correr", "columna", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 2km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 2km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#12', "correr", "columna", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 3km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 3km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#13', "correr", "asmatico", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 1km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 1km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#14', "correr", "asmatico", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 2km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 2km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#15', "correr", "asmatico", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice un trote suave de 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Trote 3km de manera. Descanse de ser necesario \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice un trote suave de 3km de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#16', "natacion", "no", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 6 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas, descanse cada 2. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 6 piscinas de manera continua. Evite todas las pausas que pueda. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#17', "natacion", "no", 'intermedio', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 8 piscinas de manera continua. \n
Martes: Realice 8 piscinas de manera intensa.\n
Miercoles: Descansa, pero sigue haciendo estiramientos. \n
Jueves: Realice 8 piscinas de manera continua. \n
Viernes: Realice 8 piscinas de manera intensa. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#18', "natacion", "no", 'avanzado', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 10 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles:Realice 10 piscinas de manera intensa. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 10 piscinas de manera continua. \n
Sabado: Descansa, pero sigue haciendo estiramientos. \n
Domingo: Realice 10 piscinas de manera intensa. \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#19', "natacion", "cardeopata", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 4 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 4 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#20', "natacion", "cardeopata", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 6 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 6 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#21', "natacion", "cardeopata", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 8 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 8 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#22', "natacion", "articulacion", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 4 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 4 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#23', "natacion", "articulacion", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 6 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 6 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#24', "natacion", "articulacion", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 8 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 8 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#25', "natacion", "columna", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 6 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 6 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#26', "natacion", "columna", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 8 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 8 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#27', "natacion", "columna", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 10 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 10 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 10 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#28', "natacion", "asmatico", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 6 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 6 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#29', "natacion", "asmatico", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 8 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 8 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#30', "natacion", "asmatico", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Realice 10 piscinas de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Realice 10 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Realice 10 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#31', "ciclismo", "no", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 10km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Haga un recorrido de 10km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km a velocidad intensa. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#32', "ciclismo", "no", 'intermedio', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 15km a velocidad constante. \n
Martes: Haga un recorrido de 15km a velocidad intensa.\n
Miercoles: Descansa, pero sigue haciendo estiramientos. \n
Jueves: Haga un recorrido de 15km a velocidad constante. \n
Viernes: Haga un recorrido de 15km a velocidad intensa. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#33', "ciclismo", "no", 'avanzado', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 30km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 30km a velocidad intensa. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 30km a velocidad constante. \n
Sabado: Descansa, pero sigue haciendo estiramientos. \n
Domingo: Haga un recorrido de 30km a velocidad intensa. \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#34', "ciclismo", "cardeopata", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 5km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 5km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 5km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#35', "ciclismo", "cardeopata", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 10km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 10km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#36', "ciclismo", "cardeopata", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 15km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 15km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#37', "ciclismo", "articulacion", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 5km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 5km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 5km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#38', "ciclismo", "articulacion", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 10km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 10km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#39', "ciclismo", "articulacion", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 15km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 15km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#40', "ciclismo", "columna", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 6km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 6km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 6km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#41', "ciclismo", "columna", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 8km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 8km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 8km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#42', "ciclismo", "columna", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 12km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 12km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 12km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#43', "ciclismo", "asmatico", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 20km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 20km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 20km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#44', "ciclismo", "asmatico", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 40km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 40km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 40km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#45', "ciclismo", "asmatico", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Haga un recorrido de 60km a velocidad constante. \n
Martes: Descansa, pero sigue haciendo estiramientos. \n
Miercoles: Haga un recorrido de 60km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 60km a velocidad constante. \n
Sabado y Domingo: Descanso completo. \n
Si no puedes mantener el ritmo, camine en vez de correr.
').

rutine('#46', "triatlon", "no", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 5km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10 km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#47', "triatlon", "no", 'intermedio', 4,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 7km de manera continua. \n
Martes: Realice 8 piscinas de manera continua.\n
Miercoles: Descansa, pero sigue haciendo estiramientos. \n
Jueves: Haga un recorrido de 15km de manera continua. \n
Viernes: Realice 8 piscinas de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#48', "triatlon", "no", 'avanzado', 6,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 10km de manera continua. \n
Martes: Realice 10 piscinas de manera continua.\n
Miercoles: Haga un recorrido 30km a velocidad constante. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Corre 10km de manera continua. \n
Sabado: Realice 10 piscinas de manera continua.
Domingo: Haga un recorrido 30km a velocidad constante. \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#49', "triatlon", "cardeopata", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 5km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#50', "triatlon", "cardeopata", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 4km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#51', "triatlon", "cardeopata", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 6km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#52', "triatlon", "articulacion", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 2 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 5km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#53', "triatlon", "articulacion", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#54', "triatlon", "articulacion", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#55', "triatlon", "columna", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 2 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 5km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#56', "triatlon", "columna", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#57', "triatlon", "columna", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#58', "triatlon", "asmatico", 'principiante', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 1km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 4 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 10km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#59', "triatlon", "asmatico", 'intermedio', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 2km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 6 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 15km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').

rutine('#60', "triatlon", "asmatico", 'avanzado', 3,'
Siempre empieza con un calentamiento de 10 min y estira. \n
Recuerda tener una dieta balanceada tambien. \n
Lunes: Corre 3km de manera continua. \n
Martes: Descansa, pero sigue haciendo estiramientos.\n
Miercoles: Realice 8 piscinas de manera continua. \n
Jueves: Descansa, pero sigue haciendo estiramientos. \n
Viernes: Haga un recorrido de 20km de manera continua. \n
Sabado y Domingo: Descanso completo \n
Si no puedes mantener el ritmo, trote en vez de correr.
').