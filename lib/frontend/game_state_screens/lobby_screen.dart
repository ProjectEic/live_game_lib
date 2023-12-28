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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Lobby',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () =>
                  {Navigator.pushNamed(context, '/create_lobby_options')},
            ),
          ],
        ),
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
                    'Start',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize,
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
