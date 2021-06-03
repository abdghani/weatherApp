import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/util/exception.dart';

class WeatherApi {
  dynamic fetchWeather(location) async {
    try {
      String appId = '241732a3364db82052ee155f67a71332';
      String url =
          'http://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$appId';
      var response = await Dio().get(url);
      var statusCode = response.statusCode;

      if (statusCode! >= 200 && statusCode < 299) {
        return response.data;
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }

  dynamic fetchWeatherLatLong(lat, long) async {
    try {
      String appId = '241732a3364db82052ee155f67a71332';
      String url =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&units=metric&appid=$appId';
      var response = await Dio().get(url);
      var statusCode = response.statusCode;

      if (statusCode! >= 200 && statusCode < 299) {
        return response.data;
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }
}
