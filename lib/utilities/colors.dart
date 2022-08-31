import 'package:flutter/material.dart';

const kBlack = Colors.black;
const kBlack54 = Colors.black54;

const kWhite = Colors.white;

BoxDecoration gradientcolor() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromARGB(255, 6, 58, 49),
        Colors.white54,
      ],
      // colors: [
      //   Color.fromARGB(221, 86, 226, 140),

      //   Color.fromARGB(158, 48, 25, 25),
      //   // Colors.indigo,
      //   // Colors.teal
      // ],
    ),
  );
}
