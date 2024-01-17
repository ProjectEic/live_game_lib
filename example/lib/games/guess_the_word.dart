import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';

Widget guessTheWordScreen(BuildContext context, Room r) {
  String currentQuestion = r.data["currentQuestion"] ?? "";
  Map<String, bool> answers = Map<String, bool>.from(r.data["answers"]??<String, bool>{});
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
                  trailing: answers[answeredQuestions[index]]??false?Icon(Icons.check):Icon(Icons.close),
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
        child: Text("Yes"),
        onPressed: () {
          r.ref!.child("answers").child(currentQuestion).set(true);
          r.ref!.child("currentQuestion").set("");
        },
      ),
      ElevatedButton(
        child: Text("No"),
        onPressed: () {
          r.ref!.child("answers").child(currentQuestion).set(false);
          r.ref!.child("currentQuestion").set("");
        },
      ),
      ElevatedButton(
        child: Text("You got it!"),
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
      Text("Type a question: "),
      
      TextField(
        controller: controller,
      ),

      ElevatedButton(
        child: Text("Submit"),
        onPressed: () {
          r.ref!.child("currentQuestion").set(controller.text);
        },
      )
    ],
  );
}