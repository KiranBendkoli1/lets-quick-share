import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

fb() {
  if (kIsWeb) {
    return Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyDtfaZuOOBqXsoPPdq4F6qVXTWLQt2Z6Ls',
            appId: '1:66646796269:web:cbe1e658c7076ab4fce9e4',
            messagingSenderId: "G-5NNFN9WCYV",
            projectId: "lets-quick-share"));
  }
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    return Firebase.initializeApp(
        name: "Lets Quick Share",
        options: FirebaseOptions(
            apiKey: 'AIzaSyDtfaZuOOBqXsoPPdq4F6qVXTWLQt2Z6Ls',
            appId: '1:66646796269:web:cbe1e658c7076ab4fce9e4',
            messagingSenderId: "G-5NNFN9WCYV",
            projectId: "lets-quick-share"));
  }
}
