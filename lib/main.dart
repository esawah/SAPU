import 'package:flutter/material.dart';
import 'package:sapu/Screens/home_page.dart';
import 'package:sapu/Screens/import_page.dart';
import 'package:sapu/Screens/landing_page.dart';
import 'package:sapu/Screens/landing_page2.dart';
import 'package:sapu/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/landing_page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', 
        useMaterial3: true,
        ),
      routes: {
        '/landing_page': (context) => (LandingPage2()),
        '/import_page': (context) => ImportPage(),
        '/home_page': (context) => HomePage(),
      },
      home: const LandingPage2(),
    );
  }
}