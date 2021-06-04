part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetWeatherLatLong extends WeatherEvent {
  final double latitude;
  final double longitude;

  GetWeatherLatLong(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}
