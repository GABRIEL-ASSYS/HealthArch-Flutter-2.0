import 'package:flutter/material.dart';
import 'package:health_arch/firebase_options.dart';
import 'package:health_arch/screens/Home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
  }

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: const HomeScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    ),
  ));
}
