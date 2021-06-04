import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

Widget getImg(String ico, {double height = 50}) {
  if (ico.isNotEmpty) {
    String url = 'assets/images/$ico@2x.png';
    return Image.asset(
      url,
      height: height,
    );
  } else {
    return Image.network(
      'https://openweathermap.org/img/wn/10d@2x.png',
      height: height,
    );
  }
}

getTemp(tempF) {
  return tempF.toString() + ' º C';
}

getDate(timestamp, {format = 'kk:mm', offset}) {
  DateTime dt =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  if (offset != null) {
    double ofset = offset / 3600;
    dt = dateTimeToOffset(offset: ofset, datetime: dt);
  }
  return DateFormat(format).format(dt);
}
