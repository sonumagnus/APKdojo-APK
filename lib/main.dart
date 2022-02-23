import 'package:apkdojo/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Apkdojo",
      home: const Home(),
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.light,
    ),
  );
}
