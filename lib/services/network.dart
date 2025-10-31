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
      return getFourDayAfternoonForecast(jsonDecode(data)['list']);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Map<String, dynamic> getFourDayAfternoonForecast(
    List<dynamic> hourlyForecastData,
  ) {
    Map<String, dynamic> weatherData = {};
    List<String> dayName = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    for (int i = 0; i < 4; i++) {
      int idx = i * 8 + 4; // 12 PM for each day
      if (idx >= hourlyForecastData.length) break; // safety check

      DateTime dateTime = DateTime.parse(hourlyForecastData[idx]['dt_txt']);
      String date = dayName[dateTime.weekday % 7];
      double temp = hourlyForecastData[idx]['main']['temp'];
      String icon = hourlyForecastData[idx]['weather'][0]['icon'];

      weatherData["day$i"] = {"date": date, "temp": temp, "icon": icon};
    }

    print(weatherData);
    return weatherData;
  }
}
