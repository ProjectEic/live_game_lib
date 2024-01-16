import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';



class GameView extends StatefulWidget {

  final Room room;
  final GameManager gameMa;

  const GameView(this.room, this.gameMa, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _GameState(room, gameMa);
  }
}


class _GameState extends State<GameView> {
  final Room room;
  final GameManager gameManager;

  _GameState(this.room, this.gameManager);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    room.addDataListener(
        (data) { 
          setState(() {}); 
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    if (!room.joined(gameManager.username)) {
      room.join(gameManager.username);
    }

    String? gameName = room.data["gameName"] as String?;
    if (gameName == null) {
      return gameManager.roomNotFoundWidget;
    }

    if (room.inLobby) {
      return gameManager.lobbyScreenGenerator(context, room);
    }

    Game game = gameManager.getGame(gameName);
    return game.screen(room);
  }
}