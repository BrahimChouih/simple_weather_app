import 'package:flutter/material.dart';
import 'package:weather_app/api/get_weather_data.dart';
import 'package:weather_app/screens/home.dart';

void main() {
  WeatherData.mode = Mode.real;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Weather app',
      home: HomeScreen(),
    );
  }
}
