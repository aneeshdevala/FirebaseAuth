import 'package:firebase/controlls/auth_provider.dart';
import 'package:flutter/material.dart';

class Variables {
  static TextEditingController email = TextEditingController(),
      password = TextEditingController();

  static void signIn(AuthProvider provider, context) async {
    var msg = await provider.signIn(email.text, password.text);

    //var authProvider = context.watch<AuthProvider>();

    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void signUp(AuthProvider provider, context) async {
    var msg = await provider.signUp(email.text, password.text);

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
