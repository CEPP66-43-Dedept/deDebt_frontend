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
    apiKey: 'AIzaSyBKUCYzBFhtJIUy3HHQkyiKO8_4_yFFezk',
    appId: '1:690628174020:web:efc5f06101cef492eb2991',
    messagingSenderId: '690628174020',
    projectId: 'dedebt-app',
    authDomain: 'dedebt-app.firebaseapp.com',
    storageBucket: 'dedebt-app.appspot.com',
    measurementId: 'G-8E6HXSGJR7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjV2dp7A5jX3TYXZUkkeiNmIhICyDBPbc',
    appId: '1:690628174020:android:b4231e373146b123eb2991',
    messagingSenderId: '690628174020',
    projectId: 'dedebt-app',
    storageBucket: 'dedebt-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArBQ3pIzO9waQzByrITRTnFwOyDQw49N8',
    appId: '1:690628174020:ios:89c89a575ca02220eb2991',
    messagingSenderId: '690628174020',
    projectId: 'dedebt-app',
    storageBucket: 'dedebt-app.appspot.com',
    androidClientId: '690628174020-1l4j19512i4aflpkm41oth2ph586l8g4.apps.googleusercontent.com',
    iosClientId: '690628174020-livkqbckomfiiqs98hbu0pjlt6ahbhv0.apps.googleusercontent.com',
    iosBundleId: 'com.example.dedebtApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArBQ3pIzO9waQzByrITRTnFwOyDQw49N8',
    appId: '1:690628174020:ios:6250bec869deaaa7eb2991',
    messagingSenderId: '690628174020',
    projectId: 'dedebt-app',
    storageBucket: 'dedebt-app.appspot.com',
    androidClientId: '690628174020-1l4j19512i4aflpkm41oth2ph586l8g4.apps.googleusercontent.com',
    iosClientId: '690628174020-7bou3udelr42ereo7d7k1qjpoclmmii3.apps.googleusercontent.com',
    iosBundleId: 'com.example.dedebtApplication.RunnerTests',
  );
}