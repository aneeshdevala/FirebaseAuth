import 'package:firebase/controlls/home_provider/home_providers.dart';
import 'package:firebase/controlls/login_provider/login_pro.dart';
import 'package:firebase/controlls/signup_provider/signup_pro.dart';
import 'package:firebase/utilities/colors.dart';
import 'package:firebase/utilities/constans.dart';
import 'package:firebase/view/home_screen/widgets/home_imagewid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  logIn,
  signUp,
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  ActionType type;
  HomePage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    final editProvider = context.watch<HomeProvider>();
    // editProvider.notifyListeners();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientcolor(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      ProfilePic(type: type),
                      kHeight20,
                      TextFormField(
                        controller: editProvider.userNameController,
                        obscureText: false,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.name
                                : value.loggedUserDetails.name,
                            hintStyle: const TextStyle(fontSize: 20),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      kHeight20,
                      TextFormField(
                        controller: editProvider.emailController,
                        obscureText: false,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.email
                                : value.loggedUserDetails.email,
                            hintStyle: TextStyle(
                                color: Colors.green.shade900, fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        readOnly: true,
                      ),
                      kHeight20,
                      TextFormField(
                        controller: editProvider.mobNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: type == ActionType.logIn
                              ? loginProvider.loggedUserDetails.phoneNo
                              : value.loggedUserDetails.phoneNo,
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
                      ),
                      kHeight10,
                      Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // value.signUpUser(context);
                                  value.logOut(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 30),
                                  primary: Colors.red.shade700,
                                ),
                                child: const Text('LogOut'),
                              ),
                              kWidth10,
                              kWidth10,
                              ElevatedButton(
                                onPressed: () {
                                  editProvider.updateUserDetails(context);
                                  editProvider.notifyListeners();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 30),
                                  primary: Colors.blueAccent,
                                ),
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      )
                    ],
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
