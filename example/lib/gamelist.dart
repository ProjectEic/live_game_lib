

import 'package:example/games/guess_the_word.dart';
import 'package:live_game_lib/backend/game_prefab.dart';

Map<String, Game> games = {
    "word_guess": Game(
      {
        "name": "word_guess",
      
      },
      guessTheWordScreen,

    ),

};