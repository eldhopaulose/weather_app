part of 'weather_bloc.dart';

class WeatherState {
  final bool isLoading;
  final weatherModel? result;

  WeatherState({required this.isLoading, this.result});
}

class WeatherInitial extends WeatherState {
  WeatherInitial({required super.isLoading});
}
