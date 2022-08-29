import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddPro extends ChangeNotifier {
  String imageToString = '';

  pickImage() async {
    final imagePick =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(imagePick!.path).readAsBytesSync();
    imageToString = base64Encode(bytes);
    notifyListeners();
  }
}
