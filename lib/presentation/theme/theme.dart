import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'colors.dart';
part 'text_theme.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: lightTextTheme,
      appBarTheme: const AppBarTheme(color: Colors.blue),
      colorScheme: lightColorScheme,
    );
  }

  // Dark theme definition
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      appBarTheme: const AppBarTheme(color: Colors.blueGrey),
      colorScheme: darkColorScheme,
    );
  }
}
