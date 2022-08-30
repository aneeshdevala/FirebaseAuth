import 'package:firebase/constants/consts.dart';
import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/controlls/navigators/navigators.dart';
import 'package:firebase/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

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
                    Image.asset(
                      'assets/undraw_Login_re_4vu2.png',
                      width: 400,
                      height: 300,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sizehight20,
                    TextField(
                      controller: Functions.email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: greyclr,
                        ),
                      ),
                    ),
                    sizehight20,
                    TextField(
                      controller: Functions.password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: greyclr,
                        ),
                      ),
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
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 241, 15, 83)),
                              ),
                              onPressed: () =>
                                  Functions.signIn(authProvider, context),
                              child: const Text('Login')),
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
                                          const RegisterPage()));
                            },
                            child: const Text('New User? Register')),
                        const Text(
                          'Forgot Password',
                          style: TextStyle(fontSize: 18, color: greyclr),
                        ),
                      ],
                    ),
                    sizehight20,
                    const Center(child: Text('Login or signIn with')),
                    sizehight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Functions.googleSignIn(authProvider, context),
                          child: Image.asset(
                            'assets/google.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        sizewidth,
                        GestureDetector(
                          onTap: () =>
                              Functions.fbSignIn(authProvider, context),
                          child: Image.asset(
                            'assets/fb_icon_325x325.png',
                            width: 40,
                            height: 40,
                          ),
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
  }

  // @override
  // Future<void> dispose() async {
  //   Variables.email.dispose();
  //   Variables.password.dispose();
  //   super.dispose();
  // }
}
