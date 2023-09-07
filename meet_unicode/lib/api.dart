import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherAPI {
  static Future<http.Response> fetchWeather(
      double latitude, double longitude) async {
    return await http
        .get(Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': 'be6e1733ce7b19db1819effa5afa1443'
    }));
  }
}

/*

Sample API JSON MODEL

{
   "coord":{
      "lon":72.8276,
      "lat":19.3857
   },
   "weather":[
      {
         "id":500,
         "main":"Rain",
         "description":"light rain",
         "icon":"10d"
      }
   ],
   "base":"stations",
   "main":{
      "temp":298.12,
      "feels_like":298.81,
      "temp_min":298.12,
      "temp_max":299.16,
      "pressure":1006,
      "humidity":82,
      "sea_level":1006,
      "grnd_level":1006
   },
   "visibility":7229,
   "wind":{
      "speed":5.23,
      "deg":285,
      "gust":7.13
   },
   "rain":{
      "1h":0.13
   },
   "clouds":{
      "all":100
   },
   "dt":1694068481,
   "sys":{
      "type":1,
      "id":9068,
      "country":"IN",
      "sunrise":1694048084,
      "sunset":1694092772
   },
   "timezone":19800,
   "id":1253133,
   "name":"Virār",
   "cod":200
}
*/