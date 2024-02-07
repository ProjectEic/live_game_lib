import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/room.dart';

/// A class to represent a game prefab
class Game {
  Map<String, dynamic>? prefabData = {};

  String name;

  bool usesLobby;

  bool canPostjoin;

  int? maxPlayers;

  Widget Function(BuildContext, Room) screen;

  /// A class to represent a game prefab
  /// @param name The name of the game
  /// @param screen The screen to display for the game
  /// @param usesLobby Whether the game uses a lobby
  /// @param canPostjoin Whether the game can be joined after it has started
  /// @param prefabData The data to be used for the game
  /// @param maxPlayers The maximum number of players for the game
  /// @returns A game prefab
  Game(
    this.name,
    this.screen, {
    this.usesLobby = true,
    this.canPostjoin = true,
    this.prefabData,
    this.maxPlayers,
  }) {
    prefabData = prefabData ?? {};
    prefabData!["gameName"] = name;
    prefabData!["players"] = <String, dynamic>{};
    prefabData!["admin"] = "";

    if (usesLobby || maxPlayers != null) {
      prefabData!["inLobby"] = true;
      prefabData!["waitingPlayers"] = <String, dynamic>{};
    }
  }
}
