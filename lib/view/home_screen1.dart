import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/view/login_page.dart';
import 'package:firebase/view/widgets/textfield_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text('Home Page'),
                actions: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: () => context.read<AuthProvider>().signOut(),
                      icon: const Icon(Icons.logout))
                ],
              ),
              body: Consumer<AuthProvider>(builder: (context, value, child) {
                print(value.loggedUserModell.name);
                value.notifyListeners();
                return ListView(
                  children: [
                    //  Text(value.loggedUserModell.name.toString()),
                    TextFieldWidgetHome(
                        icon: Icons.abc,
                        size: size,
                        contoller: Variables.name,
                        hint: value.loggedUserModell.name.toString(),
                        type: TextInputType.name),
                    TextFieldWidgetHome(
                        icon: Icons.abc,
                        size: size,
                        contoller: Variables.address,
                        hint: value.loggedUserModell.address.toString(),
                        type: TextInputType.name),
                    TextFieldWidgetHome(
                        icon: Icons.abc,
                        size: size,
                        contoller: Variables.name,
                        hint: value.loggedUserModell.email.toString(),
                        type: TextInputType.name),
                  ],
                );
              }));
        });
  }
}
