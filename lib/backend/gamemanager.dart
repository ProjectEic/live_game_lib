import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/game_state_screens/game_not_found.dart';
import 'package:live_game_lib/frontend/game_state_screens/home_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/join_room_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/lobby_screen.dart';

/// A class to manage the games
class GameManager {
  DatabaseReference? _roomsRef;
  DatabaseReference? get roomRef => _roomsRef;

  Map<String, Game> _gameMap = {};

  String username = "";

  String databaseRefStr = "roooms";

  Widget roomNotFoundWidget;

  Widget? homeScreen;

  Widget? joinRoomScreen;

  Widget Function(BuildContext, Room) lobbyScreenGenerator;

  GameManager({
    Map<String, Game> games = const {},
    this.username = "Player",
    String? databaseRefInp,
    Widget? homeScreen,
    Widget? joinRoomScreen,
    this.lobbyScreenGenerator = generateDefaultLobbyScreen,
    this.roomNotFoundWidget = const GameNotFound(),
  }) {
    databaseRefStr = databaseRefInp ?? databaseRefStr;
    _roomsRef = FirebaseDatabase.instance.ref(databaseRefStr);
    _gameMap = games;
    this.homeScreen = homeScreen ?? DefaultHome(this);
    this.joinRoomScreen = joinRoomScreen ?? DefaultJoinRoomScreen(this);
  }

  String addGame(String name, Game gameManagerGetter) {
    _gameMap[name] = gameManagerGetter;
    return name;
  }

  /// Function to get a game prefab
  Game getGame(String name) {
    return _gameMap[name]!;
  }

  Map<String, Game> get games => _gameMap;

  get routes => <String, WidgetBuilder>{
        '/': (context) => homeScreen!,
        '/lobby_screen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return lobbyScreenGenerator(
            context,
            args['room'],
          );
        },
        '/join_room_screen': (context) => joinRoomScreen!,
      };

  Room getRoom(String id) {
    return Room(id, this, lref: _roomsRef!.child(id));
  }

  String generateRandomRoomId() {
    return Random().nextInt(100000).toString();
  }

  /// Function to create a room
  Future<Room> createRoom(String gameName) async {
    DatabaseReference ref = _roomsRef!.child(generateRandomRoomId());
    await ref.set(_gameMap[gameName]!.prefabData);
    return Room(ref.key!, this, lref: ref);
  }
}
