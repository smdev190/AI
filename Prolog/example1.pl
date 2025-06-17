:- dynamic yes/1, no/1.

go :-
    hypothesis(Disease),
    write('I believe that the patient has '), write(Disease), nl,
    write('TAKE CARE'), nl, nl,
    undo.

/* Hypothesis rules */
hypothesis(cold)     :- cold, !.
hypothesis(flu)      :- flu, !.
hypothesis(typhoid)  :- typhoid, !.
hypothesis(measles)  :- measles, !.
hypothesis(malaria)  :- malaria, !.
hypothesis(unknown). /* no diagnosis found */

/* Disease identification rules */
cold :-
    verify(headache),
    verify(runny_nose),
    verify(sneezing),
    verify(sore_throat),
    nl,
    write('Advices and Suggestions:'), nl,
    write('1: Tylenol/tab'), nl,
    write('2: Panadol/tab'), nl,
    write('3: Nasal spray'), nl,
    write('Please wear warm clothes because cold weather can worsen symptoms.'), nl, nl.

flu :-
    verify(fever),
    verify(headache),
    verify(chills),
    verify(body_ache),
    nl,
    write('Advices and Suggestions:'), nl,
    write('1: Tamiflu/tab'), nl,
    write('2: Panadol/tab'), nl,
    write('3: Zanamivir/tab'), nl,
    write('Please take a warm bath and do salt gargling because these help relieve symptoms.'), nl, nl.

typhoid :-
    verify(headache),
    verify(abdominal_pain),
    verify(poor_appetite),
    verify(fever),
    nl,
    write('Advices and Suggestions:'), nl,
    write('1: Chloramphenicol/tab'), nl,
    write('2: Amoxicillin/tab'), nl,
    write('3: C

    iprofloxacin/tab'), nl,
    write('4: Azithromycin/tab'), nl,
    write('Please do complete bed rest and take soft diet because your digestive system needs recovery.'), nl, nl.

measles :-
    verify(fever),
    verify(runny_nose),
    verify(rash),
    verify(conjunctivitis),
    nl,
    write('Advices and Suggestions:'), nl,
    write('1: Tylenol/tab'), nl,
    write('2: Aleve/tab'), nl,
    write('3: Advil/tab'), nl,
    write('4: Vitamin A'), nl,
    write('Please get rest and use more liquid because hydration is important for recovery.'), nl, nl.

malaria :-
    verify(fever),
    verify(sweating),
    verify(headache),
    verify(nausea),
    verify(vomiting),
    verify(diarrhea),
    nl,
    write('Advices and Suggestions:'), nl,
    write('1: Aralen/tab'), nl,
    write('2: Qualaquin/tab'), nl,
    write('3: Plaquenil/tab'), nl,
    write('4: Mefloquine'), nl,
    write('Please do not sleep in open air and cover your full skin because mosquitoes spread malaria.'), nl, nl.

/* How to ask questions */
ask(Question) :-
    write('Does the patient have the following symptom: '),
    write(Question),
    write('? (yes/no): '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      -> assert(yes(Question))
      ; assert(no(Question)), fail
    ).

/* How to verify something */
verify(S) :-
    (yes(S) -> true ;
     no(S)  -> fail ;
     ask(S)).

/* Undo all yes/no assertions */
undo :- retract(yes(_)), fail.
undo :- retract(no(_)), fail.
undo.

/* Start the expert system */
:- initialization(start).

start :-
    write('MEDICAL DIAGNOSIS EXPERT SYSTEM'), nl,
    write('Answer questions about symptoms with "yes." or "no."'), nl, nl,
    go.