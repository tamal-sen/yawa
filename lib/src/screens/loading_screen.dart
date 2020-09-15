import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/src/screens/weather_screen.dart';
import 'package:yet_another_weather_app/src/services/location.dart';
import 'package:yet_another_weather_app/src/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude, longitude;
  var weatherData;

  @override
  void initState() {
    super.initState();
    getLocationData();

  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    await location.getCityName();

    latitude = location.latitude;
    longitude = location.longitude;
    print(location.subAdminArea);


    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&exclude={minutely}&units=metric&appid=${DotEnv().env['OWM_API_KEY']}');

    weatherData = await networkHelper.getData();
    print(weatherData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(locationWeather: weatherData, cityName: location.subAdminArea),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Okay guys, no, I am not gonna use another package for just a
    // loading state. I guess it will be easy just to add a spinner
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 15),
            Text('Getting weather data..')
          ],
        ),
      ),
    );
  }
}
