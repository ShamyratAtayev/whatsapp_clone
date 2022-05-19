import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme(
          primary: Color(0xFF075E54),
          primaryVariant: Colors.red,
          secondary: Color(0xFF128C7E),
          onPrimary: Colors.white,
          background: Colors.white,
          surface: Colors.white,
          onSurface: Colors.white,
          secondaryVariant: Colors.black,
          error: Colors.red,
          onBackground: Colors.black,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          onError: Colors.black,
        ),
      ),
      home: Home(),
    );
  }
} 


 
      


      //  theme: ThemeData(
      //   primaryColor: Color(0xFF075E54), 
      //   accentColor: Color(0xFF128C7E)
      // ),