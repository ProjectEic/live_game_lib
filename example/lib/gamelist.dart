import 'package:example/games/guess_the_word.dart';
import 'package:example/games/storygame.dart';
import 'package:live_game_lib/backend/game_prefab.dart';

Map<String, Game> games = {
  "word guess": Game(
    "word guess",
    guessTheWordScreen,
    usesLobby: true,
    canPostjoin: true,
  ),
  "story game": Game(
    "story game",
    StroyGame,
    usesLobby: false,
    canPostjoin: true,
  ),
};
