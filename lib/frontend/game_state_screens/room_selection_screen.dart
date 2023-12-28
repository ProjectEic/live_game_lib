import 'package:flutter/material.dart';

class RoomSelectionScreen extends StatelessWidget {
  final ThemeData theme;

  const RoomSelectionScreen({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Room Selection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  backgroundColor: theme.colorScheme.onBackground,
                ),
                onPressed: () {
                  // Navigate to LobbyScreen as a creator
                  Navigator.pushNamed(
                    context,
                    '/lobby_screen',
                    arguments: {
                      'roomId': generateRandomRoomId(), // Generate a room ID
                      'lobbyMembers': [
                        "me"
                      ], // Empty member list for a new lobby
                      'isCreator': true,
                    },
                  );
                },
                child: Text(
                  'Create a Room',
                  style: TextStyle(
                    color: theme.colorScheme.surface,
                    fontSize: theme.textTheme.titleLarge!.fontSize,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  backgroundColor: theme.colorScheme.onBackground,
                ),
                onPressed: () {
                  // Navigate to LobbyScreen as a participant
                  Navigator.pushNamed(
                    context,
                    '/join_room_screen',
                    arguments: {
                      'roomId': '',
                      'lobbyMembers': [],
                      'isCreator': false,
                    },
                  );
                },
                child: Text(
                  'Join a Room',
                  style: TextStyle(
                    color: theme.colorScheme.surface,
                    fontSize: theme.textTheme.titleLarge!.fontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String generateRandomRoomId() {
    return 'Room-${DateTime.now().millisecondsSinceEpoch}';
  }
}
