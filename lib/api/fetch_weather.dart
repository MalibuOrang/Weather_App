import 'dart:convert';
import 'package:flutter_weather_app/model/weather_data.dart';
import 'package:flutter_weather_app/model/weather_data_current.dart';
import 'package:flutter_weather_app/model/weather_data_daily.dart';
import 'package:flutter_weather_app/model/wether_data_hourly.dart';
import 'package:http/http.dart' as http;

import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
// processing weather data from the server -> to json
  Future<WeatherData?> getWeatherData(lat, lon) async {
    var responce = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(responce.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );
    return weatherData;
  }
}
