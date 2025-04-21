import 'package:flutter/material.dart';

class Customcomponents {
  static getCustomText({
    required String text,
    required Color clr,
    required FontWeight weight,
    required double size,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: weight, color: clr),
    );
  }

  static Widget getCustomButton({
    required Widget child,
    required VoidCallback onPressedFunc,
    Color clr = Colors.white, // corrected from 'Colors'
  }) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(clr)),
      onPressed: onPressedFunc,
      child: child,
    );
  }
}
