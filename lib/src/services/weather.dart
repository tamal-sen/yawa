import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

WeatherCondition getWeatherCondition(int condition) {
  // All OWM condition codes can be found here
  // https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2

  if (condition < 300) {
    return WeatherCondition(
        icon: WeatherIcons.thunderstorm, condition: 'Thunderstorm');
  } else if (condition < 400) {
    return WeatherCondition(
        icon: WeatherIcons.raindrops, condition: 'Drizzle');
  } else if (condition < 600) {
    return WeatherCondition(icon: WeatherIcons.rain, condition: 'Rain');
  } else if (condition < 700) {
    return WeatherCondition(icon: WeatherIcons.snow, condition: 'Snow');
  } else if (condition < 800) {
    return WeatherCondition(
        icon: WeatherIcons.dust, condition: 'Mist/Haze');
  } else if (condition == 800) {
    return WeatherCondition(
        icon: WeatherIcons.day_sunny, condition: 'Clear');
  } else if (condition <= 804) {
    return WeatherCondition(
        icon: WeatherIcons.cloud, condition: 'Clouds');
  } else {
    return null;
  }
}

class WeatherCondition {
  final dynamic icon;
  final String condition;

  WeatherCondition({this.icon, this.condition});
}
