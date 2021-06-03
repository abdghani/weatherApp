import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/api/weatherApi.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

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
        // print(weather);
        yield WeatherLoaded(weather);
      } catch (err) {
        yield WeatherError("Coudlt fetch Weather ! device offline");
      }
    }
  }
}
