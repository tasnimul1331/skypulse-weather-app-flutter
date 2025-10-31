import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skypulse/services/weather.dart';
import 'package:skypulse/screens/weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    Map<String, dynamic> forecastData = await weatherModel
        .getLocationWeatherForecast();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WeatherScreen(weatherData: weatherData, forecastData: forecastData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SpinKitDoubleBounce(color: Colors.grey, size: 100.0),
      ),
    );
  }
}
