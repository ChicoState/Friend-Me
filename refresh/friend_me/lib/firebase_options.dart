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
    apiKey: 'AIzaSyDweBF9EFxh88IubGBiMLW7uMXUW2WNBN0',
    appId: '1:593829335684:web:c537e4957c872484cae8d1',
    messagingSenderId: '593829335684',
    projectId: 'friendme-2640b',
    authDomain: 'friendme-2640b.firebaseapp.com',
    storageBucket: 'friendme-2640b.appspot.com',
    measurementId: 'G-WR9V6B295K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzsmbSJmKDe3qIpTMuax69zqDLcTyMjwk',
    appId: '1:593829335684:android:b0cd8e5902fd2dd8cae8d1',
    messagingSenderId: '593829335684',
    projectId: 'friendme-2640b',
    storageBucket: 'friendme-2640b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkxtp7fKYo4qUP7f67lYHb-M5sSqWuNDg',
    appId: '1:593829335684:ios:3b7ef31349871880cae8d1',
    messagingSenderId: '593829335684',
    projectId: 'friendme-2640b',
    storageBucket: 'friendme-2640b.appspot.com',
    iosBundleId: 'com.example.friendMe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkxtp7fKYo4qUP7f67lYHb-M5sSqWuNDg',
    appId: '1:593829335684:ios:20e670796eab2bdacae8d1',
    messagingSenderId: '593829335684',
    projectId: 'friendme-2640b',
    storageBucket: 'friendme-2640b.appspot.com',
    iosBundleId: 'com.example.friendMe.RunnerTests',
  );
}
