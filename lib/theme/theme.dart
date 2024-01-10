import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade400,
      inversePrimary: Colors.grey.shade800
  ),

);
// dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      // background: Colors.grey.shade900,
      background: const Color.fromARGB(255,17,17,17),
      primary: const Color.fromARGB(255,30,30,30),
      secondary: const Color.fromARGB(255,45,45,45),
      inversePrimary: Colors.grey.shade300
  ),

);