import 'dart:convert';

import 'package:firebase/constants/consts.dart';
import 'package:firebase/controlls/auth_provider.dart';

import 'package:firebase/controlls/providers/home_providers.dart';

import 'package:firebase/controlls/providers/signup_pro.dart';
import 'package:firebase/view/home_screen1.dart';

import 'package:firebase/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<SignUpProvider>();

    return StreamBuilder<User?>(
        stream: authProvider.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Consumer<SignUpProvider>(
                    builder: (context, signupPro, child) => Container(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Create New Account',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  'assets/undraw_New_entries_re_cffr.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                            const SignUpImageWidget(),
                            sizehight20,
                            TextFieldWid(
                              controller: signupPro.nameControl,
                              label: 'Name',
                            ),
                            sizehight20,
                            TextFieldWid(
                              controller: signupPro.addressControler,
                              label: 'Address',
                            ),
                            sizehight20,
                            TextFieldWid(
                              controller: signupPro.contactControl,
                              label: 'Contact',
                            ),
                            sizehight20,
                            TextFieldWid(
                              controller: signupPro.emailControl,
                              label: 'Email',
                            ),
                            sizehight20,
                            TextFieldWid(
                              controller: signupPro.passwordControl,
                              label: 'Password',
                            ),
                            sizehight20,
                            if (signupPro.isLoading)
                              const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            if (!signupPro.isLoading)
                              Center(
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 241, 15, 83)),
                                      ),
                                      onPressed: () =>
                                          signupPro.signUp(context),
                                      child: const Text('SignUp')),
                                ),
                              ),
                            sizehight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: const Text('Login'))
                              ],
                            ),
                            sizehight20,
                            const Center(child: Text('Login or Signup with')),
                            sizehight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  width: 50,
                                  height: 50,
                                ),
                                sizewidth,
                                Image.asset(
                                  'assets/fb_icon_325x325.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// @override
// Future<void> dispose() async {
//   Variables.email.dispose();
//   Variables.password.dispose();
//   super.dispose();
// }

class TextFieldWid extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextFieldWid({
    required this.controller,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: greyclr,
        ),
      ),
    );
  }
}

class SignUpImageWidget extends StatelessWidget {
  const SignUpImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, value, child) => Center(
        child: SizedBox(
          height: 105,
          width: 105,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 30,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(value.imageToString),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: RawMaterialButton(
                  onPressed: () async {
                    await value.pickImage();
                  },
                  elevation: 4,
                  fillColor: Colors.grey,
                  padding: const EdgeInsets.all(6),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
