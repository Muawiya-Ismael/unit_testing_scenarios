import 'package:unit_testing_scenarios/models/weather_api_client.dart';

class WeatherService {
  final WeatherApiClient apiClient;

  WeatherService(this.apiClient);

  Future<double> getTemperature(String city) async {
    try {
      final temperature = await apiClient.fetchTemperature(city);
      return temperature;
    } catch (e) {
      throw Exception("Failed to fetch temperature for $city");
    }
  }
}
