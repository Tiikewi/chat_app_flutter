import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  late User _user;

  AuthService() {
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      _auth.authStateChanges().listen((User? user) {
        if (user != null) {
          _user = user;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  User getUser() {
    return _user;
  }
}
