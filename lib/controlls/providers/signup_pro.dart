import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controlls/providers/util_providers.dart';
import 'package:firebase/model.dart/model.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase/view/widgets/temp_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  UserModel loggedUserModell = UserModel();

  bool _isloading = false;

  FirebaseAuth? _auth;
  Stream<User?> stream() => _auth!.authStateChanges();
  bool get loading => isLoading;

  Future<void> signOut() async {
    await _auth?.signOut();
  }

  // input controllers
  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final addressControler = TextEditingController();
  final contactControl = TextEditingController();

  // checking loading or not
  bool isLoading = false;

  // signup function
  signUp(ctx) async {
    bool isError = false;
    final name = nameControl.text;
    final homeTown = addressControler.text;
    final email = emailControl.text;
    final password = passwordControl.text;
    final imageString = _imageToString;
    final contactNo = contactControl.text;
    if (name.isEmpty ||
        homeTown.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        password.length < 6 ||
        imageString == tempImg ||
        contactNo.isEmpty ||
        contactNo.length < 10) {
      return UtilProvider.showScaffoldMessege(ctx);
    }
    isLoading = true;
    notifyListeners();
    // here we create user with email and pwd
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailControl.text, password: passwordControl.text)
        .then((value) {
      createUser(
        name: nameControl.text,
        email: emailControl.text,
        address: homeTown,
        image: imageString,
        contactNo: contactNo,
        password: password,
      );
    }).onError((error, stackTrace) {
      UtilProvider.showScaffoldMessege(ctx);
      if (error.toString().isNotEmpty) {
        isError = true;
      }
    });
    if (isError == true) {
      isLoading = false;
      notifyListeners();
      return UtilProvider.showScaffoldMessege(ctx);
    }
    Provider.of<UtilProvider>(ctx, listen: false).collectionName =
        emailControl.text;
    isLoading = false;
    notifyListeners();
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  //read data
  getAllUserDetails(context) {
    User? user = _auth?.currentUser;
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

  // here we store user's data
  Future createUser({
    required String password,
    required String name,
    required String email,
    required String address,
    required String image,
    required String contactNo,
  }) async {
    User? user = _auth?.currentUser;

    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'password': password,
      'email': email,
      'image': image,
      'name': name,
      'address': address,
      'id': user.uid,
    });
  }

  // select user image
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
}
