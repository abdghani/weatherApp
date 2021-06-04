import 'package:flutter/material.dart';
import 'package:weather/util/helpers.dart';

class HourlyData extends StatelessWidget {
  final dynamic hourlyData;
  final int offset;

  const HourlyData(this.hourlyData, this.offset);

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  getDate(hourlyData['dt'], offset: offset),
                  style: textTheme.headline5,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  getTemp(hourlyData['temp']),
                  style: textTheme.subtitle1,
                ),
                getImg(hourlyData['weather'][0]['icon']),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Container(
              child: Text(
                hourlyData['weather'][0]['description'],
                style: textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
