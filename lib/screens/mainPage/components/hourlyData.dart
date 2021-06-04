import 'package:flutter/material.dart';
import 'package:weather/util/helpers.dart';

class HourlyData extends StatelessWidget {
  final dynamic hourlyData;
  final int offset;

  const HourlyData(this.hourlyData, this.offset);

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            getDate(hourlyData['dt'], offset: offset),
            style: textTheme.headline5,
          ),
          SizedBox(
            width: 5,
          ),
          getImg(hourlyData['weather'][0]['icon']),
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
