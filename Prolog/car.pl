:- dynamic yes/1, no/1.

/* Main Predicate */
start :-
    write('CAR DIAGNOSIS EXPERT SYSTEM'), nl,
    write('Answer questions about your car issues with "yes." or "no."'), nl, nl,
    problem(CarIssue),
    nl,
    write('The issue with your car seems to be: '),
    write(CarIssue),
    nl, nl,
    write('Recommended Actions:'), nl,
    action(CarIssue),
    nl,
    reset.

/* Hypotheses to Test */
problem(dead_battery)      :- dead_battery, !.
problem(flat_tire)         :- flat_tire, !.
problem(broken_headlight)  :- broken_headlight, !.
problem(engine_overheating):- engine_overheating, !.
problem(unknown) :-
    write('Unable to determine the exact problem.'), nl,
    write('Please consult a professional mechanic.').

/* Rules for Identifying Problems */
dead_battery :-
    verify(car_wont_start),
    verify(dim_lights),
    verify(clicking_noise),
    nl,
    write('1: Check and replace the car battery.'), nl,
    write('2: Jumpstart the car using jumper cables.'), nl,
    write('3: Check battery terminals for corrosion.').

flat_tire :-
    verify(car_pulls_to_one_side),
    verify(low_tire_pressure),
    verify(visible_tire_damage),
    nl,
    write('1: Replace the flat tire with a spare.'), nl,
    write('2: Use a tire inflator or sealant temporarily.'), nl,
    write('3: Visit a tire repair shop as soon as possible.').

broken_headlight :-
    verify(headlight_doesnt_work),
    verify(no_visible_bulb_damage),
    verify(fuse_blown),
    nl,
    write('1: Replace the blown fuse (check your manual for location).'), nl,
    write('2: Check the wiring connections.'), nl,
    write('3: If problem persists, replace the headlight assembly.').

engine_overheating :-
    verify(temperature_gauge_high),
    verify(steam_from_engine),
    verify(low_coolant_level),
    nl,
    write('1: Turn off the engine immediately and let it cool.'), nl,
    write('2: Check and refill the coolant (when engine is cool).'), nl,
    write('3: Inspect for leaks in the cooling system.'), nl,
    write('4: Check radiator fan operation.').

/* Action recommendations */
action(dead_battery) :-
    write('Additional Tips:'), nl,
    write('- Battery typically lasts 3-5 years'), nl,
    write('- Consider getting your alternator checked').

action(flat_tire) :-
    write('Additional Tips:'), nl,
    write('- Check tire pressure monthly'), nl,
    write('- Rotate tires every 5,000-8,000 miles').

action(broken_headlight) :-
    write('Additional Tips:'), nl,
    write('- Replace headlights in pairs'), nl,
    write('- Consider upgrading to LED bulbs').

action(engine_overheating) :-
    write('Additional Tips:'), nl,
    write('- Never open radiator cap when hot'), nl,
    write('- Check coolant level weekly').

action(unknown).

/* Ask Questions */
ask(Question) :-
    write('Does your car have this symptom: '),
    write(Question),
    write('? (yes/no): '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      -> assert(yes(Question))
      ;  assert(no(Question)), fail ).

/* Verify Symptoms */
verify(Symptom) :-
    (yes(Symptom) -> true ;
     no(Symptom)  -> fail ;
     ask(Symptom)).

/* Reset the Assertions */
reset :- retract(yes(_)), fail.
reset :- retract(no(_)), fail.
reset.

/* Start the expert system */
:- initialization(start).
