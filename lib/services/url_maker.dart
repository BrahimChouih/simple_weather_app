import 'package:location/location.dart';

class APIUrl {
  static String url;
  Location _location = Location();
  final _apiKey = 'fe70aba7b7eca1d2d6836d9ff429034d';

  Future<void> getUrlFromPosition() async {
    LocationData _locationData = await getCurrnetPosition();
    url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=' +
            _apiKey;
  }

  Future<void> makeUrl() async {}

  void getUrlFromSearch(String statment) {
    url = 'http://api.openweathermap.org/data/2.5/weather?q=$statment&appid=' +
        _apiKey;
  }

  Future<LocationData> getCurrnetPosition() async {
    try {
      await getPermission();
      return await _location.getLocation();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPermission() async {
    PermissionStatus _permission = await _location.hasPermission();

    while (_permission != PermissionStatus.granted) {
      await _location.requestPermission(); // init permission
      _permission = await _location.hasPermission();
    }
  }
}
