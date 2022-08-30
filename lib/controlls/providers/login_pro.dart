import 'package:firebase/controlls/providers/util_providers.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  // input controllers
  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  // checking is loading or not
  bool isLoading = false;

  // login function
  void logIn(ctx) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailControl.text, password: passwordControl.text)
        .then((value) => {
              Provider.of<UtilProvider>(ctx, listen: false).collectionName =
                  emailControl.text,
            })
        .then((value) {
      isLoading = false;
      notifyListeners();
    }).then((value) {
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }).onError((error, stackTrace) {
      UtilProvider.showScaffoldMessege(ctx);
      isLoading = false;
      notifyListeners();
    });
  }
}
