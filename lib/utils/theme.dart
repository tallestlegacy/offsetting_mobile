import 'package:flutter/material.dart';

MaterialColor primaryColor = Colors.green;

ThemeData getTheme(bool isDarkMode) {
  return ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: Colors.red,
  );
}

var lightTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.greenAccent,
  appBarTheme: const AppBarTheme(
      //backgroundColor: Colors.transparent,
      ),
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  listTileTheme: const ListTileThemeData(dense: true),
);
