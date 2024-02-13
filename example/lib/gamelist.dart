import 'package:example/games/guess_the_word.dart';
import 'package:example/games/storygame.dart';
import 'package:example/games/mau_mau.dart';
import 'package:live_game_lib/backend/game_prefab.dart';

/// A map containing various games supported by the application.
Map<String, Game> games = {
  "word guess": Game(
    "word guess",
    guessTheWordScreen,
    usesLobby: true,
    canPostjoin: true,
  ),
  "story game": Game(
    "story game",
    storyGame,
    usesLobby: false,
    canPostjoin: true,
  ),
  "mau mau": Game(
    "mau mau",
    mauMau,
    usesLobby: true,
    canPostjoin: true,
  )
};
