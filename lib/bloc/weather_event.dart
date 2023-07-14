part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FeatchApiEvent extends WeatherEvent {
  final String cityName;

  FeatchApiEvent(this.cityName);
}
