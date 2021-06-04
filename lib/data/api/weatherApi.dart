import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weather/util/api_result.dart';
import 'package:weather/util/exception.dart';
import 'package:weather/config.dart';
import 'package:weather/util/network_exceptions.dart';

class WeatherApi {
  static String weatherApiBase = 'https://api.openweathermap.org/data/2.5/';
  static String googleBase =
      'https://maps.googleapis.com/maps/api/geocode/json';

  dynamic formatResponse(response) {
    var statusCode = response.statusCode;

    if (statusCode! >= 200 && statusCode < 299) {
      return response.data;
    } else if (statusCode >= 400 && statusCode < 500) {
      print("aaaaaaaya");
      throw ClientErrorException('Invalid Data');
    } else if (statusCode >= 500 && statusCode < 600) {
      throw ServerErrorException("ServerError");
    } else {
      throw UnknownException("Unknown Error");
    }
  }

  dynamic formatError(err) {
    print("!!!!!!!!!!!!!!!!!!!!111");
    print(err.statusCode);
    print("!!!!!!!!!!!!!!!!!!!!111");
  }

  dynamic fetchWeather(location) async {
    try {
      String url =
          '$weatherApiBase/weather?q=$location&units=metric&appid=$WeatherApiKey';
      var response = await Dio().get(url);
      return response.data;
    } catch (err) {
      throw NetworkExceptions.getDioException(err);
    }
  }

  dynamic fetchWeatherLatLong(lat, long) async {
    try {
      String url =
          '$weatherApiBase/onecall?lat=$lat&lon=$long&units=metric&appid=$WeatherApiKey';
      var response = await Dio().get(url);
      return response.data;
    } catch (err) {
      throw NetworkExceptions.getDioException(err);
    }
  }

  dynamic getGeoLocation(lat, long) async {
    try {
      String url =
          "$googleBase?latlng=$lat,$long&sensor=true&key=$GoogleApiKey";
      var response = await Dio().get(url);
      return response.data;
    } catch (err) {
      throw NetworkExceptions.getDioException(err);
    }
  }
}
