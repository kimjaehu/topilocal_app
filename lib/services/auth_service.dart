import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topilocal_app/main.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return authResult.user.uid;
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email:email);
  }

  // Sign In anonymous
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account  = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Email can\'t be empty.';
    }
    if (value.length < 5) {
      return 'Email must be at least 5 characters long.';
    }
    if (value.length > 50) {
      return 'Email must be less than 50 characters long.';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Password can\'t be empty.';
    }
    if (value.length < 6) {
      return 'Password must be at least 5 characters long.';
    }
    return null;
  }
}