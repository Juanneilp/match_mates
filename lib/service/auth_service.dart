import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:match_mates/model/login.dart';
import 'package:match_mates/service/user_service.dart';

class AuthServices {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Login? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Login(user.uid, user.email);
  }

  Stream<Login?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<Login?> signUp(String email, String password, String name,
      String gender, String city) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    UserService().createUser(name, "basic bio for everyone", gender, city);
    return _userFromFirebase(credential.user);
  }

  Future<Login?> signIn(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (credential.user!.emailVerified) {
      return _userFromFirebase(credential.user);
    } else {
      final snackBar = SnackBar(
          content:
          Text("Verification Email"));
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
