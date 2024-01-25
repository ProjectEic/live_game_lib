# Live Game Libary
A Flutter Libary for creating Games fast 

## Getting Started

1. Setup your Firebase project and [add it to project ](https://firebase.google.com/docs/database/android/start?hl=de)
2. Setup you realtime database realtime database
3. Import this Libary and create your List of Games
```dart
import 'package:example/games/guess_the_word.dart';
import 'package:live_game_lib/backend/game_prefab.dart';
Map<String, Game> games = {

    "my first game": Game(
        "my first game",
        myFirstGameScreen,
        usesLobby: true,
        canPostjoin: true,
    ),
};
```
4. Create your First Game Call Function in another File
```dart
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/room.dart';
Widget myFirstGameScreen(BuildContext context, Room r) {
    String textDatabase = r.getString("syncedString") ?? "";
    return return Scaffold(
        appBar: AppBar(
        title: const Text("Synced Text Field"),
        ),
        body: Center (
            TextFormField(
                initialValue: textDatabase,
                onChanged: (text) {
                    r.set("syncedString", text);
                },
            )
        )   
    )
}
```

5. Create Your Game Manager in your main file
```dart
import 'package:example/firebase_options.dart';
import 'package:example/gamelist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_game_lib/backend/gamemanager.dart';


GameManager? inst;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  inst = GameManager(games: games);
  runApp(const MyApp());
}

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
      routes: inst?.routes
    );

  }
}
```

