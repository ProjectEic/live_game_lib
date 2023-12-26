import 'package:flutter/material.dart';

class RoomSelectionScreen extends StatelessWidget {
  const RoomSelectionScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Selection'),
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
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.grey.shade900,
                ),
                onPressed: () {
                  // Navigate to LobbyScreen as a creator
                  Navigator.pushNamed(
                    context,
                    '/lobby_screen',
                    arguments: {
                      'roomId': generateRandomRoomId(), // Generate a room ID
                      'lobbyMembers': [], // Empty member list for a new lobby
                      'isCreator': true,
                    },
                  );
                },
                child: const Text('Create a Room'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.grey.shade900,
                ),
                onPressed: () {
                  // Navigate to LobbyScreen as a participant
                  Navigator.pushNamed(
                    context,
                    '/lobby_screen',
                    arguments: {
                      'roomId':
                          '', // Can be handled as input by the participant
                      'lobbyMembers': [], // Empty member list for a new lobby
                      'isCreator': false,
                    },
                  );
                },
                child: const Text('Join a Room'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String generateRandomRoomId() {
    // Logic to generate a random room ID (you can implement your own logic)
    return 'Room-${DateTime.now().millisecondsSinceEpoch}';
  }
}
