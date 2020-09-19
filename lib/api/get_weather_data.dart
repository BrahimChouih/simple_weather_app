import 'package:weather_app/model/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/services/url_maker.dart';

class WeatherData {
  static Mode mode = Mode.test;
  Dio _dio = new Dio();

  Future<Weather> getData() {
    if (mode == Mode.test) {
      return Future.value(Weather(dataWeather));
    } else {
      return getDataFromAPI();
    }
  }

  Future<Weather> getDataFromAPI() async {
    return _dio.get(APIUrl.url).then((value) {
      if (value.statusCode == 200) {
        return Weather(value.data);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}

enum Mode {
  test,
  real,
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/////// demo data
Map<String, dynamic> dataWeather = {
  "coord": {"lon": 2.75, "lat": 36.26},
  "weather": [
    {
      "id": 801,
      "main": "Clouds",
      "description": "few clouds",
      "icon": "02n",
    }
  ],
  "base": "stations",
  "main": {
    "temp": 296.15,
    "feels_like": 298.82,
    "temp_min": 296.15,
    "temp_max": 296.15,
    "pressure": 1022,
    "humidity": 88,
  },
  "visibility": 10000,
  "wind": {
    "speed": 2.1,
    "deg": 100,
  },
  "clouds": {"all": 20},
  "dt": 1600034012,
  "sys": {
    "type": 1,
    "id": 1060,
    "country": "DZ",
    "sunrise": 1599975010,
    "sunset": 1600019984,
  },
  "timezone": 3600,
  "id": 2488835,
  "name": "Médéa",
  "cod": 200,
};
