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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoOQRnG8nCgVuAU1jlL2w48ijQCS6DOrU',
    appId: '1:433785431232:android:1328e5ebd2d35146c73925',
    messagingSenderId: '433785431232',
    projectId: 'intern-firebase-sample2',
    storageBucket: 'intern-firebase-sample2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuldMY1vp8KfWLfdiqHpYk6AZgs3ZU468',
    appId: '1:433785431232:ios:ca52fb0d0647265cc73925',
    messagingSenderId: '433785431232',
    projectId: 'intern-firebase-sample2',
    storageBucket: 'intern-firebase-sample2.appspot.com',
    iosClientId:
        '433785431232-6e8efv1v01ke8j1e8h3sl82lhnjdd6h7.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseInternSampleApp',
  );
}
