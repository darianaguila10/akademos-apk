import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({required BuildContext context,required String labelText, String? hintText,IconData? icon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
          hintText: hintText,
        icon: Icon(icon),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey));
  }
}
