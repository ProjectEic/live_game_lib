import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  final List<String> lobbyMembers;
  final String roomId;
  final bool isCreator;

  const LobbyScreen({
    Key? key,
    required this.lobbyMembers,
    required this.roomId,
    required this.isCreator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
      ),
      body: Column(
        children: [
          Text(roomId),
          Expanded(
            child: ListView.builder(
              itemCount: lobbyMembers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lobbyMembers[index]),
                      if (isCreator)
                        IconButton(
                          onPressed: () {
                            // Logic to remove a member
                          },
                          icon: const Icon(Icons.person_remove),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (isCreator)
            ElevatedButton(
              onPressed: () {
                // Start button logic
              },
              child: Text('Start'),
            ),
        ],
      ),
    );
  }
}
