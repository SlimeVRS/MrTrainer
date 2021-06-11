%*********************************************************************************************** Sistema experto ***********************************************************************************************

% Regla: begin
% Params: No hay parametros
% ===============================================================
begin:- read(Q),/*string_lower(Q,P),BNF(P,W),*/nl,inicio(Q/*W*/).

% Regla: inicio
% Params: String
% ====================================================================================================================================
inicio("hola"):- write("Hola, ¿en que lo puedo ayudarte?"),nl,read(E),/*string_lower(E,P),BNF(P,R),*/nl,disciplina(E/*R*/).
inicio("buenos"):- write("Buenos dias, ¿en que lo puedo ayudarte?"),nl,read(E),/*string_lower(E,P),BNF(P,R),*/nl,disciplina(E/*R*/).
inicio("buenas"):- write("Buenas tardes, ¿en que lo puedo ayudarte?"),nl,read(E),/*string_lower(E,P),BNF(P,R),*/nl,disciplina(E/*R*/).
inicio(_):- write("No te entendi, por favor repitalo"),nl,read(E),/*string_lower(E,P),BNF(P,R),*/nl,inicio(E/*R*/).

% Regla: disciplina
% Params: String
% =========================================================================================================================================================================================================
disciplina("empezar"):- write("Excelente iniciativa. Estamos para asesorarte en todo lo que necesites.¿Has pensado en alguna disciplina?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,patologia(X/*Q*/).
disciplina(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,disciplina(X/*Q*/).

% Regla: patologia
% Params: String
% =======================================================================================================================================================================================================
patologia("correr"):- write("Correr es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("ciclismo"):- write("Ciclismo es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("natacion"):- write("Natacion es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("triatlon"):- write("Triatlon es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("yoga"):- write("Yoga es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("funcional"):- write("Funcional es una gran actividad. ¿Has tenido alguna patologia que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia("no"):- write("Ok. ¿Has tenido alguna patología que te impida hacer ejercicio con normalidad?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).
patologia(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,patologia(X/*Q*/).

% Regla: activo
% Params: String
% ============================================================================================================================
activo("no"):- write("¿Eres activo fisicamente?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,frecuencia(X/*Q*/).
activo("si"):- write("Esta bien. ¿Eres activo fisicamente?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,frecuencia(X/*Q*/).
activo("tengo"):- write("OK. ¿Eres activo fisicamente?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,frecuencia(X/*Q*/).
activo(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,activo(X/*Q*/).

% Regla: frecuencia
% Params: String
% ====================================================================================================================================
frecuencia("si"):- write("¿Que tan frecuente practicas actividad fisica?"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,plan(X/*Q*/).
frecuencia("no"):- plan("semana").
frecuencia("semana"):- plan("semana").
frecuencia(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,frecuencia(X/*Q*/).

% Regla: plan
% Params: String
% ====================================================================================================================================================
plan("semana"):- write("Puedes empezar con un plan de un"),/*DB(Q),*/write("Q"/*Q*/),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,calendario(X/*Q*/).
plan(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,plan(X/*Q*/).

% Regla: calendario
% Params: String
% ===================================================================================================================================================
calendario("tendras"):- write("Enseguida de lo presento."),nl,/*DB(Q),*/ write("Q"/*Q*/),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,adios(X/*Q*/).
calendario("no"):- write("Claro."),nl,/*DB(Q),*/ write("Q"/*Q*/),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,adios(X/*Q*/).
calendario(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,calendario(X/*Q*/).

% Regla: adios
% Params: String
% ==================================================================================================================
adios("gracias"):- write("Con gusto."),!.
adios("muchas"):- write("Con mucho gusto"),!.
adios("adios"):- write("Adios."),!.
adios(_):- write("No te entendi, por favor repitalo"),nl,read(X),/*string_lower(X,P),BNF(P,Q),*/nl,adios(X/*Q*/).