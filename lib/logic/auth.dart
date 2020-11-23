import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> get userStream;
  Future<User> signIn(String email, String password);
  Future<void> logOut();
}

class Auth implements AuthBase {
  final _auth = FirebaseAuth.instance;

  @override
  User get currentUser => _auth.currentUser;

  @override
  Stream<User> get userStream => _auth.authStateChanges();

  @override
  Future<User> signIn(String email, String password) async {
    _auth.setLanguageCode('ru');
    final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

  @override
  Future<void> logOut() async {
    return await _auth.signOut();
  }
}
