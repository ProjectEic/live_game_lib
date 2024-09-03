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

  Room(this._id, this.gameManager, {DatabaseReference? lref}) {
    if (lref == null) {
      ref = gameManager.roomRef!.child(_id);
    } else {
      ref = lref;
    }
   
    _dbListen();


    addDataListener((d) {
      data = d;
    });

    addDataListener((newData) async {
      if ((!players.contains(adminId) || adminId=="") && players.isNotEmpty && players.first == gameManager.username) {
        // wait 0.5 seconds
        await Future.delayed(const Duration(milliseconds: 500));
        ref!.child("admin").set(players.first);
      }
    });
   
  }

  /// returns the view of the game
  Widget getGameView() {
    return GameView(this, gameManager);
  }


  List<void Function(Map<String, dynamic> data)?> listeners = [];

  /// Function to add a listener to the room
  void addDataListener(void Function(Map<String, dynamic> data)? onValue) {
    listeners.add(onValue);
    
  }
  
  void _dbListen() {
    ref?.onValue.listen((event) {
      for (void Function(Map<String, dynamic> data)? listener in listeners) {
        listener!(Map<String, dynamic>.from((event.snapshot.value ?? <String, dynamic>{}) as Map));
      }
    });
  }

  /// A list of players in the room
  List<String> get players => getPlayers();

  List<String> getPlayers() {
    try {
      return Map<String, dynamic>.from((data["players"] ?? <String, dynamic>{}) as Map)
          .keys
          .toList();
    } catch (e) {
      return List<String>.generate(
          ((data["players"] as List<dynamic>).length / 2).ceil(),
          (index) => (index + 1).toString());
    }
  }

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
  bool get amAdmin => adminId == myId;

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

  /// Function to remove a value from a list in the room
  void removeFromList<T>(String key, T value) {
    // Find the key of the value
    for (MapEntry<String, dynamic> entry in getMap(key).entries) {
      if (entry.value == value) {
        ref!.child(key).child(entry.key).remove();
        return;
      }
    }
  }

  /// Function to get a value from the room
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
  Future join(String myName) async {
    String? n = ((await ref!.child("gameName").get()).value as String?);
    if (n == null) {
      return;
    }

    if (!gameManager.getGame(n).usesLobby ||
        gameManager.getGame(n).canPostjoin ||
        inLobby ||
        players.length <
            (gameManager.getGame(n).maxPlayers ?? (players.length + 1))) {
      myDataRef = ref!.child("players").child(myName.toString());
      myDataRef.set(true);
      myDataRef.onDisconnect().remove();
    } else {
      myDataRef = ref!.child("waitingPlayers").child(myName.toString());
      myDataRef.set(true);
      myDataRef.onDisconnect().remove();
      ref!.child("inLobby").onValue.listen((event) {
        if (event.snapshot.value == true) {
          myDataRef.remove();
          myDataRef = ref!.child("players").child(myName.toString());
          myDataRef.set(true);
          myDataRef.onDisconnect().remove();
        }
      });
    }

    if ((!players.contains(adminId) || adminId=="") && players.isNotEmpty) {
      ref!.child("admin").set(players.first);
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
