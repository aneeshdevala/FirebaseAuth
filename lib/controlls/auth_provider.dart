import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/model.dart/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  UserModel loggedUserModell = UserModel();
  FirebaseAuth _auth;
  AuthProvider(this._auth);
  bool _isloading = false;

  Stream<User?> stream() => _auth.authStateChanges();
  bool get loading => _isloading;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> signIn(String email, String password, context) async {
    try {
      _isloading = true;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        getAllUserDetails(context);
      });
      _isloading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isloading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<String> signUp(String email, String password, String image,
      String name, String address, String contact) async {
    try {
      _isloading = true;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      await registerdata(email, password, image, name, address, contact);
      _isloading = false;

      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isloading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<String> googleSign() async {
    try {
      _isloading = true;
      notifyListeners();
      final isLoggedIn = await GoogleSignIn().isSignedIn();
      if (isLoggedIn) {
        GoogleSignIn().signOut();
      }
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        _isloading = false;
        notifyListeners();
        return Future.value('Occure error while signing in');
      }
      final cred = await result.authentication;
      await _auth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: cred.idToken, accessToken: cred.accessToken));
      _isloading = true;
      notifyListeners();

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isloading = false;
      notifyListeners();

      return Future.value(ex.message);
    }
  }

  Future<String> fbSign() async {
    return Future.value('facebook Sign');
  }

  Future<String> googleSignOut() async {
    return Future.value('Google SignOut');
  }

  Future<String> fbSignOut() async {
    return Future.value('Facebook SignOut');
  }

  //ReadData;
  getAllUserDetails(context) {
    User? user = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUserModell = UserModel.fromJson(value.data()!);
      print(loggedUserModell.name);
      // print(user.uid);
      log(loggedUserModell.name.toString());
    });
  }

  registerdata(String email, String password, String image, String name,
      String address, String contact) async {
    User? user = _auth.currentUser;

    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'password': password,
      'email': user.email,
      'image': image,
      'name': name,
      'address': address,
      'id': user.uid,
    });
  }

  void notifyListeners();
}
