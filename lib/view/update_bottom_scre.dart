// import 'dart:convert';

// import 'package:firebase/controlls/auth_provider.dart';
// import 'package:firebase/controlls/functions/functions.dart';
// import 'package:firebase/controlls/providers/home_providers.dart';
// import 'package:firebase/view/register_page.dart';
// import 'package:firebase/view/widgets/textfield_home.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BottomSheetSettings extends StatelessWidget {
//   final String image;
//   final String name;
//   final String email;
//   final String address;
//   final String contact;
//   const BottomSheetSettings({
//     Key? key,
//     required this.image,
//     required this.name,
//     required this.email,
//     required this.address,
//     required this.contact,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final pov = context.read<HomeProvider>();
//     return Padding(
//       padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Consumer<AuthProvider>(builder: (context, value, child) {
//             return GestureDetector(
//               onTap: () {
//                 value.pickImage();
//               },
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 60,
//                 backgroundImage: MemoryImage(const Base64Decoder().convert(
//                     value.imageToString.trim().isEmpty
//                         ? image
//                         : value.imageToString)),
//               ),
//             );
//           }),
//           const SizedBox(height: 30),
//           TextFieldWidgetHome(
//             icon: Icons.email_outlined,
//             size: size,
//             contoller: Variables.email,
//             hint: name,
//             type: TextInputType.name,
//           ),
//           const SizedBox(height: 15),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * .84,
//             child: ElevatedButton(
//               onPressed: () {
//                 pov.updateUserData(
//                     documentID: '',
//                     context: context,
//                     email: email,
//                     name: name,
//                     contactNo: contact,
//                     image: image,
//                     homeTown: address);

//                 Navigator.pop(context);
//                 pov.changeNameControl.clear();
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.purple,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10), // <-- Radius
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 child: Text(
//                   'SUBMIT',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'redhat',
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }

// class TextFieldWidgetHomeBottom extends StatelessWidget {
//   final TextInputType type;
//   final String hint;
//   final TextEditingController contoller;
//   final Size size;
//   final IconData icon;
//   const TextFieldWidgetHomeBottom({
//     Key? key,
//     required this.icon,
//     required this.size,
//     required this.contoller,
//     required this.hint,
//     required this.type,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//       height: size.width / 8,
//       width: size.width / 1.22,
//       alignment: Alignment.center,
//       padding: EdgeInsets.only(right: size.width / 30),
//       decoration: BoxDecoration(
//         color: Colors.purple.withOpacity(.8),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: TextField(
//           controller: contoller,
//           keyboardType: type,
//           style: const TextStyle(
//             color: Colors.white,
//             letterSpacing: .8,
//           ),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: Icon(
//               icon,
//               color: Colors.white,
//             ),
//             hintText: hint,
//             hintStyle: const TextStyle(
//               letterSpacing: 1,
//               color: Colors.white,
//               fontSize: 18,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
