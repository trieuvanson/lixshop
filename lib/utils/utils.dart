import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  return null;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(content),
  ));
}

// showSnackBar(String content, int seconds, BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     duration: Duration(seconds: seconds??2),
//     content: Text(content),
//   ));
// }