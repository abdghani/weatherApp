import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/screens/mainPage/components/hourlyData.dart';

class WeatherCard extends StatelessWidget {
  final weatherData;
  const WeatherCard(this.weatherData);

  getDate(timestamp, {format = 'kk:mm'}) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(dt);
  }

  getTemp(tempF) {
    return tempF.toString() + ' º C';
  }

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;

    Widget weatherPlace() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherData['basic']['name'],
            style: textTheme.headline4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                weatherData['basic']['sys']['country'],
                style: textTheme.headline5,
              ),
              SizedBox(
                width: 5,
              ),
              FaIcon(
                FontAwesomeIcons.sun,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(getDate(weatherData['basic']['sys']['sunrise']).toString(),
                  style: textTheme.headline6),
              SizedBox(
                width: 5,
              ),
              FaIcon(
                FontAwesomeIcons.moon,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(getDate(weatherData['basic']['sys']['sunset']).toString(),
                  style: textTheme.headline6)
            ],
          )
        ],
      );
    }

    Widget weatherMain() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTemp(weatherData['basic']['main']['temp']),
              style: textTheme.headline1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              weatherData['basic']['weather'][0]['description'].toString(),
              style: textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Feels like ' + getTemp(weatherData['basic']['main']['temp']),
              style: textTheme.headline6,
            ),
          ],
        ),
      );
    }

    Widget hourly() {
      return Container(
        width: double.infinity,
        // color: Theme.of(context).accentColor,
        child: Card(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TODAY',
                    style: textTheme.headline5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                        itemCount: weatherData['hourly'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return HourlyData(weatherData['hourly'][index]);
                        }),
                  )
                ],
              )),
        ),
      );
    }

    return Container(
      child: Column(
        children: [weatherPlace(), weatherMain(), hourly()],
      ),
    );
  }
}
