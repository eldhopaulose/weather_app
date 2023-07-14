import 'package:dio/dio.dart';
import 'package:weather_app/app_id.dart';
import 'package:weather_app/models/models.dart';

final _dio = Dio();

class WeatherRepository {
  static Future<weatherModel?> fetchWeathersApi(String cityName) async {
    print("repo " + cityName);
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'q': cityName,
          'appid': appId,
        },
      );
      print(response.data ?? "no response");
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          return weatherModel.fromJson(data);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data');
    }
  }
}
