import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  // Sign Up Method
  Future signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign In Method
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign Out Method
  Future signOut() async {
    await _auth.signOut();
    print('sign out');
  }
}
