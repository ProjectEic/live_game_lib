import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_game_lib/backend/room.dart';

Widget guessTheWordScreen(Room r) {
  List<String> players = ((r.data["players"]??Map<String, dynamic>())  as Map<String, dynamic>).keys.toList();
  return Scaffold(
    appBar: AppBar(
      title: const Text("Guess the word"),
    ),
    body:  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'This is the guess the word game',
          ),

          Column(
              children: players.map((e) => Text(e)).toList()
          )
        ],
      ),
    )
  );
}