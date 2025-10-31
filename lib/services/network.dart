import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future getForecastData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return getNextFourForecasts(jsonDecode(data)['list']);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Map<String, dynamic> getNextFourForecasts(List<dynamic> hourlyForecastData) {
    Map<String, dynamic> weatherData = {};
    List<String> dayName = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    DateTime now = DateTime.now();
    int addedCount = 0;

    for (var forecast in hourlyForecastData) {
      DateTime dateTime = DateTime.parse(forecast['dt_txt']);

      // Only future forecasts
      if (dateTime.day == now.day) {
        double temp = forecast['main']['temp'];
        int idIcon = forecast['weather'][0]['id'];
        String day = dayName[dateTime.weekday % 7];
        String time = "${dateTime.hour.toString().padLeft(2, '0')}:00";

        weatherData["day$addedCount"] = {
          "date": day,
          "time": time,
          "temp": temp,
          "id": idIcon,
        };

        addedCount++; // stop after all forecasts
      }
    }

    print(weatherData);
    return weatherData;
  }
}
