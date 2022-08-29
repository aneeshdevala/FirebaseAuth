import 'dart:convert';

import 'package:firebase/constants/consts.dart';
import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/controlls/navigators/navigators.dart';
import 'package:firebase/controlls/providers/providers.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

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
                  child: Container(
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
                          const AddImage(),
                          sizehight20,
                          TextFieldWid(
                            controller: Variables.name,
                            label: 'Name',
                          ),
                          sizehight20,
                          TextFieldWid(
                            controller: Variables.address,
                            label: 'Address',
                          ),
                          sizehight20,
                          TextFieldWid(
                            controller: Variables.contact,
                            label: 'Contact',
                          ),
                          sizehight20,
                          TextFieldWid(
                            controller: Variables.email,
                            label: 'Email',
                          ),
                          sizehight20,
                          TextFieldWid(
                            controller: Variables.password,
                            label: 'Password',
                          ),
                          sizehight20,
                          if (authProvider.loading)
                            const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          if (!authProvider.loading)
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
                                        Variables.signUp(authProvider, context),
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
          );
        });
  }

  // @override
  // Future<void> dispose() async {
  //   Variables.email.dispose();
  //   Variables.password.dispose();
  //   super.dispose();
  // }
}

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

class AddImage extends StatelessWidget {
  const AddImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageAddPro>(
      builder: (context, value, child) => Center(
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 60,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(value.imageToString),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: RawMaterialButton(
                  onPressed: () {
                    value.pickImage();
                  },
                  elevation: 4,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.person_add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
