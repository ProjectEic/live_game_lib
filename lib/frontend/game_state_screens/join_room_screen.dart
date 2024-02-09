// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';

/// A StatefulWidget representing the default screen for joining a room.
class DefaultJoinRoomScreen extends StatefulWidget {
  /// The GameManager instance managing the games.
  final GameManager gameManager;

  /// Constructs a [DefaultJoinRoomScreen] widget.
  ///
  /// The [gameManager] parameter is required and represents the GameManager instance.
  const DefaultJoinRoomScreen(
    this.gameManager, {
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultJoinRoomScreen> createState() =>
      _JoinRoomScreenState(gameManager);
}

class _JoinRoomScreenState extends State<DefaultJoinRoomScreen> {
  final usernameController = TextEditingController();
  final roomIDController = TextEditingController();
  final GameManager gameManager;

  /// Constructs the state for [DefaultJoinRoomScreen].
  ///
  /// The [gameManager] parameter is required and represents the GameManager instance.
  _JoinRoomScreenState(this.gameManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Join Room",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.extension, // perhaps adjust
                size: 150,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Column(
                children: [
                  TextField(
                    controller: roomIDController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Room ID',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                    onChanged: (text) {
                      gameManager.username = text;
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Room r = gameManager.getRoom(roomIDController.text);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => r.getGameView()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Join Game',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
