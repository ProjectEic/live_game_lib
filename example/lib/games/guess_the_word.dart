import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';

Widget guessTheWordScreen(BuildContext context, Room r) {
  String currentQuestion = r.getString("currentQuestion");
  Map<String, bool> answers = Map<String, bool>.from(r.getMap("answers"));
  List<String> answeredQuestions = answers.keys.toList();
  
  return Scaffold(
    appBar: AppBar(
      title: const Text("Guess the word"),
    ),
    body: Center(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the guess the word game',
            ),
            const Text("Answered questions:"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: answeredQuestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(answeredQuestions[index]),
                  subtitle: Text("Answer: ${(answers[answeredQuestions[index]]!)?"Yes":"No"}"),
                  trailing: answers[answeredQuestions[index]]??false?const Icon(Icons.check):const Icon(Icons.close),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(10),),
            Text(currentQuestion!=""?"Waiting for Question":"No question yet!"),
            Text(currentQuestion),
            const Padding(padding: EdgeInsets.all(10),),
                  r.amAdmin()?getAdminView(context, r, currentQuestion):getNonAdminView(context, r, currentQuestion),
          ],
        ),
      ),
    )
  );
}

Widget getAdminView(BuildContext b, Room r, String currentQuestion) {
  if (currentQuestion == "") {
    return Container();
  }
  return Column(
    children: [
      ElevatedButton(
        child: const Text("Yes"),
        onPressed: () {
          r.set("answers/$currentQuestion", false);
          r.set("currentQuestion", "");
        },
      ),
      ElevatedButton(
        child: const Text("No"),
        onPressed: () {
          r.set("answers/$currentQuestion", false);
          r.set("currentQuestion", "");
        },
      ),
      ElevatedButton(
        child: const Text("You got it!"),
        onPressed: () {
          r.goBackToLobby();
        },
      )
    ],
  );
}

Widget getNonAdminView(BuildContext b, Room r, String currentQuestion) {
  TextEditingController controller = TextEditingController();
  if (currentQuestion != "") {
    return Container();
  }
  return Column(
    children: [
      const Text("Type a question: "),
      
      TextField(
        controller: controller,
      ),

      ElevatedButton(
        child: const Text("Submit"),
        onPressed: () {
          r.set("currentQuestion", controller.text);
        },
      )
    ],
  );
}