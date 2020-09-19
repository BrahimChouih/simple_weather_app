import 'package:flutter/material.dart';
import 'package:weather_app/utils/size.dart';
import 'package:weather_app/utils/theme.dart';

class MainWeather extends StatelessWidget {
  final String status;
  final String icon;
  double temp;

  MainWeather({this.temp, this.status, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          SizedBox(height: height * 0.2),
          Text(
            '${temp.toInt()}°',
            style: bTextStyleDegree,
          ),
          Text(
            '${status}',
            style: bTextStyleDescription,
          ),
          SizedBox(height: height * 0.05),
          Container(
            child: Image.network(icon),
          ),
        ],
      ),
    );
  }
}
