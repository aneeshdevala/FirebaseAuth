import 'package:firebase/controlls/auth_provider.dart';
import 'package:flutter/material.dart';

class Variables {
  static TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      contact = TextEditingController();
  static String image = "";

  static void signIn(AuthProvider provider, context) async {
    var msg = await provider.signIn(email.text, password.text, context);

    //var authProvider = context.watch<AuthProvider>();

    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void signUp(AuthProvider provider, context) async {
    var msg = await provider.signUp(email.text, password.text, name.text,
        address.text, contact.text, image);

    //var authProvider = context.watch<AuthProvider>();

    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void googleSignIn(AuthProvider provider, context) async {
    var msg = await provider.googleSign();

    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void fbSignIn(AuthProvider provider, context) async {
    var msg = await provider.fbSign();

    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void googleSignUp(AuthProvider provider, context) async {
    var msg = await provider.googleSign();

    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void fbSignOut(AuthProvider provider, context) async {
    var msg = await provider.fbSign();

    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
