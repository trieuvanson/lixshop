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
//
// class TextFormFieldCustom extends StatelessWidget {
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final String? labelText;
//   final bool? enabledBorder;
//   final InputBorder? borderColor;
//   final InputBorder? border;
//
//   const TextFormFieldCustom(
//       {Key? key,
//       this.validator,
//       this.onChanged,
//       this.labelText,
//       this.enabledBorder,
//       this.borderColor,
//       this.border})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         enabledBorder: borderColor ??
//             const OutlineInputBorder(
//               borderSide: BorderSide(color: appColor),
//             ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         labelText: labelText ?? "",
//         labelStyle: const TextStyle(
//           color: appColor,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: appColor,
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value != null) {
//
//         }
//         return null;
//       },
//       onChanged: onChanged,
//     );
//   }
// }
