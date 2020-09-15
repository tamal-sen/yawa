import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:yet_another_weather_app/src/services/open_weather_map.dart';
import 'package:yet_another_weather_app/src/services/weather.dart';
import 'package:yet_another_weather_app/src/utils/color_utils.dart';
import 'package:yet_another_weather_app/src/utils/constants.dart';
import 'package:yet_another_weather_app/src/utils/helper.dart';
import 'package:yet_another_weather_app/src/widgets/daily_forecast_list.dart';
import 'package:yet_another_weather_app/src/widgets/hourly_forecast_scroller.dart';
import 'package:yet_another_weather_app/src/widgets/weather_info.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.locationWeather, this.cityName});

  final locationWeather;
  final cityName;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  OWMOneCallAPIParser weather;
  Animation _weatherIconAnimation;
  AnimationController _weatherIconAnimationController;

  var weatherData;
  DateTime currentBackPressTime;
  double latitude, longitude;

  final String currentDate = getTime(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      dateFormat: "EEEE, MMM d",
      inMilli: true );


  @override
  void initState() {
    super.initState();
    _weatherIconAnimationController =
        AnimationController(vsync: this, duration: Duration(minutes: 1));
    _weatherIconAnimation =
        Tween(begin: 0.0, end: 3.1416).animate(_weatherIconAnimationController);

//    _weatherIconAnimationController.forward();

    weather = OWMOneCallAPIParser.fromJson(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: getThemedBackgroundFromTemperature(weather.current.temp.toInt()),
              // stops: [0.8, 0.96],
            ),
          ),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.all(30),
              child: Stack(
//                fit: StackFit.passthrough,
                overflow: Overflow.clip,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(width: 0,),
                            Container(
                              height: 55,
                              child: Center(
                                child: Text(
                                  currentDate,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'no functionality yet',
                              waitDuration: Duration(milliseconds: 10),
                              child: Text('°C', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Colors.white,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cityName,
                                  style: kNormalTextStyle,
                                ),
                                SizedBox(height: 50),
                                Text(
                                  '${weather.current.temp.toStringAsFixed(0)}°',
                                  style: TextStyle(
                                      fontSize: 100, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.keyboard_arrow_up,
                                        color: Colors.white54),
                                    Text(
                                      '${weather.daily.first.temp.max.toStringAsFixed(0)}°',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white54,
                                    ),
                                    Text(
                                      '${weather.daily.first.temp.min.toStringAsFixed(0)}°',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  weather.current.weather.first.main,
                                  style: kNormalTextStyle,
                                ),
                                Text(
                                  'Feels like ${weather.current.feelsLike.toStringAsFixed(0)}°',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
//                                SizedBox(width: 150,),
                                Transform.scale(
                                  scale: 2.4,
                                    alignment: Alignment(-1.5, 0),
                                  child: Container(
//                                    alignment: Alignment(10, 10),
                                    padding: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white12),
                                    child: BoxedIcon(
                                      getWeatherCondition(
                                              weather.current.weather.first.id)
                                          .icon,
                                      size: 55,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
//                              Transform.scale(
//                                scale: 2.3,
//                                alignment: Alignment(-1.6, 0),
//                                child: Container(
//                                  padding: EdgeInsets.all(30),
//                                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
//                                      color: Colors.white12),
//                                  child: AnimatedBuilder(
//                                    animation: _weatherIconAnimationController,
//                                    builder: (context, child) =>
//                                        Transform.rotate(
//                                      angle: _weatherIconAnimation.value,
//                                      alignment: Alignment.center,
//                                      child: Icon(
//                                          getWeatherCondition(weather
//                                                  .current.weather.first.id)
//                                              .icon,
//                                          size: 35,
//                                          color:
//                                              Colors.white.withOpacity(0.75)),
//                                    ),
//                                  ),
//                                ),
//                              ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ScrollBottomPanel(
                    weather: weather,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {

    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      print('budget snacc bar');
      currentBackPressTime = now;
      return Future.value(false);
    }
    print('should exit');
    SystemNavigator.pop(animated: true);
    return Future.value(true);
  }
}



class ScrollBottomPanel extends StatefulWidget {
  final OWMOneCallAPIParser weather;

  ScrollBottomPanel({this.weather});

  @override
  _ScrollBottomPanelState createState() => _ScrollBottomPanelState();
}

class _ScrollBottomPanelState extends State<ScrollBottomPanel> {
  bool scrollbarAtBottom = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .4,
      expand: true,
      minChildSize: .4,
      maxChildSize: .9,
      builder: (BuildContext context, ScrollController scrollController) {
//        bool isAnimating = true;
//        _moveUp() {
//          isAnimating = true;
//          scrollController.animateTo(scrollController.offset + 800,
//              curve: Curves.linear, duration: Duration(milliseconds: 500));
//          isAnimating = false;
//        }

        return NotificationListener<DraggableScrollableNotification>(
          //TODO: Implement auto-snap to top/bottom on scroll
          onNotification: (DraggableScrollableNotification scrollState) {
            setState(() {
              if (scrollState.extent > scrollState.minExtent) {
                scrollbarAtBottom = false;
              } else {
                scrollbarAtBottom = true;
              }
            });
//              print(scrollState);
//              if (scrollState.extent > scrollState.minExtent &&
//                  scrollState.extent < scrollState.maxExtent) {
//                Future.delayed(const Duration(milliseconds: 100), () {})
//                    .then((s) {
//                  print('should trigger auto scroll');
//                  scrollController.animateTo(120.0,
//                      duration: Duration(milliseconds: 500),
//                      curve: Curves.ease);
//                });
//              }
            return true;
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: scrollbarAtBottom ? 0.0 : 15.00,
                    sigmaY: scrollbarAtBottom ? 0.0 : 15.00,
                  ),
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0x20FFFFFF),
                      ),
                      HourlyForecastScroller(
                        weather: widget.weather,
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0x20FFFFFF),
                      ),
                      DailyForecast(
                        weather: widget.weather,
                      ),
                      WeatherInfo(weather: widget.weather),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
