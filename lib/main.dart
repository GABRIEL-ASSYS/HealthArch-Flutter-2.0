import 'package:flutter/material.dart';
import 'package:health_arch/screens/Home/home_screen.dart';

void main() => runApp(MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
    ));
