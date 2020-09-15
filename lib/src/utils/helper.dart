import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTime({int dateTime, int offset, String dateFormat, bool inMilli = false }) {
  dateFormat = dateFormat != null ? dateFormat : "h:mm a";
  // Full date formats on
  // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  int timeToConvert;

  offset = offset ?? 0;
  if (dateTime != null) {
    if(inMilli) {
      timeToConvert = (dateTime + offset);
    } else {
      timeToConvert = (dateTime + offset) * 1000;
    }
    var myFormat = DateFormat(dateFormat);

    var newDateTime = DateTime.fromMillisecondsSinceEpoch(timeToConvert);
    String updatedDateTime = myFormat.format(newDateTime);
//    print(updatedDateTime);

    return updatedDateTime;
  }
  return null;
}
