import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';
import 'package:live_game_lib/backend/room.dart';

class DefaultHome extends StatelessWidget {

  const DefaultHome({
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
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: GameManager.instance.games.keys.map<Widget>((key) {
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
                    '${GameManager.instance.games.keys.toList().indexOf(key) + 1}',
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
                            GameManager.instance.username = text;
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Room r = await GameManager.instance
                                  .createRoom(usernameController.text, key);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GameView(r)));
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
