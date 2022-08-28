import 'package:flutter/material.dart';

class Nav {
  static final navigator = GlobalKey<NavigatorState>();
  static push({required var page}) {
    navigator.currentState?.push(MaterialPageRoute(builder: (context) => page));
  }
}
