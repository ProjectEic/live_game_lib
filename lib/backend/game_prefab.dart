import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/room.dart';

class Game {

  Map<String, dynamic> prefabData = {};

  Widget Function(Room) screen;

  Game(this.prefabData, this.screen);


}