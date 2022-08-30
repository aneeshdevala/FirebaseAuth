import 'package:firebase/controlls/auth_provider.dart';
import 'package:firebase/controlls/functions/functions.dart';
import 'package:firebase/controlls/providers/home_providers.dart';
import 'package:firebase/controlls/providers/signup_pro.dart';
import 'package:firebase/view/home_imagewid.dart';
import 'package:firebase/view/login_page.dart';
import 'package:firebase/view/update_bottom_scre.dart';
import 'package:firebase/view/widgets/textfield_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<User?>(
        stream: context.watch<SignUpProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text('Home Page'),
                // actions: [
                //   IconButton(
                //       splashRadius: 20,
                //       onPressed: () => context.read<AuthProvider>().signOut(),
                //       icon: const Icon(Icons.logout))
                // ],
              ),
              body: Consumer<AuthProvider>(builder: (context, value, child) {
                provider.changeNameControl.text =
                    value.loggedUserModell.name.toString();
                provider.changeAddressControl.text =
                    value.loggedUserModell.address.toString();
                provider.changeContactControl.text =
                    value.loggedUserModell.contact.toString();
                print(value.loggedUserModell.name);
                value.notifyListeners();
                return ListView(
                  children: [
                    HomeImageWidget(
                        imagePath: value.loggedUserModell.image.toString()),
                    //  Text(value.loggedUserModell.name.toString()),
                    // TextFieldWidgetHome(
                    //     icon: Icons.person,
                    //     size: size,
                    //     contoller: Variables.name,
                    //     hint: provider.changeNameControl.text,
                    //     type: TextInputType.name),

                    TextFieldWidget(
                      icon: Icons.phone,
                      maxLen: 15,
                      control: Functions.name,
                      hintText: '',
                    ),

                    TextFieldWidget(
                      icon: Icons.phone,
                      maxLen: 15,
                      control: Functions.contact,
                      hintText: '',
                    ),
                    TextFieldWidget(
                      icon: Icons.phone,
                      maxLen: 15,
                      control: Functions.address,
                      hintText: '',
                    ),

                    Consumer<HomeProvider>(
                        builder: (context, value, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () {
                                      value.logOut(context);
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.logout),
                                        Text('Logout'),
                                      ],
                                    )),
                                // GestureDetector(
                                //     onTap: () {
                                //       showModalBottomSheet(
                                //           shape: const RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.vertical(
                                //             top: Radius.circular(40),
                                //           )),
                                //           context: context,
                                //           isScrollControlled: true,
                                //           builder: (context) {
                                //             return BottomSheetSettings(
                                //               image: provider
                                //                   .loggedUserModell.image
                                //                   .toString(),
                                //               name: provider
                                //                   .loggedUserModell.name
                                //                   .toString(),
                                //               email: provider
                                //                   .loggedUserModell.email
                                //                   .toString(),
                                //               contact: provider
                                //                   .loggedUserModell.contact
                                //                   .toString(),
                                //               address: provider
                                //                   .loggedUserModell.address
                                //                   .toString(),
                                //             );
                                //           });
                                //     },
                                //     child: Container(
                                //       height: 50,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Colors.purple,
                                //       ),
                                //       child: const Center(
                                //         child: Text(
                                //           'Edit',
                                //           style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 18,
                                //           ),
                                //         ),
                                //       ),
                                //     ))
                              ],
                            )),
                  ],
                );
              }));
        });
  }
}
