// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC3wP56o6jFC5zvQSkXeTlFK2TedvDEw8w',
    appId: '1:1037408462576:web:6c1719714df587a5564435',
    messagingSenderId: '1037408462576',
    projectId: 'fabriconnect-2882c',
    authDomain: 'fabriconnect-2882c.firebaseapp.com',
    storageBucket: 'fabriconnect-2882c.appspot.com',
    measurementId: 'G-S0453VSWE7',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC3wP56o6jFC5zvQSkXeTlFK2TedvDEw8w',
    appId: '1:1037408462576:web:bb8c120391b5fbaf564435',
    messagingSenderId: '1037408462576',
    projectId: 'fabriconnect-2882c',
    authDomain: 'fabriconnect-2882c.firebaseapp.com',
    storageBucket: 'fabriconnect-2882c.appspot.com',
    measurementId: 'G-KK6TVV0XE8',
  );
}