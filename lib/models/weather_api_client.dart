class WeatherApiClient {
  Future<double> fetchTemperature(String city) async {
    await Future.delayed(const Duration(seconds: 1));

    if (city == "London") {
      return 15.0;
    } else if (city == "New York") {
      return 20.0;
    } else {
      throw Exception("City not found");
    }
  }
}

