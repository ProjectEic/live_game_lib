import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';



class GameView extends StatefulWidget {

  final Room room;

  const GameView(this.room, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _GameState(room);
  }
}


class _GameState extends State<GameView> {
  final Room room;

  _GameState(this.room);

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

    if (!room.joined(GameManager.instance.username)) {
      room.join(GameManager.instance.username);
    }

    String? gameName = room.data["gameName"] as String?;
    if (gameName == null) {
      return GameManager.instance.roomNotFoundWidget;
    }

    if (room.inLobby) {
      return GameManager.instance.lobbyScreenGenerator(context, room);
    }

    Game game = GameManager.instance.getGame(gameName);
    return game.screen(room);
  }
}