import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/controlls/providers/home_providers.dart';
import 'package:firebase/controlls/providers/providers.dart';
import 'package:firebase/controlls/providers/util_providers.dart';
import 'package:firebase/model.dart/model.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase/view/widgets/temp_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final addresscontrol = TextEditingController();
  final contactControl = TextEditingController();

  static TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      contact = TextEditingController();
  static String image = imagePick(HomeProvider());

  static imagePick(HomeProvider provider) async {
    var imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
    var bytes = File(imagePick!.path).readAsBytesSync();
    image = base64Encode(bytes);
    provider.pickImage();
  }

  UserModel loggedUserModell = UserModel();
  FirebaseAuth _auth;
  AuthProvider(this._auth);
  bool _isloading = false;

  //Stream<User?> stream() => _auth.authStateChanges();
  bool get loading => _isloading;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // static void signIn(AuthProvider provider, context) async {
  //   var msg = await provider.signIn(email.text, password.text, context);

  //   //var authProvider = context.watch<AuthProvider>();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }

  Future<String> signIn(String email, String password, context) async {
    try {
      _isloading = true;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Provider.of<UtilProvider>(context, listen: false).collectionName =
            emailControl.text;
      }).then((value) {
        _isloading = false;
        notifyListeners();
      }).then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage())));
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isloading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
  // input controllers

  // Future<String> signUp(
  //     {required String email,
  //     required String password,
  //     required String image,
  //     required String name,
  //     required String address,
  //     required String contact,
  //     context}) async {
  //   if (name.isEmpty ||
  //       address.isEmpty ||
  //       email.isEmpty ||
  //       password.isEmpty ||
  //       password.length < 6 ||
  //       image == '' ||
  //       contact.isEmpty ||
  //       contact.length < 10) {
  //     // return UtilProvider.showScaffoldMessege(context);
  //   }
  //   try {
  //     _isloading = true;
  //     notifyListeners();
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password.trim());
  //     await registerdata(
  //         email: email,
  //         password: password,
  //         image: image,
  //         name: name,
  //         address: address,
  //         contact: contact);
  //     _isloading = false;

  //     notifyListeners();
  //     return Future.value('');
  //   }
  //   on FirebaseAuthException catch (ex) {
  //     _isloading = false;
  //     notifyListeners();
  //     return Future.value(ex.message);
  //   }
  // }

  String _imageToString = tempImg;
  get imageToString => _imageToString;
  set imageToString(val) => _imageToString = val;
  pickImage() async {
    final imageFromGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFromGallery == null) {
      return;
    }
    final bytes = File(imageFromGallery.path).readAsBytesSync();
    _imageToString = base64Encode(bytes);
    notifyListeners();
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

  // Future<String> fbSign() async {
  //   return Future.value('facebook Sign');
  // }

  // Future<String> googleSignOut() async {
  //   return Future.value('Google SignOut');
  // }

  // Future<String> fbSignOut() async {
  //   return Future.value('Facebook SignOut');
  // }

  //ReadData;
  getAllUserDetails(context) {
    User? user = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUserModell = UserModel.fromJson(value.data()!);
      // print(loggedUserModell.name);
      // print(user.uid);
      log(loggedUserModell.name.toString());
    });
  }

  // registerdata(
  //     {required String email,
  //     required String password,
  //     required String image,
  //     required String name,
  //     required String address,
  //     required String contact}) async {
  //   User? user = _auth.currentUser;

  //   FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
  //     'password': password,
  //     'email': email,
  //     'image': image,
  //     'name': name,
  //     'address': address,
  //     'id': user.uid,
  //   });
  // }

  void notifyListeners();
}
