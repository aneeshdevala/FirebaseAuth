import 'package:firebase/constants/consts.dart';
import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/controlls/navigators/navigators.dart';
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
                          Image.asset(
                            'assets/undraw_Login_re_4vu2.png',
                            width: 400,
                            height: 300,
                          ),
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizehight20,
                          TextField(
                            controller: Variables.email,
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
                            controller: Variables.password,
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
