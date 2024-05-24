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
    apiKey: 'AIzaSyCL2Dc7Q8OII-4yexMLl7AtOXLFX9fHepE',
    appId: '1:576082975644:web:2240acc55f97ac702e8659',
    messagingSenderId: '576082975644',
    projectId: 'qrstar-deles',
    authDomain: 'qrstar-deles.firebaseapp.com',
    storageBucket: 'qrstar-deles.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwYdN_tg3_I6sYqFbo2BAmh6PqtacEH1U',
    appId: '1:576082975644:android:26771ad6cdf686fe2e8659',
    messagingSenderId: '576082975644',
    projectId: 'qrstar-deles',
    storageBucket: 'qrstar-deles.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDv0hqtxFVGxaNjhmS2BToi8D-lUdqlyvs',
    appId: '1:576082975644:ios:bbf441dbd9f31d222e8659',
    messagingSenderId: '576082975644',
    projectId: 'qrstar-deles',
    storageBucket: 'qrstar-deles.appspot.com',
    iosClientId: '576082975644-vp84j8e2neu0ij21qpuv7706sdb2rhlg.apps.googleusercontent.com',
    iosBundleId: 'com.example.esqrcode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDv0hqtxFVGxaNjhmS2BToi8D-lUdqlyvs',
    appId: '1:576082975644:ios:bbf441dbd9f31d222e8659',
    messagingSenderId: '576082975644',
    projectId: 'qrstar-deles',
    storageBucket: 'qrstar-deles.appspot.com',
    iosClientId: '576082975644-vp84j8e2neu0ij21qpuv7706sdb2rhlg.apps.googleusercontent.com',
    iosBundleId: 'com.example.esqrcode',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCL2Dc7Q8OII-4yexMLl7AtOXLFX9fHepE',
    appId: '1:576082975644:web:b34228b3a8b42a392e8659',
    messagingSenderId: '576082975644',
    projectId: 'qrstar-deles',
    authDomain: 'qrstar-deles.firebaseapp.com',
    storageBucket: 'qrstar-deles.appspot.com',
  );

}