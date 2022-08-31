import 'package:firebase/controlls/login_provider/login_pro.dart';
import 'package:firebase/utilities/colors.dart';
import 'package:firebase/utilities/constans.dart';
import 'package:firebase/view/login_screen/widgets/log_option.dart';
import 'package:firebase/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LogInProvider>();

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: gradientcolor(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: loginController.formKey,
                  child: Column(
                    children: [
                      // SizedBox(height: MediaQuery.of(context).size.height / 5),
                      Image.asset('assets/undraw_Login_re_4vu2.png',
                          height: MediaQuery.of(context).size.height / 3.5),
                      Text('LOGIN', style: GoogleFonts.acme(fontSize: 30)),
                      kHeight20,
                      TextFormField(
                        controller: loginController.emailController,
                        obscureText: false,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'E-mail',
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        validator: (value) {
                          Colors.black;
                          if (value == null || value.isEmpty) {
                            return "Enter E-mail";
                          } else {
                            return null;
                          }
                        },
                      ),
                      kHeight20,
                      TextFormField(
                          controller: loginController.passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            Colors.black;
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            } else {
                              return null;
                            }
                          }),
                      kHeight10,

                      ElevatedButton(
                        onPressed: () {
                          loginController.formValidation(context);
                        },
                        child: loginController.isLoading == true
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Don't have account yet?",
                            style: TextStyle(color: kBlack),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                            ),
                          ),
                        ],
                      ),
                      kHeight10,
                      const LoginOptions(),
                      kHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset('assets/google.png')),
                          ),
                          kWidth10,
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/fb_icon_325x325.png')),
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
  }
}
