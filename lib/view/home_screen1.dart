import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                ],
              ),
            ),
          );
        });
  }
}
