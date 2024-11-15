import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm5/providers/language_provider.dart';
import './screens/loginScreen.dart';
import '../providers/massProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MassProvider(),
      child: ChangeNotifierProvider(
        create: (context) => LanguageProvider(),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 150, 7),
        scaffoldBackgroundColor: Colors.blueGrey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 150, 7),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Button background color
            foregroundColor: Colors.white, // Button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
