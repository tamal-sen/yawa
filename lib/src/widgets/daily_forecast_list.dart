import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/src/utils/constants.dart';
import 'package:yet_another_weather_app/src/services/open_weather_map.dart';
import 'package:yet_another_weather_app/src/utils/helper.dart';
import 'package:yet_another_weather_app/src/services/weather.dart';

class DailyForecast extends StatelessWidget {
  final OWMOneCallAPIParser weather;

  DailyForecast({this.weather});

  @override
  Widget build(BuildContext context) {
    List<Widget> items =[];
//    WeatherModel weatherModel = WeatherModel();
    if(weather != null) {
      weather.daily.getRange(1, 8).forEach((e) {
        items.add(
          forecastItemBuilder(
            day: getTime(dateTime: e.dt, dateFormat: "EEEE"),
              weather: getWeatherCondition(e.weather.first.id).icon,
              maxTemp: e.temp.max.toStringAsFixed(0),
              minTemp: e.temp.min.toStringAsFixed(0)

          ),
        );
      });

    }
    return Container(
//      color: Colors.white12.withOpacity(0.1),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
//      height: 10,
      child: Column(
//        scrollDirection: Axis.vertical,
        children: items
      ),
    );
  }

  Widget forecastItemBuilder(
      {String day, IconData weather, String maxTemp, String minTemp}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              day,
              style: kSmallTextStyle,
            ),
          ),
          Expanded(
            flex: 5,
            child: Icon(weather),
          ),
          // SizedBox(height: 15,),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text(
                    maxTemp + '°',
                    style: kSmallTextStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    minTemp + '°',
                    style: kSmallTransparentTextStyle,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

