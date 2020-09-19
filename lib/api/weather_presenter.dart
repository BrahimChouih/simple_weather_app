import 'package:weather_app/api/get_weather_data.dart';
import 'package:weather_app/model/weather_model.dart';

abstract class WeatherView {
  getWeather(Weather weather);
}

class WeatherPresenter {
  WeatherView _view;
  WeatherData _weather;

  WeatherPresenter(this._view) {
    _weather = WeatherData();
  }

  loadData() {
    _weather.getData().then((value) => _view.getWeather(value));
  }
}
