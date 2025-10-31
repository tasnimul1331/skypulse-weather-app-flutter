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
  List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String countryName = '';
  String description = '';
  int pressure = 0;
  double visibility = 0;
  int humidity = 0;
  String toDateForecast = '';
  String toDayForecast = '';

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
        toDayForecast = '';
        pressure = 0;
        visibility = 0;
        humidity = 0;
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      countryName = weatherData['sys']['country'];
      description = weatherModel.getMessage(
        temperature,
      ); // Get message based on temperature

      // 👇 get icon code safely
      String iconCode = weatherData['weather'][0]['icon'];

      // 👇 build full image URL
      weatherIcon = 'https://openweathermap.org/img/wn/$iconCode@4x.png';
      pressure = weatherData['main']['pressure'];
      visibility = weatherData['visibility'] / 1000; // Convert to km
      humidity = weatherData['main']['humidity'];
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        weatherData['dt'] * 1000,
      );
      toDateForecast = "${dateTime.day}";

      toDayForecast = days[dateTime.weekday % 7];
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
                        fontSize: 58,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Today, $toDateForecast $toDayForecast",
                        style: const TextStyle(
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
                    flex: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          widget
                              .forecastData
                              .length, // dynamically based on your map size
                          (index) {
                            var key = "day$index";
                            var data = widget.forecastData[key];
                            if (data == null) return SizedBox();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: HourlyForecastItem(
                                day: data["time"],
                                condition: data["id"],
                                temperature: "${data["temp"].toInt()}°C",
                              ),
                            );
                          },
                        ),
                      ),
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
