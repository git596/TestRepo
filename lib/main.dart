import 'package:flutter/material.dart';
import 'package:weatherapp/weather_screen.dart';    //import weather_screen.dart file 

void main() {
  runApp(const MyApp());
  print("This is a test message for Gihub, hehehehehehe");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,      //to remove the default banner displayed in the app
      home: const WeatherScreen(),          //call weather_screen class
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 1, 18, 28), // Set desired background color of entire app
      ),
    );
  }
}