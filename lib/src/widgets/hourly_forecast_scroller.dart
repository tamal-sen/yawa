import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/src/services/open_weather_map.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:yet_another_weather_app/src/services/weather.dart';
import 'package:yet_another_weather_app/src/utils/helper.dart';

class HourlyForecastScroller extends StatelessWidget {
  final OWMOneCallAPIParser weather;

  HourlyForecastScroller({this.weather});

  @override
  Widget build(BuildContext context) {
    List<Widget> items =[];
    if(weather != null) {
      weather.hourly.getRange(0, 24).forEach((e) {
        items.add(
          hourlyForecastItem(
            time: getTime(dateTime: e.dt),
            temperature: e.temp.toStringAsFixed(0),
            WeatherIconData: getWeatherCondition(e.weather.first.id).icon

          ),
        );
      });
    }


    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      height: 80.0,
      child: ListView(scrollDirection: Axis.horizontal, children: items),
    );
  }

  Widget hourlyForecastItem({String time, String temperature, IconData WeatherIconData}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time.toLowerCase(),
            style: TextStyle(color: Colors.white70),
          ),
          // SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                temperature + '°',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              BoxedIcon(WeatherIconData, size: 16,),
            ],
          ),
        ],
      ),
    );
  }
}
