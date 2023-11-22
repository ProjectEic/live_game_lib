import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';



class GameView extends StatefulWidget {

  final String roomid;

  const GameView(this.roomid, {super.key});

  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}


class GameState extends State<GameView> {
  Room? room;

  void loadRoom() async {
    room = Room(widget.roomid);
    room!.addDataListener((data) {
      setState(() { 
      });
    });
    setState(() { 
    });
  }

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      loadRoom();
      return GameManager.instance.roomLoadingWidget;
    }
    String gameName = room!.data["gameName"];
    Game game = GameManager.instance.getGame(gameName);
    return game.screen(room!);
  }
}