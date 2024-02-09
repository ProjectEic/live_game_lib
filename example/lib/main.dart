import 'package:example/firebase_options.dart';
import 'package:example/gamelist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';

/// The [GameManager] instance for managing games in the application.
GameManager? inst;

/// The main function to run the Flutter application.
void main() async {
  // Ensure that Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the specified options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Create an instance of the [GameManager] with the available games.
  inst = GameManager(games: games);

  // Run the Flutter application.
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      routes: inst?.routes, // Set the routes based on the GameManager instance.
    );
  }
}
