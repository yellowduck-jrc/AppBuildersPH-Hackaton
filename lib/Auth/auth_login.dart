import 'package:firebase_auth/firebase_auth.dart';

class AuthLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login({required Map<String, dynamic> data}) async {
    final email = (data['email'] as String).trim();
    final password = data['password'] as String;

    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email and password are required.');
    }

    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
