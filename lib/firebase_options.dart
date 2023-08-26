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
    apiKey: 'AIzaSyDvLkevSGEJ0IssQe-KorhR1D7fCDgkpog',
    appId: '1:926038762004:web:d8d21ae55470ef79c3fd01',
    messagingSenderId: '926038762004',
    projectId: 'firestoreexample-d5d84',
    authDomain: 'firestoreexample-d5d84.firebaseapp.com',
    storageBucket: 'firestoreexample-d5d84.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIz5vOBr3zPOAzr0GETlj_H6XGqj6GTfo',
    appId: '1:926038762004:android:02a5a68c42cc07efc3fd01',
    messagingSenderId: '926038762004',
    projectId: 'firestoreexample-d5d84',
    storageBucket: 'firestoreexample-d5d84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwicaifJK9V6zvTJl7nsA-woafzOmi4zQ',
    appId: '1:926038762004:ios:b2566ad90c1e1ddbc3fd01',
    messagingSenderId: '926038762004',
    projectId: 'firestoreexample-d5d84',
    storageBucket: 'firestoreexample-d5d84.appspot.com',
    iosClientId: '926038762004-4on446t7prp2e25jkp78191gddbcg1ev.apps.googleusercontent.com',
    iosBundleId: 'com.example.firestoreExample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwicaifJK9V6zvTJl7nsA-woafzOmi4zQ',
    appId: '1:926038762004:ios:9c425db4feefc3fbc3fd01',
    messagingSenderId: '926038762004',
    projectId: 'firestoreexample-d5d84',
    storageBucket: 'firestoreexample-d5d84.appspot.com',
    iosClientId: '926038762004-tqoeco5ts8o3ti76emdh7fbcplv427iv.apps.googleusercontent.com',
    iosBundleId: 'com.example.firestoreExample.RunnerTests',
  );
}
