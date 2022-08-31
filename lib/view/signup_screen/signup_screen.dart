// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:firebase/controlls/signup_provider/signup_pro.dart';
import 'package:firebase/utilities/colors.dart';
import 'package:firebase/utilities/constans.dart';
import 'package:firebase/view/signup_screen/widgets/signup_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpController = context.read<SignUpProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      signUpController.emailController.clear();
      signUpController.passwordController.clear();
      signUpController.userNameController.clear();
      // ignore: invalid_use_of_protected_member
      signUpController.notifyListeners();
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: gradientcolor(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(
                builder: (context, value, child) {
                  return Form(
                    key: value.formKey,
                    child: Column(
                      children: [
                        Image.asset(
                            'assets/undraw_New_entries_re_cffr-removebg-preview.png',
                            height: MediaQuery.of(context).size.height / 4),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height / 8),
                        Text('Create Your Account',
                            style: GoogleFonts.acme(fontSize: 30)),
                        kHeight20,
                        const SignUpImageWidget(),
                        kHeight20,
                        TextFormField(
                          controller: value.userNameController,
                          obscureText: false,
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'UserName',
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                          validator: (inputValue) {
                            if (inputValue == null || inputValue.isEmpty) {
                              return 'Enter userName';
                            } else {
                              return null;
                            }
                          },
                        ),
                        kHeight20,
                        TextFormField(
                          controller: value.emailController,
                          obscureText: false,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                          validator: (inputValue) {
                            if (inputValue == null || inputValue.isEmpty) {
                              return 'Please enter email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        kHeight20,
                        TextFormField(
                          controller: value.passwordController,
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
                          validator: (inputValue) {
                            if (inputValue == null || inputValue.isEmpty) {
                              return 'Enter Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        kHeight10,
                        ElevatedButton(
                          onPressed: () async {
                            if (value.formKey.currentState!.validate()) {
                              final errorMsg =
                                  signUpController.signUpUser(context);

                              signUpController.checkFormField(
                                  context, errorMsg);
                            }
                          },
                          child: const Text('SignUp'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
