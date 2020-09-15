import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yet_another_weather_app/src/screens/loading_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  await DotEnv().load('.env');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
//        systemNavigationBarColor: Colors.amber,

    ),
  );
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YAWA',
      theme: ThemeData(
        fontFamily: 'Mont',
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
          bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      home: LoadingScreen(),
    );
  }
}
