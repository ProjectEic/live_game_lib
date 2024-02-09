import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
import 'package:live_game_lib/frontend/inputs/text_field_with_submit.dart';
import 'package:live_game_lib/frontend/text/headline.dart';
import 'package:live_game_lib/frontend/buttons/button_list.dart';
import 'package:live_game_lib/frontend/buttons/button_instance.dart';
import 'package:live_game_lib/frontend/text/sub_heading.dart';
import 'package:live_game_lib/frontend/wrapper/flex/column_space_evenly.dart';
import 'package:live_game_lib/frontend/wrapper/scaffold_min_width.dart';

Widget guessTheWordScreen(BuildContext context, Room r) {
  String currentQuestion = r.getString("currentQuestion") ?? "";
  Map<String, bool> answers = r.getMap("answers");
  List<String> answeredQuestions = answers.keys.toList();

  return ScaffoldMinWidth(
    title: const Text("Guess the word"),
    body: Center(
      child: ColumnSpaceEvenly(
        children: <Widget>[
          const Headline(
            text: "This is the guess the word game",
          ),
          r.amAdmin
              ? getAdminView(context, r, currentQuestion)
              : getNonAdminView(context, r, currentQuestion),
          const SubHeading(text: "Answered questions:"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: answeredQuestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(answeredQuestions[index]),
                subtitle: Text(
                    "Answer: ${(answers[answeredQuestions[index]]!) ? "Yes" : "No"}"),
                trailing: answers[answeredQuestions[index]] ?? false
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          SubHeading(
              text: currentQuestion != ""
                  ? "Waiting for Question"
                  : "No question yet!"),
          Text(currentQuestion),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    ),
  );
}

Widget getAdminView(BuildContext b, Room r, String currentQuestion) {
  if (currentQuestion == "") return Container();

  List<Button> buttons = [
    Button(
      label: "Yes",
      onPressed: () {
        r.set("answers/$currentQuestion", true);
        r.set("currentQuestion", "");
      },
    ),
    Button(
      label: "No",
      onPressed: () {
        r.set("answers/$currentQuestion", false);
        r.set("currentQuestion", "");
      },
    ),
    Button(
      label: "You got it!",
      onPressed: () {
        r.goBackToLobby();
      },
    ),
  ];

  return ButtonList(
    buttons: buttons,
    buttonStyle: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 20, color: Theme.of(b).colorScheme.onPrimary),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Theme.of(b).colorScheme.primary),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(
        Theme.of(b).colorScheme.primaryContainer,
      ),
    ),
  );
}

Widget getNonAdminView(BuildContext b, Room r, String currentQuestion) {
  if (currentQuestion != "") return Container();
  return Column(
    children: [
      const Headline(text: "Type a question: "),
      TextFieldWithSubmit(
        onPressed: (String word) {
          r.set(
            "currentQuestion",
            word,
          );
        },
        hintText: "Enter your question here",
      ),
    ],
  );
}
