import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';

class Room {
  final String _id;

  DatabaseReference? ref;
  Map<String, dynamic> data = {};

  late DatabaseReference myDataRef;

  Room(this._id, {DatabaseReference? lref, String? adminId}) {
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
    return GameView(this);
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


  Future<bool> startGame() {
    return ref!.child("inLobby").set(false).then((value) => true);
  }

  Future<bool> goBackToLobby() {
    return ref!.child("inLobby").set(true).then((value) => true);
  }



  void join(String myName) async {

    String? n = ((await ref!.child("gameName").get()).value as String?);
    if (n==null) {
      return;
    }

    if (!GameManager.instance.getGame(n).usesLobby || GameManager.instance.getGame(n).canPostjoin || inLobby) {
      myDataRef = ref!.child("players").child(myName);
      myDataRef.set(true);
      myDataRef.onDisconnect().remove();
      return;
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
      return;
    }

  }

  bool joined(String uid) {
    return players.contains(uid);
  }

  Future<void> disconnect() async {
    await myDataRef.remove();
  }

}
