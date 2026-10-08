import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRegister {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> register({required Map<String, dynamic> data}) async {
    final name = (data['name'] as String).trim();
    final email = (data['email'] as String).trim();
    final password = data['password'] as String;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw ArgumentError('All fields are required.');
    }

    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    await user.updateDisplayName(name);

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return credential;
  }
}
