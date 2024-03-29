import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_my_class/screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFFE8E8E8),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Colors.lightBlueAccent
      ),
      home: LandingPage(),
      );
  }
}



