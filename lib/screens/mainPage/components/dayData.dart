import 'package:flutter/material.dart';
import 'package:weather/util/helpers.dart';

class DayData extends StatelessWidget {
  final dynamic dayData;
  final int offset;
  const DayData(this.dayData, this.offset);

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;
    return Container(
      width: 10,
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    getDate(dayData['dt'], format: 'MMMMd', offset: offset),
                    style: textTheme.headline5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/sunrise-512.png',
                    height: 20,
                  ),
                  Text(getDate(dayData['sunrise'], offset: offset).toString(),
                      style: textTheme.headline6),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/Sunset-512.png',
                    height: 18,
                  ),
                  Text(getDate(dayData['sunset'], offset: offset).toString(),
                      style: textTheme.headline6),
                ],
              ),
              Divider(),
              Column(
                children: [
                  getImg(dayData['weather'][0]['icon'], height: 100),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    dayData['weather'][0]['description'].toString(),
                    style: textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      getTemp(dayData['temp']['day']),
                      style: textTheme.headline2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
