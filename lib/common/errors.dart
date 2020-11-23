import 'package:firebase_auth/firebase_auth.dart';

String showError(FirebaseAuthException error) {
  switch (error.code) {
    case 'invalid-email':
      return 'Не правильно введен email адрес';
    case 'user-disabled':
      return 'Пользователь заблокирован';
    case 'user-not-found':
    case 'wrong-password':
      return 'Email или пароль не верны';
    default:
      return 'Ошибка';
  }
}
