import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/room.dart';

class Game {

  Map<String, dynamic>? prefabData = {};

  String name;

  bool usesLobby;

  bool canPostjoin;

  int? maxPlayers;

  Widget Function(BuildContext, Room) screen;

  Game(this.name, this.screen, 
  {

    this.usesLobby = true,
    this.canPostjoin = true,
    this.prefabData,
    this.maxPlayers,
  }) {
    this.prefabData = prefabData ?? {};
    prefabData!["gameName"] = name;
    prefabData!["players"] = <String, dynamic>{};
    prefabData!["admin"] = "";

    if (usesLobby || maxPlayers != null) {
      prefabData!["inLobby"] = true;
      prefabData!["waitingPlayers"] = <String, dynamic>{};
    }

  }


}