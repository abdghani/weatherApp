import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyData extends StatelessWidget {
  final dynamic hourlyData;

  const HourlyData(this.hourlyData);

  getDate(timestamp, {format = 'kk:mm'}) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(dt);
  }

  getTemp(tempF) {
    return tempF.toString() + ' º C';
  }

  getimg(String ico) {
    if (ico.isNotEmpty) {
      return 'https://openweathermap.org/img/wn/$ico@2x.png';
    } else {
      return 'https://openweathermap.org/img/wn/10d@2x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            getDate(hourlyData['dt']),
            style: textTheme.headline5,
          ),
          SizedBox(
            width: 5,
          ),
          Image.network(
            getimg(hourlyData['weather'][0]['icon']),
            height: 50,
          ),
          // Text(getimg(hourlyData['weather'][0]['icon'])),
          SizedBox(
            width: 5,
          ),
          Text(
            getTemp(hourlyData['temp']),
            style: textTheme.subtitle1,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            hourlyData['weather'][0]['description'],
            style: textTheme.headline6,
          )
        ],
      ),
    );
  }
}
