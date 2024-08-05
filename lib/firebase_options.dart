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
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyBIm4_dwUupaIxNQJzw9F9Z1Cau25DbWRQ',
    appId: '1:14355455321:web:11a1c446b577c2871dc048',
    messagingSenderId: '14355455321',
    projectId: 'e-commerce-51192',
    authDomain: 'e-commerce-51192.firebaseapp.com',
    storageBucket: 'e-commerce-51192.appspot.com',
    measurementId: 'G-GGS23WB3LM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMaC4RqsXGTUEe6JwyLquYK3obHg8-1xg',
    appId: '1:14355455321:android:97dc14328048c8b31dc048',
    messagingSenderId: '14355455321',
    projectId: 'e-commerce-51192',
    storageBucket: 'e-commerce-51192.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDYrYSCooF6FQoKj5ZOsqpHT_1sveu0HE',
    appId: '1:14355455321:ios:caf4259baddecbde1dc048',
    messagingSenderId: '14355455321',
    projectId: 'e-commerce-51192',
    storageBucket: 'e-commerce-51192.appspot.com',
    iosBundleId: 'com.example.eCommerceFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDYrYSCooF6FQoKj5ZOsqpHT_1sveu0HE',
    appId: '1:14355455321:ios:caf4259baddecbde1dc048',
    messagingSenderId: '14355455321',
    projectId: 'e-commerce-51192',
    storageBucket: 'e-commerce-51192.appspot.com',
    iosBundleId: 'com.example.eCommerceFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIm4_dwUupaIxNQJzw9F9Z1Cau25DbWRQ',
    appId: '1:14355455321:web:47f621241a6ef3431dc048',
    messagingSenderId: '14355455321',
    projectId: 'e-commerce-51192',
    authDomain: 'e-commerce-51192.firebaseapp.com',
    storageBucket: 'e-commerce-51192.appspot.com',
    measurementId: 'G-B7HWJ8Z0QQ',
  );
}
