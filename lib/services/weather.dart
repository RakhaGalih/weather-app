import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const apiKey = '4613426e494268458cb7a13176b96149';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapTodayURL =
    'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getTodayCityWeather(String cityName) async {
    var url = '$openWeatherMapTodayURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getTodayLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapTodayURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition == 200 || (condition <= 232 && condition >= 230)) {
      return 'rainwstorm';
    } else if (condition < 300) {
      return 'thunderstorm';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition < 600) {
      return 'rain';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition == 781) {
      return 'tornado';
    } else if (condition < 800) {
      return 'wind';
    } else if (condition == 801) {
      return 'sunny';
    } else if (condition == 802) {
      return 'cloudwsun';
    } else if (condition <= 804) {
      return 'cloud';
    } else {
      return 'error';
    }
  }

  String getMessage(int condition) {
    if (condition == 200 || (condition <= 232 && condition >= 230)) {
      return 'Rain with Storm';
    } else if (condition < 300) {
      return 'Thunderstorm';
    } else if (condition < 400) {
      return 'Drizzle';
    } else if (condition < 600) {
      return 'Rainy';
    } else if (condition < 700) {
      return 'Snowy';
    } else if (condition == 781) {
      return 'Tornado';
    } else if (condition < 800) {
      return 'Windy';
    } else if (condition == 801) {
      return 'Sunny';
    } else if (condition == 802) {
      return 'Sunny Cloudy';
    } else if (condition <= 804) {
      return 'Cloudy';
    } else {
      return 'error';
    }
  }

  Color getWeatherAmbience(int condition) {
    if (condition == 200 || (condition <= 232 && condition >= 230)) {
      return const Color(0xFFFAE636).withOpacity(0.4);
    } else if (condition < 700) {
      return const Color(0xFF369CFA).withOpacity(0.4);
    } else if (condition == 781) {
      return const Color(0xFFFFFBDC).withOpacity(0.4);
    } else if (condition < 800) {
      return const Color(0xFF369CFA).withOpacity(0.4);
    } else if (condition == 801) {
      return const Color(0xFFFAE636).withOpacity(0.4);
    } else if (condition <= 804) {
      return const Color(0xFFFFFBDC).withOpacity(0.4);
    } else {
      return const Color(0xFFFAE636).withOpacity(0.4);
    }
  }
}
