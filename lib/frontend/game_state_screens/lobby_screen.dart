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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                roomId,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: lobbyMembers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(lobbyMembers[index]),
                      trailing: isCreator
                          ? IconButton(
                              onPressed: () {
                                // Logic to remove a member
                              },
                              icon: const Icon(Icons.person_remove),
                            )
                          : null,
                    );
                  },
                ),
              ),
              if (isCreator)
                ElevatedButton(
                  onPressed: () {
                    // Start button logic
                  },
                  child: const Text(
                    'Start',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
