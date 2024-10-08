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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA-5F9zjPtTJLw6wNk4KXnKFVuhSpb-m9Q',
    appId: '1:218058158468:web:6a5da7053a52aaf8a96dd1',
    messagingSenderId: '218058158468',
    projectId: 'flight-management-system-e6d26',
    authDomain: 'flight-management-system-e6d26.firebaseapp.com',
    storageBucket: 'flight-management-system-e6d26.appspot.com',
    measurementId: 'G-1CE4E7X9XR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAv_z4Rcq725SI9A4sPgZvRISdwKLsx_p4',
    appId: '1:218058158468:android:016ecc4f6a25ffd1a96dd1',
    messagingSenderId: '218058158468',
    projectId: 'flight-management-system-e6d26',
    storageBucket: 'flight-management-system-e6d26.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3eHp_7DFElXddi72mHH4AW5s8jtXWZG0',
    appId: '1:218058158468:ios:dd1907f2fac6453da96dd1',
    messagingSenderId: '218058158468',
    projectId: 'flight-management-system-e6d26',
    storageBucket: 'flight-management-system-e6d26.appspot.com',
    iosBundleId: 'com.bytedeveloper.flightManagementSystem',
  );
}
