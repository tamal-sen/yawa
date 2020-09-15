import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:yet_another_weather_app/src/utils/constants.dart';
import 'package:yet_another_weather_app/src/services/open_weather_map.dart';
import 'package:yet_another_weather_app/src/utils/helper.dart';

class WeatherInfo extends StatelessWidget {
  final OWMOneCallAPIParser weather;

  WeatherInfo({this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Wrap(
        children: [
          _buildWeatherInfoItem(
            'Sunrise',
            getTime(dateTime: weather.current.sunrise).toLowerCase(),
            WeatherIcons.sunrise
          ),
          _buildWeatherInfoItem(
            'Sunset',
            getTime(dateTime: weather.current.sunset).toLowerCase(),
            WeatherIcons.sunset
          ),
          _buildWeatherInfoItem(
            'Clouds',
            '${weather.current.clouds}%',
            WeatherIcons.cloudy
          ),
          _buildWeatherInfoItem(
            'Humidity',
            '${weather.current.humidity}%',
            WeatherIcons.raindrop
          ),
          _buildWeatherInfoItem(
            'Wind',
            '${weather.current.windSpeed} m/s',
            WeatherIcons.strong_wind
          ),
          _buildWeatherInfoItem(
            'Pressure',
            '${weather.current.pressure} hPa',
            WeatherIcons.barometer
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoItem(String title, String value, IconData WeatherIconData) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Center(
                child: BoxedIcon(
                  WeatherIconData,
                  size: 20,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kSmallTransparentTextStyle,
                ),
                Text(
                  value,
                  style: kNormalTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
