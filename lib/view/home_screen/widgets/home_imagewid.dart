import 'dart:convert';

import 'package:firebase/controlls/home_provider/home_providers.dart';
import 'package:firebase/controlls/login_provider/login_pro.dart';
import 'package:firebase/controlls/signup_provider/signup_pro.dart';
import 'package:firebase/view/home_screen/home_screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfilePic extends StatelessWidget {
  ProfilePic({Key? key, required this.type}) : super(key: key);
  ActionType type;
  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    final editProvider = context.watch<HomeProvider>();
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return GestureDetector(
            onTap: () {
              // print('fdsjk');
              editProvider.updateImageFromGallery(context);
            },
            child: type == ActionType.signUp
                ? value.newImage.isEmpty || editProvider.newImage.isEmpty
                    ? const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/userIcon.png'),
                        child: Icon(Icons.add_a_photo),
                      )
                    : CircleAvatar(
                        radius: 100,
                        //   backgroundColor: kBlack,
                        backgroundImage: MemoryImage(
                          const Base64Decoder().convert(value.newImage),
                        ),
                      )
                : loginProvider.loggedUserDetails.image == null
                    ? const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/userIcon.png'),
                        child: Icon(Icons.add_a_photo),
                      )
                    : editProvider.newImage.isNotEmpty
                        ? CircleAvatar(
                            radius: 100,
                            //   backgroundColor: kBlack,
                            backgroundImage: MemoryImage(
                              const Base64Decoder()
                                  .convert(editProvider.newImage),
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            //   backgroundColor: kBlack,
                            backgroundImage: MemoryImage(
                              const Base64Decoder().convert(loginProvider
                                  .loggedUserDetails.image
                                  .toString()),
                            ),
                          ));
      },
    );
  }
}
