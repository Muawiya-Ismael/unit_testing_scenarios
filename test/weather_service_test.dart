

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../lib/models/weather_service.dart';
import '../lib/models/weather_api_client.dart';
import 'weather_service_test.mocks.dart';

@GenerateMocks([WeatherApiClient])
void main() {
  late WeatherService weatherService;
  late MockWeatherApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockWeatherApiClient();
    weatherService = WeatherService(mockApiClient);
  });

  group('WeatherService', () {
    test('returns temperature for a valid city', () async {
      // Arrange
      when(mockApiClient.fetchTemperature('London'))
          .thenAnswer((_) async => 15.0);

      final temperature = await weatherService.getTemperature('London');

      expect(temperature, 15.0);
    });

    test('throws an exception for an invalid city', () async {
      when(mockApiClient.fetchTemperature('InvalidCity'))
          .thenThrow(Exception('City not found'));

      var fetchTemperature = weatherService.getTemperature('InvalidCity');

      expect(fetchTemperature, throwsException);
    });

    test('handles network errors gracefully', () async {
      when(mockApiClient.fetchTemperature('London'))
          .thenThrow(Exception('Network error'));

      var fetchTemperature = weatherService.getTemperature('London');

      expect(fetchTemperature, throwsA(isA<Exception>()));
    });
  });
}
