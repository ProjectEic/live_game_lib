import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/game_state_screens/create_lobby_options_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/home_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/join_room_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/lobby_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/room_selection_screen.dart';

class GameManager {

  static GameManager? _instance;

  DatabaseReference? _roomsRef;

  Map<String, Game> _gameMap = {};

  String username = "";

  Widget roomNotFoundWidget;

  Widget homeScreen;

  Widget joinRoomScreen;

  Widget Function(BuildContext, Room) lobbyScreenGenerator;

  Widget lobbyOptionsScreen;

  GameManager( 
    this.roomNotFoundWidget, // ToDo create default widget
    { 
      Map<String, Game> gm = const {},
      this.username = "Player",
      this.homeScreen = const DefaultHome(),
      this.joinRoomScreen = const DefaultJoinRoomScreen(),
      this.lobbyScreenGenerator = generateDefaultLobbyScreen,
      this.lobbyOptionsScreen =  const CreateLobbyOptionsScreen(),
  
    }
  ) {
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

  Map<String, Game> get games => _gameMap;


  get routes => <String, WidgetBuilder> {
    '/': (context) => homeScreen,
    '/lobby_screen': (context) {
      final args = ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>;
      return lobbyScreenGenerator(
        context,
        args['room'],
      );
    },
    '/room_selection_screen': (context) => RoomSelectionScreen(),
    '/join_room_screen': (context) => joinRoomScreen,
    '/create_lobby_options': (context) => lobbyOptionsScreen,
  };
  
  static GameManager get instance {
    if (_instance == null) {
      throw Exception("GameManager not initialized");
    }
    return _instance!;
  }


  Room getRoom(String id) {
    return Room(id, lref: _roomsRef!.child(id));
  }

  String generateRandomRoomId() {
    return Random().nextInt(100000).toString();
  }

  Future<Room> createRoom(String adminId, String gameName) async {
    DatabaseReference ref = _roomsRef!.child(generateRandomRoomId());
    await ref.set(_gameMap[gameName]!.prefabData);
    return Room(ref.key!, lref: ref, adminId: adminId);
  }


}
