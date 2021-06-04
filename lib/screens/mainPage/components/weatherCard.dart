import 'package:flutter/material.dart';
import 'package:weather/util/helpers.dart';
import 'package:weather/screens/mainPage/components/hourlyData.dart';

class WeatherCard extends StatelessWidget {
  final weatherData;
  const WeatherCard(this.weatherData);

  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;

    Widget weatherPlace() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              weatherData['loc_name'],
              style: textTheme.headline4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Image.asset(
                'assets/images/sunrise-512.png',
                height: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                  getDate(weatherData['current']['sunrise'],
                          offset: weatherData['timezone_offset'])
                      .toString(),
                  style: textTheme.headline6),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                'assets/images/Sunset-512.png',
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                  getDate(weatherData['current']['sunset'],
                          offset: weatherData['timezone_offset'])
                      .toString(),
                  style: textTheme.headline6)
            ],
          )
        ],
      );
    }

    Widget weatherMain() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getImg(weatherData['current']['weather'][0]['icon'], height: 100),
            Text(
              getTemp(weatherData['current']['temp']),
              style: textTheme.headline1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              weatherData['current']['weather'][0]['description'].toString(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Feels like ' + getTemp(weatherData['current']['feels_like']),
              style: textTheme.headline6,
            ),
          ],
        ),
      );
    }

    Widget weatherHourly() {
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
                          return HourlyData(weatherData['hourly'][index],
                              weatherData['timezone_offset']);
                        }),
                  )
                ],
              )),
        ),
      );
    }

    return Container(
      child: Column(
        children: [weatherPlace(), weatherMain(), weatherHourly()],
      ),
    );
  }
}
