import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';



class GameView extends StatefulWidget {

  final Room room;

  const GameView(this.room, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameState(room);
  }
}


class _GameState extends State<GameView> {
  Room room;

  _GameState(this.room);

  @override
  Widget build(BuildContext context) {
    if (!room.joined(GameManager.instance.username)) {
      room.addDataListener(
        (data) { setState(() {}); }
      );
      room.join(GameManager.instance.username);
      setState(() {});
    }
    String? gameName = room.data["name"] as String?;
    if (gameName == null) {
      return GameManager.instance.roomNotFoundWidget;
    }
    Game game = GameManager.instance.getGame(gameName);
    return game.screen(room);
  }
}