
import 'dart:math';

import 'package:example/gamelist.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';
import 'package:live_game_lib/backend/room.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final usernameController = TextEditingController();
  final roomIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:  Center(
        child: SingleChildScrollView(
          
          child: SizedBox(
            width: max(MediaQuery.of(context).size.width * 0.8, 600),

            child: Column(
                  
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'This is the main menu',
                ),
                  
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                  onChanged: (text) {
                    GameManager.instance.username = text;
                  },
                ),
                  
                TextField(
                  controller: roomIDController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Room ID',
                  ),
                ),
                  
                ElevatedButton(
                  onPressed: () {
                    Room r = GameManager.instance.getRoom(roomIDController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameView(r)
                      )
                    );
                    Navigator.pushNamed(context, '/game');
                  }, 
                  child: const Text('Join Game')
                ),
                  
                const Padding(padding:  EdgeInsets.all(10.0)),
                
               
                Column(
                  children: games.keys.map((key) => ElevatedButton(
                    onPressed: () async {
                      Room r = await GameManager.instance.createRoom(usernameController.text, key);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameView(r)
                        )
                      );
                    }, 
                    child: Text(key)
                  )).toList()
                )
                
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
