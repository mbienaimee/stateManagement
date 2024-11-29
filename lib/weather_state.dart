class WeatherState {
  final String city;
  final double temperature;
  final int humidity;
  final String description;

  WeatherState({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.description,
  });

  // Initial empty state
  factory WeatherState.initial() {
    return WeatherState(
      city: '',
      temperature: 0.0,
      humidity: 0,
      description: '',
    );
  }
}
