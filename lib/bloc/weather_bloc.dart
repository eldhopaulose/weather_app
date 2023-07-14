import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/reprository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial(isLoading: false)) {
    on<WeatherEvent>((event, emit) async {
      if (event is FeatchApiEvent) {
        print(FeatchApiEvent);
        emit(WeatherState(isLoading: true));
        print(event.cityName);
        final data = await WeatherRepository.fetchWeathersApi(event.cityName);
        print(data);
        emit(WeatherState(isLoading: false, result: data));
      }
    });
  }
}
