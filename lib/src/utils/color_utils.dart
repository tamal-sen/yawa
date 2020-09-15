import 'dart:math';
import 'package:flutter/material.dart';

//  Created by Tamal Sen

/*
    Algorithm taken from Tanner Helland's post: http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code/
    For further reading, try these following links:
    1. https://en.wikipedia.org/wiki/Color_temperature#Correlated_color_temperature
    2. Improving Tanner Helland's algo: http://www.zombieprototypes.com/?p=210
    3. Demo ^ https://emberglitch.com/color-temperature/

*/

// Given a temperature (in Kelvin), estimate an RGB equivalent
class KelvinColorConverter {
  final double temperature;

  KelvinColorConverter({this.temperature});

  double red, green, blue;

  Color toColor() {
    // Temperature must fall between 1000 and 40000 degrees
    // double newTemp = temperature < 1000 ? 1000 : (temperature > 40000 ? 40000 : temperature);
    /*
    But I am going to limit that from 1500K to 10000K as it contains all
    variations in this range.
    Here is a photo for that range
    https://tannerhelland.com/images/Temperature_to_RGB_1500_to_15000.png
     */

    double newTemp =
    temperature < 1500 ? 1500 : (temperature > 10000 ? 10000 : temperature);
    // All calculations require tmpKelvin \ 100, so only do the conversion once
    var percentKelvin = newTemp / 100;

    //Calculate each color in turn
    red = clamp(percentKelvin <= 66
        ? 255
        : (329.698727446 * pow(percentKelvin - 60, -0.1332047592)));
    green = clamp(percentKelvin <= 66
        ? (99.4708025861 * log(percentKelvin) - 161.1195681661)
        : 288.1221695283 * pow(percentKelvin, -0.0755148492));
    blue = clamp(percentKelvin >= 66
        ? 255
        : (percentKelvin <= 19
        ? 0
        : 138.5177312231 * log(percentKelvin - 10) - 305.0447927307));

    return Color.fromARGB(1, red.toInt(), green.toInt(), blue.toInt());
  }
}

double clamp(double value) {
  return value > 255 ? 255 : (value < 0 ? 0 : value);
}

List<Color>getThemedBackgroundFromTemperature(int temp) {
  if (temp > 40)
    return [Color(0xFFF0AC00), Color(0xFFC95C08)];
  else if (temp > 30 && temp <= 40)
    return [Color(0xFFECB425), Color(0xFFE68226),];
  else if (temp > 20 && temp <= 30)
    return [Color(0xFFFFCF56), Color(0xFFE68022),];
  else if (temp > 10 && temp <= 20)
    return [Color(0xFFB3C3D1), Color(0xFFB4A776),];
  else if (temp > 0 && temp <= 10)
    return [Color(0xFFB3C3D1), Color(0xFF515775),];
  else if (temp > -10 && temp <= 0)
    return [Color(0xFFB2CCE3), Color(0xFF5A649A),];
  else if (temp > -20 && temp <= 10)
    return [Color(0xFF84B1D8), Color(0xFF3C4782),];
  else
    return [Color(0xFF61A8E7), Color(0xFF24327E),];
}
