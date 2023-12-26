import 'package:example/firebase_options.dart';
import 'package:example/gamelist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';
import 'package:live_game_lib/frontend/game_state_screens/home_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/lobby_screen.dart';
import 'package:live_game_lib/frontend/game_state_screens/room_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GameManager(Container(), gm: games);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget generateLobbyScreen(BuildContext context, String roomId,
      List<String> lobbyMembers, bool isCreator) {
    return LobbyScreen(
      roomId: roomId,
      lobbyMembers: lobbyMembers,
      isCreator: isCreator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Games Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(
              title: 'Live Games',
              games: const [
                ['Game 1', '/room_selection_screen'],
                ['Game 2', '/room_selection_screen'],
                ['Game 3', '/room_selection_screen'],
              ],
              theme: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                textTheme: const TextTheme(),
              ),
            ),
        '/lobby_screen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return generateLobbyScreen(
            context,
            args['roomId'],
            args['lobbyMembers'],
            args['isCreator'],
          );
        },
        '/room_selection_screen': (context) =>
            RoomSelectionScreen(), // Route to RoomSelectionScreen
      },
    );
  }
}