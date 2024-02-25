import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDWFcskgBbEYc4ZtxBvpNydCeJ7yDQjO64",
            authDomain: "shakeout-game-r5t581.firebaseapp.com",
            projectId: "shakeout-game-r5t581",
            storageBucket: "shakeout-game-r5t581.appspot.com",
            messagingSenderId: "556345856610",
            appId: "1:556345856610:web:f4522d08c7e1b57fdf373b"));
  } else {
    await Firebase.initializeApp();
  }
}
