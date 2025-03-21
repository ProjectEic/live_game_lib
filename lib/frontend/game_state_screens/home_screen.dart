// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/room.dart';

/// The default home screen displaying a list of available games and an option to join a room.
class DefaultHome extends StatelessWidget {
  /// The GameManager instance managing the games.
  final GameManager gameManager;

  /// Constructs a [DefaultHome] widget.
  ///
  /// The [gameManager] parameter is required and represents the GameManager instance.
  const DefaultHome(
    this.gameManager, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Theme.of(context).colorScheme.onSurface,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: gameManager.games.keys.map<Widget>((key) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                title: Text(
                  key,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Tap to play $key',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    '${gameManager.games.keys.toList().indexOf(key) + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final usernameController = TextEditingController();
                      return AlertDialog(
                        title: const Text('Enter Your Username'),
                        content: TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your username',
                          ),
                          onChanged: (text) {
                            gameManager.username = text;
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Room r = await gameManager.createRoom(key);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => r.getGameView()));
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/join_room_screen');
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 30,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Join a Room',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
