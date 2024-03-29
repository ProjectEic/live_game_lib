// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBD8RWL7ja0i2CKh_I57QdaDIQYWCKQj_c',
    appId: '1:346505806050:web:486d32e26d2c301307debb',
    messagingSenderId: '346505806050',
    projectId: 'gamelibary-482dd',
    authDomain: 'gamelibary-482dd.firebaseapp.com',
    databaseURL:
        'https://gamelibary-482dd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gamelibary-482dd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIZFm4_1Ty7MvS_EWnT7U5E_kzEHVDmPs',
    appId: '1:346505806050:android:89e14c9e27e47cec07debb',
    messagingSenderId: '346505806050',
    projectId: 'gamelibary-482dd',
    databaseURL:
        'https://gamelibary-482dd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gamelibary-482dd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuI_D7EX7qjWn3dYQ1QBmGTCtIQT5vHeE',
    appId: '1:346505806050:ios:44b4d45ee3c5b36f07debb',
    messagingSenderId: '346505806050',
    projectId: 'gamelibary-482dd',
    databaseURL:
        'https://gamelibary-482dd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gamelibary-482dd.appspot.com',
    iosBundleId: 'com.example.example',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuI_D7EX7qjWn3dYQ1QBmGTCtIQT5vHeE',
    appId: '1:346505806050:ios:cb0f96382640370a07debb',
    messagingSenderId: '346505806050',
    projectId: 'gamelibary-482dd',
    databaseURL:
        'https://gamelibary-482dd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gamelibary-482dd.appspot.com',
    iosBundleId: 'com.example.example.RunnerTests',
  );
}
