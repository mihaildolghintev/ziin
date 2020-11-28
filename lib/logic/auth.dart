import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;
  String get currentUserDisplayName => currentUser.displayName;

  Stream<User> get userStream => _auth.authStateChanges();

  Future<User> signIn(String email, String password) async {
    _auth.setLanguageCode('ru');
    final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

  Future<void> logOut() async {
    return await _auth.signOut();
  }

  Future<User> createUser({
    @required String email,
    @required String password,
    @required displayName,
  }) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user.updateProfile(displayName: displayName);
    return userCredential.user;
  }
}
