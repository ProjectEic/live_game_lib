import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';


/// A class to represent a room
class Room {
  final String _id;

  final GameManager gameManager;

  DatabaseReference? ref;

  // holds the current json data of the Room
  Map<String, dynamic> data = {};

  late DatabaseReference myDataRef;

  Room(this._id, this.gameManager, {DatabaseReference? lref, String? adminId}) {
    if (lref == null) {
      ref = gameManager.roomRef!.child(_id);
    } else {
      ref = lref;
    }
    // auto set admin
    addDataListener((data) {
      if (!players.contains(adminId) && players.isNotEmpty) {
        ref!.child("admin").set(players.first);
      }
    });

    addDataListener((d) {
      data = d;
    });
  }

  Widget getGameView() {
    return GameView(this, gameManager);
  }

  void addDataListener(void Function(Map<String, dynamic> data)? onValue) {
    ref?.onValue.listen((event) {
      data =
          (event.snapshot.value ?? <String, dynamic>{}) as Map<String, dynamic>;
      if (onValue != null) {
        onValue(data);
      }
    });
  }

  /// A list of players in the room
  List<String> get players =>
      ((data["players"] ?? <String, dynamic>{}) as Map<String, dynamic>)
          .keys
          .toList();

  /// The name of the current game
  String get gameName => (data["gameName"] ?? "") as String;

  /// The admin of the room
  String get adminId => (data["admin"] ?? "") as String;

  /// The id of the current user
  String get myId => gameManager.username;

  /// Whether the room is in the lobby
  bool get inLobby => (data["inLobby"] ?? false) as bool;
  
  /// The id of the room
  String get id => _id;

  /// Whether the sone user is the admin
  bool isAdmin(String uid) {
    return adminId == uid;
  }

  /// Whether the current user is the admin
  bool amAdmin() {
    return isAdmin(gameManager.username);
  }

  /// Function to start the game
  Future<bool> startGame() {
    return ref!.child("inLobby").set(false).then((value) => true);
  }

  /// Function to go back to the lobby
  Future<bool> goBackToLobby() {
    return ref!.child("inLobby").set(true).then((value) => true);
  }

  /// Function to set a value of a key in the room
  Future<bool> set(String key, dynamic value) {
    return ref!.child(key).set(value).then((value) => true);
  }

  /// Function to add a value to a list in the room
  Future<bool> addToList(String key, dynamic value) {
    return ref!.child(key).push().set(value).then((value) => true);
  }

  dynamic getKey(String key) {
    dynamic cdata = data;
    for (String k in key.split("/")) {
      cdata = cdata[k] as dynamic;
      if (cdata == null) {
        return null;
      }
    }
    return cdata;
  }

  /// Function to get a map from the room
  Map<String, T> getMap<T>(String key) {
    var cdata = getKey(key);
    if (cdata == null) {
      return {};
    }
    return Map<String, T>.from(cdata as Map<String, dynamic>);
  }

  /// Function to get a list from the room
  List getList<T>(String key) {
    var cdata = getKey(key);
    if (cdata == null) {
      return [];
    }
    return List<T>.from(cdata.values.toList());
  }

  /// Function to get a string from the room
  String? getString(String key) {
    var cdata = getKey(key);
    try {
      return cdata as String;
    } catch (e) {
      return null;
    }
  }

  /// Function to get a bool from the room
  bool? getBool(String key) {
    var cdata = getKey(key);
    try {
      return cdata as bool;
    } catch (e) {
      return null;
    }
  }

  /// Function to get a double from the room
  double? getDouble(String key) {
    var cdata = getKey(key);
    try {
      return cdata as double;
    } catch (e) {
      return null;
    }
  }

  /// Function to get an int from the room
  int? getInt(String key) {
    var cdata = getKey(key);
    try {
      return cdata as int;
    } catch (e) {
      return null;
    }
  }

  /// Function to get a value from the room
  T? get<T>(String key) {
    var cdata = getKey(key);
    try {
      return cdata as T;
    } catch (e) {
      return null;
    }
  }

  /// Function to join the room
  void join(String myName) async {
    String? n = ((await ref!.child("gameName").get()).value as String?);
    if (n == null) {
      return;
    }

    if (!gameManager.getGame(n).usesLobby ||
        gameManager.getGame(n).canPostjoin ||
        inLobby ||
        players.length <
            (gameManager.getGame(n).maxPlayers ?? (players.length + 1))) {
      myDataRef = ref!.child("players").child(myName);
      myDataRef.set(true);
      myDataRef.onDisconnect().remove();
    } else {
      myDataRef = ref!.child("waitingPlayers").child(myName);
      myDataRef.set(true);
      myDataRef.onDisconnect().remove();
      ref!.child("inLobby").onValue.listen((event) {
        if (event.snapshot.value == true) {
          myDataRef.remove();
          myDataRef = ref!.child("players").child(myName);
          myDataRef.set(true);
          myDataRef.onDisconnect().remove();
        }
      });
    }

    if (adminId == "") {
      if (!players.contains(adminId) && players.isNotEmpty) {
        ref!.child("admin").set(players.first);
      }
    }
  }

  /// Function to check if a user has joined the room
  bool joined(String uid) {
    return players.contains(uid);
  }
  
  /// Function to leave a room
  Future<void> disconnect() async {
    await myDataRef.remove();
    // if (players.isEmpty) {
    //   await ref!.remove();
    // } else
    if (adminId == gameManager.username) {
      await ref!.child("admin").set(players.first);
    }
  }
}
