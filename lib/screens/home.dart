import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_presenter.dart';
import 'package:weather_app/components/home_components.dart';
import 'package:weather_app/components/weather_detail_view.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/url_maker.dart';
import 'package:weather_app/utils/size.dart';
import 'package:weather_app/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.white60, BlendMode.color),
                  image: AssetImage('assets/images/background.jpg'),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              child: ContentsHomeScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentsHomeScreen extends StatefulWidget {
  @override
  _ContentsHomeScreenState createState() => _ContentsHomeScreenState();
}

class _ContentsHomeScreenState extends State<ContentsHomeScreen>
    implements WeatherView {
  Weather weather;
  WeatherPresenter _presenter;
  TextEditingController _searchCityName = TextEditingController();
  APIUrl _apiUrl = APIUrl();

  _ContentsHomeScreenState() {
    _presenter = WeatherPresenter(this);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    /// init url
    await _apiUrl.getUrlFromPosition();

    _presenter.loadData();
  }

  @override
  getWeather(Weather weather) {
    setState(() {
      this.weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return weather != null
        ? CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  weather.fullLocation,
                  style: bTextStyleLocation,
                ),
                leading: IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: () async {
                    await _apiUrl.getUrlFromPosition();
                    setState(() {
                      _presenter.loadData();
                    });
                  },
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: MainWeather(
                    temp: weather.temp,
                    status: weather.status,
                    icon: weather.icon,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    WeatherDetailsView(
                      'Weather',
                      weather.description.toString(),
                      Icons.cloud,
                    ),
                    WeatherDetailsView(
                      'Pressure',
                      weather.pressure.toString(),
                      Icons.pie_chart,
                      unit: ' hPa',
                    ),
                    WeatherDetailsView(
                      'Visibility',
                      weather.visibility.toString(),
                      Icons.remove_red_eye,
                      unit: ' m',
                    ),
                    WeatherDetailsView(
                      'Wind Speed',
                      '${weather.windSpeed}',
                      Icons.toys,
                      unit: ' m/s',
                    ),
                    WeatherDetailsView(
                      'Humidity',
                      weather.humidity.toString(),
                      Icons.opacity,
                      unit: '%',
                    ),
                    WeatherDetailsView(
                      'Timezone',
                      'UTC+' + weather.timezone.toString(),
                      Icons.av_timer,
                    ),
                    Container(
                      height: height * 0.5,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: _searchCityName,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Type city here ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text('Search', style: bTextStyleLocation),
                            color: Colors.transparent,
                            onPressed: () async {
                              await _apiUrl
                                  .getUrlFromSearch(_searchCityName.text);
                              print(APIUrl.url);
                              setState(() {
                                _presenter.loadData();
                              });
                            },
                          ),
                          Text(
                            'By Brahim CHOUIH',
                            style: bTextStyleAboutMe,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: Theme(
              data: ThemeData(accentColor: Color(0xFFcecece)),
              child: CircularProgressIndicator(),
            ),
          );
  }
}
