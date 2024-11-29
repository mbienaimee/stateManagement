import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'weather_provider.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);

    final cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(weatherProvider.notifier)
                    .fetchWeather(cityController.text);
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            if (weather.city.isNotEmpty)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'City: ${weather.city}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Temperature: ${weather.temperature}°C',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Humidity: ${weather.humidity}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Description: ${weather.description}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
