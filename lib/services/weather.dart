import '../services/location_service.dart';
import '../services/network.dart';

const apiKey = 'af978ef839b2a0d7eeb73526813ee26b';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

const openWeatherMapForecastURL = 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networking networkingByLongitudeAndLatitude = Networking(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );
    return await networkingByLongitudeAndLatitude.getData();
  }


  Future<dynamic> getLocationWeatherForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networking networkingByLongitudeAndLatitude = Networking(
      '$openWeatherMapForecastURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );
    return await networkingByLongitudeAndLatitude.getForecastData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'গরমে হাঁসফাঁস! পানি পান করুন 🥵';
    } else if (temp > 30) {
      return 'ভীষণ গরম, ছাতা ও পানির বোতল নিন ☀️';
    } else if (temp > 25) {
      return 'আরামদায়ক আবহাওয়া, বাইরে ঘুরে আসুন 🙂';
    } else if (temp > 20) {
      return 'হালকা ঠান্ডা, পাতলা জামা পরুন 🧥';
    } else {
      return 'শীত পড়েছে, গরম কাপড় নিন ❄️';
    }
  }
}
