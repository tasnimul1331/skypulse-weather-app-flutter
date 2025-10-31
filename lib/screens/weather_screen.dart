import 'package:flutter/material.dart';
import 'package:skypulse/resuable_content.dart';
import 'package:skypulse/services/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
    required this.weatherData,
    required this.forecastData,
  });

  final Map<String, dynamic> forecastData;
  final dynamic weatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String countryName = '';
  String description = '';
  int pressure = 0;
  double visibility = 0;
  int humidity = 0;

  String fourDayForecast = '';
  String fourTempForecast = '';
  String fourIconForecast = '';

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData, widget.forecastData);
  }

  void updateUI(dynamic weatherData, Map<String, dynamic> forecastData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        description = 'Unable to get weather data';
        cityName = '';
        countryName = '';
        fourDayForecast = '';
        fourTempForecast = '';
        fourIconForecast = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      countryName = weatherData['sys']['country'];
      description = weatherData['weather'][0]['description'];

      // 👇 get icon code safely
      String iconCode = weatherData['weather'][0]['icon'];

      // 👇 build full image URL
      weatherIcon = 'https://openweathermap.org/img/wn/$iconCode@4x.png';
      pressure = weatherData['main']['pressure'];
      visibility = weatherData['visibility'] / 1000; // Convert to km
      humidity = weatherData['main']['humidity'];
      fourDayForecast = forecastData["day0"]["date"];
      fourTempForecast = forecastData["day0"]["temp"].toString();
      fourIconForecast = forecastData["day0"]["icon"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(
                top: 40.0,
                left: 15.0,
                right: 15.0,
                bottom: 10.0,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                '$cityName , $countryName',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //* middle part logo and tagline
          Expanded(
            flex: 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(weatherIcon),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      '$temperature°',
                      style: const TextStyle(
                        fontSize: 70,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 34, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          //* bottom part weather info
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 15.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE4E4E4),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //* Today text
                  Expanded(
                    flex: 1,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //* Info row
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherInfoItem(
                            label: "Pressure",
                            value: "$pressure hPa",
                          ),
                          WeatherInfoItem(
                            label: "Visibility",
                            value: "$visibility km",
                          ),
                          WeatherInfoItem(
                            label: "Humidity",
                            value: "$humidity%",
                          ),
                        ],
                      ),
                    ),
                  ),
                  //* Hourly forecast
                  Expanded(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HourlyForecastItem(
                          day: fourDayForecast,
                          icon:
                              NetworkImage(
                                    'https://openweathermap.org/img/wn/$fourIconForecast@2x.png',
                                  )
                                  as IconData,
                          temperature: "$fourTempForecast°C",
                        ),
                        HourlyForecastItem(
                          day: fourDayForecast,
                          icon:
                              NetworkImage(
                                    'https://openweathermap.org/img/wn/$fourIconForecast@2x.png',
                                  )
                                  as IconData,
                          temperature: "$fourTempForecast°C",
                        ),
                        HourlyForecastItem(
                          day: fourDayForecast,
                          icon:
                              NetworkImage(
                                    'https://openweathermap.org/img/wn/$fourIconForecast@2x.png',
                                  )
                                  as IconData,
                          temperature: "$fourTempForecast°C",
                        ),
                        HourlyForecastItem(
                          day: fourDayForecast,
                          icon:
                              NetworkImage(
                                    'https://openweathermap.org/img/wn/$fourIconForecast@2x.png',
                                  )
                                  as IconData,
                          temperature: "$fourTempForecast°C",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
