import 'package:flutter/material.dart';
import 'package:news001/pages/Articlepages.dart';
import 'package:news001/pages/homepage.dart';
import 'Config/Theme.dart';
import 'components/navigaton.dart'; // <-- make sure the path matches your project

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,         // 🌞 Light theme
      darkTheme: darkTheme,      // 🌙 Dark theme
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,// Auto switch based on system setting
      home: NavigationPage(),
    );
  }
}




