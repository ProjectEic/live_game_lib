import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';

class Room {
  final String _id;

  final GameManager gameManager;

  DatabaseReference? ref;
  Map<String, dynamic> data = {};

  late DatabaseReference myDataRef;

  Room(this._id, this.gameManager, {DatabaseReference? lref, String? adminId}) {
    if (lref == null) {
      ref = FirebaseDatabase.instance.ref("rooms").child(_id);
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

      data = (event.snapshot.value??<String, dynamic>{}) as Map<String, dynamic>;
      if (onValue != null) {
        onValue(data);
      }
    });
  }

  List<String> get players =>
      ((data["players"] ?? <String, dynamic>{}) as Map<String, dynamic>)
          .keys
          .toList();
  
  String get gameName => (data["gameName"]??"") as String;

  String get adminId => (data["admin"] ?? "") as String;

  bool get inLobby => (data["inLobby"] ?? false) as bool;

  String get id => _id;

  bool isAdmin(String uid) {
    return adminId == uid;
  }

  bool amAdmin() {
    return isAdmin(gameManager.username);
  }

  Future<bool> startGame() {
    return ref!.child("inLobby").set(false).then((value) => true);
  }

  Future<bool> goBackToLobby() {
    return ref!.child("inLobby").set(true).then((value) => true);
  }

  Future <bool> set(String key, dynamic value) {
    return ref!.child(key).set(value).then((value) => true);
  }

  Future<bool> addToList(String key, dynamic value) {
    return ref!.child(key).push().set(value).then((value) => true);
  }

  dynamic getKey(String key) {
    var cdata = data;
    for(String k in key.split("/")) {
      cdata = (cdata[k]??<String, dynamic>{}) as dynamic;
    }
    return cdata;
  }

  Map<String, T> getMap<T>(String key) {
    var cdata = getKey(key);
    return Map<String, T>.from(cdata as Map<String, dynamic>);
  }

  List getList<T>(String key) {
    var cdata = getKey(key);
    return List<T>.from(cdata.values.toList());
  }

  String? getString(String key) {
    var cdata =  getKey(key);
    try {
      return cdata as String;
    } catch (e) {
      return null;
    }
  }

  bool? getBool(String key) {
    var cdata =  getKey(key);
    try {
      return cdata as bool;
    } catch (e) {
      return null;
    }
  }

  double? getDouble(String key) {
    var cdata =  getKey(key);
    try {
      return cdata as double;
    } catch (e) {
      return null;
    }
  }

  int? getInt(String key) {
    var cdata =  getKey(key);
    try {
      return cdata as int;
    } catch (e) {
      return null;
    }
  }

  T? get<T> (String key) {
    var cdata =  getKey(key);
    try {
      return cdata as T;
    } catch (e) {
      return null;
    } 
  }


  void join(String myName) async {

    String? n = ((await ref!.child("gameName").get()).value as String?);
    if (n==null) {
      return;
    }

    if (!gameManager.getGame(n).usesLobby || gameManager.getGame(n).canPostjoin || inLobby || players.length < (gameManager.getGame(n).maxPlayers??(players.length+1))) {
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

  bool joined(String uid) {
    return players.contains(uid);
  }

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
