import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';

Widget guessTheWordScreen(Room r) {
  List<String> players = r.players;
  return Scaffold(
      appBar: AppBar(
        title: const Text("Guess the word"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the guess the word game',
            ),
            Column(children: players.map((e) => Text(e)).toList())
          ],
        ),
      ));
}
