import 'package:flutter/material.dart';
import 'package:niu_app/config/themes.dart';
import 'package:niu_app/features/auth/screens/authentication_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkTheme = true;

  void _toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: AuthenticationScreen(
        toggleTheme: _toggleTheme,
        isDarkTheme: true,
      ),
    );
  }
}
