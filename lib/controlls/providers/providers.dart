import 'dart:convert';
import 'dart:io';

import 'package:firebase/view/widgets/temp_image.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddPro extends ChangeNotifier {
  static String imageToString = tempImg;

  pickImage() async {
    final imagePick =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(imagePick!.path).readAsBytesSync();
    imageToString = base64Encode(bytes);
    notifyListeners();
  }
}
