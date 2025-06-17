:- dynamic user_prefers/2.

% Game facts
game('Elden Ring', [ps5, pc, xbox_series_x], action_rpg, fantasy, [open_world, boss_fights, exploration]).
game('Cyberpunk 2077', [ps5, pc, xbox_series_x], action_rpg, sci_fi, [story_driven, open_world, choice_matters]).
game('Assassin\'s Creed Valhalla', [ps5, pc, xbox_series_x], action_rpg, historical, [open_world, combat, exploration]).
game('Baldur\'s Gate 3', [ps5, pc, xbox_series_x], rpg, fantasy, [turn_based, co_op, choice_matters]).
game('Persona 5 Royal', [ps5, pc], rpg, modern, [turn_based, anime_style, story_driven]).
game('The Legend of Zelda: Tears of the Kingdom', [switch], adventure, fantasy, [puzzle, exploration, sandbox]).
game('It Takes Two', [ps5, pc, xbox_series_x], adventure, fantasy, [co_op, puzzle, platformer]).
game('Spider-Man 2', [ps5], action_adventure, modern, [open_world, story_driven, combat]).
game('Ghost of Tsushima', [ps5, pc], action_adventure, historical, [stealth, open_world, samurai]).
game('Star Wars Jedi: Survivor', [ps5, pc, xbox_series_x], action_adventure, sci_fi, [combat, exploration, story_driven]).
game('Call of Duty: Modern Warfare III', [ps5, pc, xbox_series_x], shooter, modern, [multiplayer, fast_paced, campaign]).
game('Valorant', [pc], shooter, modern, [competitive, team_based, multiplayer]).
game('Age of Empires IV', [pc], strategy, historical, [real_time, base_building, multiplayer]).
game('XCOM 2', [ps5, pc, xbox_series_x], strategy, sci_fi, [turn_based, tactics, aliens]).
game('Resident Evil 4 Remake', [ps5, pc, xbox_series_x], horror, modern, [survival, combat, story_driven]).
game('Alan Wake 2', [ps5, pc, xbox_series_x], horror, modern, [psychological, narrative, thriller]).
game('Microsoft Flight Simulator', [pc, xbox_series_x], simulation, realistic, [real_world, exploration, scenic]).
game('The Sims 4', [ps5, pc, xbox_series_x], simulation, modern, [life_sim, customization, sandbox]).
game('Forza Horizon 5', [pc, xbox_series_x], racing, modern, [open_world, multiplayer, customization]).
game('Gran Turismo 7', [ps5], racing, modern, [simulation, competitive, realistic]).

% Entry point
start :-
    clear_preferences,
    write('🎮 Welcome to the Game Recommender Expert System!'), nl,
    select_platform,
    select_genre,
    select_environment,
    nl,
    write('Answer yes or no to the following features:'), nl,
    ask_feature(co_op),
    ask_feature(looter_shooter),
    ask_feature(boss_fights),
    ask_feature(story_driven),
    ask_feature(open_world),
    ask_feature(turn_based),
    ask_feature(multiplayer),
    ask_feature(competitive),
    ask_feature(exploration),
    ask_feature(puzzle),
    ask_feature(stealth),
    ask_feature(simulation),
    ask_feature(racing),
    ask_feature(survival),
    ask_feature(sandbox),
    nl,
    (recommend(Game) ->
        explain_recommendation(Game)
    ;
        write(' Sorry, no matching game found.'), nl
    ),
    clear_preferences.


% Platform selection
select_platform :-
    write('Select your preferred platform:'), nl,
    write('1. PS5'), nl,
    write('2. PC'), nl,
    write('3. Xbox Series X'), nl,
    read_choice(Choice),
    (Choice = "1" -> assert(user_prefers(platform, ps5));
     Choice = "2" -> assert(user_prefers(platform, pc));
     Choice = "3" -> assert(user_prefers(platform, xbox_series_x));
     write('Invalid choice.'), nl, fail).

% Genre selection
select_genre :-
    write('Select your preferred genre:'), nl,
    write('1. RPG'), nl,
    write('2. Action RPG'), nl,
    write('3. Adventure'), nl,
    write('4. Action Adventure'), nl,
    write('5. Shooter'), nl,
    write('6. Strategy'), nl,
    write('7. Horror'), nl,
    write('8. Simulation'), nl,
    write('9. Racing'), nl,
    read_choice(Choice),
    (Choice = "1" -> assert(user_prefers(genre, rpg));
     Choice = "2" -> assert(user_prefers(genre, action_rpg));
     Choice = "3" -> assert(user_prefers(genre, adventure));
     Choice = "4" -> assert(user_prefers(genre, action_adventure));
     Choice = "5" -> assert(user_prefers(genre, shooter));
     Choice = "6" -> assert(user_prefers(genre, strategy));
     Choice = "7" -> assert(user_prefers(genre, horror));
     Choice = "8" -> assert(user_prefers(genre, simulation));
     Choice = "9" -> assert(user_prefers(genre, racing));
     write('Invalid choice.'), nl, fail).


% Environment selection
select_environment :-
    write('Select environment/setting:'), nl,
    write('1. Fantasy'), nl,
    write('2. Sci-fi'), nl,
    write('3. Modern'), nl,
    write('4. Historical'), nl,
    write('5. Realistic'), nl,
    read_choice(Choice),
    (Choice = "1" -> assert(user_prefers(environment, fantasy));
     Choice = "2" -> assert(user_prefers(environment, sci_fi));
     Choice = "3" -> assert(user_prefers(environment, modern));
     Choice = "4" -> assert(user_prefers(environment, historical));
     Choice = "5" -> assert(user_prefers(environment, realistic));
     write('Invalid choice.'), nl, fail).

% Ask for optional features
ask_feature(Feature) :-
    format('Do you want this feature: ~w? (yes/no): ', [Feature]),
    read_choice(Response),
    (Response = "yes" -> assert(user_prefers(feature, Feature)); true).

% Recommendation engine
recommend(Game) :-
    game(Game, Platforms, Genre, Environment, Features),
    user_prefers(platform, P), member(P, Platforms),
    user_prefers(genre, Genre),
    user_prefers(environment, Environment),
    (user_prefers(feature, F) -> member(F, Features); true).

% Explain recommendation
explain_recommendation(Game) :-
    game(Game, Platforms, Genre, Environment, Features),
    user_prefers(platform, Platform),
    format(' Recommended Game: ~w~n', [Game]),
    format(' Platforms: ~w~n', [Platforms]),
    format(' Your Platform: ~w~n', [Platform]),
    format(' Genre: ~w~n', [Genre]),
    format(' Setting: ~w~n', [Environment]),
    format(' Features: ~w~n', [Features]),
    forall(user_prefers(feature, F),
        (member(F, Features) ->
            format(' Includes preferred feature: ~w~n', [F])
        ; format(' Not matched: ~w~n', [F]))).

% Helper: read user input as string
read_choice(Choice) :-
    read_line_to_string(user_input, Choice).

% Cleanup
clear_preferences :- retract(user_prefers(_, _)), fail.
clear_preferences.

:- initialization(start).
