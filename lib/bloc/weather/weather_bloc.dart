import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/api/weatherApi.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  getLocName(googleResult) {
    try {
      var cmpdName = googleResult['plus_code']['compound_code'];
      return cmpdName.split(" ").sublist(1).join(" ");
    } catch (err) {
      return '';
    }
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final dynamic weatherTemp =
            await WeatherApi().fetchWeather(event.cityName);
        dynamic coord = weatherTemp['coord'];
        final dynamic weather =
            await WeatherApi().fetchWeatherLatLong(coord['lat'], coord['lon']);
        weather['basic'] = weatherTemp;
        dynamic loc =
            await WeatherApi().getGeoLocation(coord['lat'], coord['lon']);
        weather['loc_name'] = getLocName(loc);

        yield WeatherLoaded(weather);
      } catch (err) {
        yield WeatherError("Coudnt't fetch Weather ");
      }
    } else if (event is GetWeatherLatLong) {
      // if latitude and longitude is provided
      final dynamic weather = await WeatherApi()
          .fetchWeatherLatLong(event.latitude, event.longitude);
      dynamic loc =
          await WeatherApi().getGeoLocation(event.latitude, event.longitude);
      weather['loc_name'] = getLocName(loc);
      yield WeatherLoaded(weather);
    }
  }
}
