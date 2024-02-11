import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';

/// Generates the default lobby screen for a given [Room].
///
/// This function returns a [Scaffold] widget representing the lobby screen,
/// which includes the room title, ID, list of players, and start game button.
///
/// The [context] parameter is required and represents the build context.
/// The [room] parameter is required and represents the Room for which the lobby screen is generated.
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: room.players.length,
                itemBuilder: (context, index) {
                  String player = room.players[index];
                  return ListTile(
                    title: Text(player),
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
