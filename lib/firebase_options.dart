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
    apiKey: 'AIzaSyD9KSxg4UJAKstM0jO5nnuOOfIUFTmAky8',
    appId: '1:301545653395:web:dd029dc0c260a4f7883966',
    messagingSenderId: '301545653395',
    projectId: 'gemini-api-tutorial',
    authDomain: 'gemini-api-tutorial.firebaseapp.com',
    storageBucket: 'gemini-api-tutorial.appspot.com',
    measurementId: 'G-HRF9YMKS74',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeBMfT6Dv2fLmgHWz9smrXjrd3b-Jhsjg',
    appId: '1:301545653395:android:8ccd98f9e9af8f28883966',
    messagingSenderId: '301545653395',
    projectId: 'gemini-api-tutorial',
    storageBucket: 'gemini-api-tutorial.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcrk_-k9nLrU2AyhZwxABksBHdOUzX2r4',
    appId: '1:301545653395:ios:c05db80af8666c0c883966',
    messagingSenderId: '301545653395',
    projectId: 'gemini-api-tutorial',
    storageBucket: 'gemini-api-tutorial.appspot.com',
    iosBundleId: 'com.example.geminiApiTutorial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcrk_-k9nLrU2AyhZwxABksBHdOUzX2r4',
    appId: '1:301545653395:ios:de4a0694d83cd317883966',
    messagingSenderId: '301545653395',
    projectId: 'gemini-api-tutorial',
    storageBucket: 'gemini-api-tutorial.appspot.com',
    iosBundleId: 'com.example.geminiApiTutorial.RunnerTests',
  );
}
