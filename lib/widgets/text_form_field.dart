import 'package:flutter/material.dart';

import '../contains/colors.dart';

class TextFormFieldCommonStyle {
  static InputDecoration textFormFieldStyle(String? label) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: appColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: appColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: appColor,
        ),
      ),
    );
  }
}
