import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/providers/home_providers.dart';
import 'package:firebase/controlls/providers/login_pro.dart';
import 'package:firebase/controlls/providers/providers.dart';
import 'package:firebase/controlls/providers/signup_pro.dart';
import 'package:firebase/controlls/providers/util_providers.dart';
import 'package:firebase/view/home_screen1.dart';
import 'package:firebase/view/login_page.dart';
import 'package:firebase/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.watch<SignUpProvider>().stream(),
            initialData: null),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        //  home: const RegisterPage(),
      ),
    );
  }
}
