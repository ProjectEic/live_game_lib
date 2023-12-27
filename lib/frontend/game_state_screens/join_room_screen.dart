import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/backend/gamstate.dart';
import 'package:live_game_lib/backend/room.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({
    Key? key,
    required this.title,
    required this.theme,
  }) : super(key: key);

  final String title;
  final ThemeData theme;

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final usernameController = TextEditingController();
  final roomIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  GameManager.instance.username = text;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Room r = GameManager.instance.getRoom(roomIDController.text);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GameView(r),
                    ),
                  );
                  Navigator.pushNamed(context, '/game');
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
                  backgroundColor: widget.theme.primaryColor,
                ),
                child: Text(
                  'Join Game',
                  style: TextStyle(
                    fontSize: widget.theme.textTheme.bodyMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: widget.theme.colorScheme.onPrimary,
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
