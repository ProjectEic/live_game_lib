import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/room.dart';

class GameManager {

  static GameManager? _instance;

  DatabaseReference? _roomsRef;

  Map<String, Game> _gameMap = {};

  String username = "";

  Widget roomNotFoundWidget;

  GameManager( this.roomNotFoundWidget, { Map<String, Game> gm = const {}}) {
    if (_instance != null) {
      throw Exception("GameManager already initialized");
    }
    _instance = this;
    _roomsRef = FirebaseDatabase.instance.ref("rooms");
    _gameMap = gm;
  }

  String addGame(String name, Game gameManagerGetter) {
    _gameMap[name] = gameManagerGetter;
    return name;
  }

  Game getGame(String name) {
    return _gameMap[name]!;
  }
  
  static GameManager get instance {
    if (_instance == null) {
      throw Exception("GameManager not initialized");
    }
    return _instance!;
  }


  Room getRoom(String id) {
    return Room(id, lref: _roomsRef!.child(id));
  }

  Future<Room> createRoom(String adminId, String gameName) async {
    DatabaseReference ref = _roomsRef!.push();
    await ref.set(_gameMap[gameName]!.prefabData);
    return Room(ref.key!, lref: ref, adminId: adminId);
  }


}
