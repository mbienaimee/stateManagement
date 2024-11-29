import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_state.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    const String apiKey = 'fc0846d43a46c60de0e37f796406c486'; // Replace with your API key
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        state = WeatherState(
          city: data['name'], // Fetch the city name from the response
          temperature: data['main']['temp'], // Temperature in Celsius
          humidity: data['main']['humidity'], // Humidity percentage
          description: data['weather'][0]['description'], // Weather description
        );
      } else if (response.statusCode == 404) {
        state = WeatherState(
          city: 'City not found',
          temperature: 0.0,
          humidity: 0,
          description: 'Please enter a valid city name.',
        );
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      state = WeatherState(
        city: 'Error',
        temperature: 0.0,
        humidity: 0,
        description: 'Failed to fetch data: ${e.toString()}',
      );
    }
  }
}

// Create a provider
final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});
