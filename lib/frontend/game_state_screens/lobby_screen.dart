import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';


Widget generateDefaultLobbyScreen(BuildContext context, Room room) {

  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lobby for ${room.gameName}',
            style: const TextStyle(
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
              room.id,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: room.players.length,
                itemBuilder: (context, index) {
                  String player = room.players[index];
                  return ListTile(
                    title: Text(player),
                    trailing: room.isAdmin(player)
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
            if (room.isAdmin(room.gameManager.username)) 
              ElevatedButton(
                onPressed: () {
                  room.startGame();
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

