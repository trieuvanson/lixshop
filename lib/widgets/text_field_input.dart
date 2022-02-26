import 'package:flutter/material.dart';

class MyTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;
  const MyTextFieldInput({Key? key, required this.textEditingController, this.isPassword = false, required this.hintText, required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.grey),
    );


    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
