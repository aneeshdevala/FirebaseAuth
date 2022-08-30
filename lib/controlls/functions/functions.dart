import 'dart:convert';
import 'dart:io';

import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/providers/providers.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase/view/widgets/temp_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Functions {
  static TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      contact = TextEditingController();
  //static String image = imagePick(HomePage());

  static void signIn(AuthProvider provider, context) async {
    var msg = await provider.signIn(email.text, password.text, context);

    //var authProvider = context.watch<AuthProvider>();

    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  // static void signUp(AuthProvider provider, context) async {
  //   var msg = await provider.signUp(
  //       email: email.text,
  //       password: password.text,
  //       image: image,
  //       name: name.text,
  //       address: address.text,
  //       contact: contact.text);

  //   //var authProvider = context.watch<AuthProvider>();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }

  // static imagePick(ImageAddPro provider) async {
  //   var imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   var bytes = File(imagePick!.path).readAsBytesSync();
  //   image = base64Encode(bytes);
  //   provider.pickImage();
  // }

  // static String _imageToString = tempImg;
  // get imageToString => _imageToString;
  // set imageToString(val) => _imageToString = val;
  // pickImage() async {
  //   final imageFromGallery =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (imageFromGallery == null) {
  //     return;
  //   }
  //   final bytes = File(imageFromGallery.path).readAsBytesSync();
  //   _imageToString = base64Encode(bytes);
  // }

  // static void googleSignIn(AuthProvider provider, context) async {
  //   var msg = await provider.googleSign();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }

  // static void fbSignIn(AuthProvider provider, context) async {
  //   var msg = await provider.fbSign();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }

  // static void googleSignUp(AuthProvider provider, context) async {
  //   var msg = await provider.googleSign();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }

  // static void fbSignOut(AuthProvider provider, context) async {
  //   var msg = await provider.fbSign();

  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }
}
