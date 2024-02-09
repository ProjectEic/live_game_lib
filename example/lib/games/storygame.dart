import 'dart:math';

import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/buttons/button_instance.dart';
import 'package:live_game_lib/frontend/buttons/button_list.dart';
import 'package:live_game_lib/frontend/inputs/text_field_with_submit.dart';
import 'package:live_game_lib/frontend/text/headline.dart';
import 'package:live_game_lib/frontend/text/sub_heading.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_evenly.dart';
import 'package:live_game_lib/frontend/wrapper/scaffold_min_width.dart';

Widget StroyGame(BuildContext context, Room r) {
  // 3 phase: add_words, create_story, end
  String phase = r.getString("phase") ?? "add_words";
  return ScaffoldMinWidth(
      
    title: const Text("Story Game"),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column (
          children: [
            if (phase == "add_words") addWordScreen(context, r),
            if (phase == "create_story") createStoryScreen(context, r),
            if (phase == "end") endScreen(context, r),
          ],
        ),
      ),
    ),
  );
}

TextEditingController wordController = TextEditingController();
Widget addWordScreen(BuildContext context, Room r) {
  return Container(
    child: Center(
      child: ColumnSpaceEvenly(
        children: [
          const Headline(
            text: "Add words",
          ),
          TextFieldWithSubmit(
            controller: wordController,
            onPressed: (String word) {
              r.addToList("words", word);
              wordController.clear();
            },
          ),
          const Padding(padding: EdgeInsets.all(10)),
          if (r.amAdmin) ElevatedButton(
              child: const Text("Start Game"),
              onPressed: () {
                r.set("phase", "create_story");
              },
            )
          
          
        ],
      ),
    ),
  );
}

Widget createStoryScreen(BuildContext context, Room r) {
  List<String> words = List<String>.from(r.getList("words"));
  List<String> players = r.players;
  int currentTurn = r.getInt("currentTurn") ?? 0;
  int seed = r.id.hashCode;
  // shuffle the words by seed and the players 
  words.shuffle(Random(seed));
  players.shuffle(Random(seed));
  String currentWord = words[currentTurn];
  String currentPlayer = players[currentTurn % players.length];

  return Container(
    child: Center(
      child: ColumnSpaceEvenly(
        children: <Widget>[
          const Headline(
            text: "Create story",
          ),
          SubHeading(
            text: "Current word: $currentWord",
          ),
          SubHeading(
            text: "Current player: $currentPlayer",
          ),
          if (r.amAdmin)
            ButtonList(
              buttonStyle: ButtonStyle(),
              buttons: [
                Button(
                  label: "Last",
                  onPressed: () {
                    if (currentTurn > 0) {
                      r.set("currentTurn", currentTurn - 1);
                    } else {
                      r.set("phase", "add_words");
                    }
                  },
                ),
                Button(
                  label: "Next",
                  onPressed: () {
                    if(currentTurn < words.length - 1) {
                      r.set("currentTurn", currentTurn + 1);
                    } else {
                      r.set("phase", "end");
                    }
                  },
                ),
              ], 
            ),
        ]
      ),
    ),
  );
}

Widget endScreen(BuildContext context, Room r) {
  return Container(
    child: Center(
      child: ColumnSpaceEvenly(
        children: <Widget>[
          const Headline(
            text: "End of the game",
          ),
          ButtonList(
            buttonStyle: ButtonStyle(),
            buttons: [
              Button(
                label: "Last",
                onPressed: () {
                  r.set("phase", "create_story");       
                },
              ),
              Button(
                label: "Restart the Game",
                onPressed: () {
                  r.set("phase", "add_words");
                },
              ),
            ], 
          ),
        ],
      ),
    ),
  );
}