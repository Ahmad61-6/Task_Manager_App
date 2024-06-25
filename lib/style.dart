import 'package:flutter/material.dart';

InputDecoration textFormFieldDecoration(label) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
    hintText: label,
    labelText: label,
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  );
}

ButtonStyle appButtonStyle() {
  return ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)));
}
