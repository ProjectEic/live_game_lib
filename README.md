# Live Game Library

The **Live Game Library** is a powerful Flutter framework designed to streamline the development of real-time multiplayer games. This library simplifies the process of creating engaging and interactive multiplayer experiences. Follow the steps below to get started quickly.

## Getting Started

1. **Firebase Setup:**
   - Begin by setting up your Firebase project. If you haven't done so, follow the [Firebase documentation](https://firebase.google.com/docs) to create a new project.

2. **Real-time Database Configuration:**
   - Configure the real-time database in Firebase. The library leverages Firebase's real-time capabilities to seamlessly synchronize game state across multiple players.

3. **Import Library:**
   - Integrate the library into your Flutter project. Add the following dependency to your `pubspec.yaml` file:

     ```yaml
     dependencies:
       live_game_lib: ^latest_version
     ```

     Ensure to replace `latest_version` with the current version of the library.

4. **Create Game List:**
   - Define a list of games using the `Game` class provided by the library. Each game entry should include a unique identifier, a corresponding screen function, and optional configurations.

     ```dart
     /// Map of available games with their configurations.
     /// Each game entry is represented by a [Game] instance.
     Map<String, Game> games = {
     /// "my first game" entry:
     ///
     /// - Game name: "my first game"
     /// - Screen function: [myFirstGameScreen]
     /// - Uses Lobby: Enabled (true)
     /// - Can Postjoin: Enabled (true)
      "my first game": Game(
        "my first game",
        myFirstGameScreen,
        usesLobby: true,
        canPostjoin: true,
      ),
      
      // Add more games as needed
     };
     ```

5. **Create Game Screens:**
   - Implement the screens for your games. These screens are Flutter widgets representing the UI for each game. Utilize the provided `Room` class to manage game state and facilitate communication between players.

     ```dart
     import 'package:flutter/material.dart';
     import 'package:live_game_lib/backend/room.dart';
    
     /// Widget representing the screen for the "My First Game" example.
     /// Allows users to input text in a synced text field.
     ///
     /// The [context] parameter is the [BuildContext] for the widget.
     /// The [r] parameter is an instance of [Room], providing access to the game room's data.
     ///
     /// The screen displays an [AppBar] with the title "Synced Text Field" and a [TextFormField]
     /// centered in the body. The [TextFormField] is initialized with the value of "syncedString"
     /// from the game room's data. Any changes to the input text will update the "syncedString"
     /// in the game room using [Room.set].
     Widget myFirstGameScreen(BuildContext context, Room r) {
      String textDatabase = r.getString("syncedString") ?? "";

      return Scaffold(
        appBar: AppBar(
          title: const Text("Synced Text Field"),
        ),
        body: Center(
          child: TextFormField(
            initialValue: textDatabase,
            onChanged: (text) {
              r.set("syncedString", text);
            },
          ),
        ),
      );
     }
     ```

6. **Create Game Manager:**
   - Set up the `GameManager` in your main file. This manager initializes the Firebase connection and manages the routing of players to different game screens.

     ```dart
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
       const MyApp({Key? key}) : super(key: key);

       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           title: 'Live Games Demo',
           theme: ThemeData(
             // Your app theme configuration
             // example: colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
           ),
           initialRoute: '/',
           routes: gameManager?.routes,
         );
       }
     }
     ```

## Example Project

For more examples, see the example project in the [example](https://github.com/ProjectEic/live_game_lib/tree/main/example) folder.

Feel free to explore the library's features, customize game screens, and adapt the tools to meet the unique requirements of your multiplayer games. Enjoy the accelerated development journey!
