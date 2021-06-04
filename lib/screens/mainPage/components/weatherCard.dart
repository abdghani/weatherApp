import 'package:flutter/material.dart';
import 'package:weather/screens/mainPage/components/dayData.dart';
import 'package:weather/util/helpers.dart';
import 'package:weather/screens/mainPage/components/hourlyData.dart';

class WeatherCard extends StatefulWidget {
  final weatherData;
  const WeatherCard(this.weatherData);

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    dynamic textTheme = Theme.of(context).textTheme;

    Widget weatherPlace() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              widget.weatherData['loc_name'],
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
                  getDate(widget.weatherData['current']['sunrise'],
                          offset: widget.weatherData['timezone_offset'])
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
                  getDate(widget.weatherData['current']['sunset'],
                          offset: widget.weatherData['timezone_offset'])
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
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getImg(widget.weatherData['current']['weather'][0]['icon'],
                height: 100),
            FittedBox(
              child: Text(
                getTemp(widget.weatherData['current']['temp']),
                style: textTheme.headline1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.weatherData['current']['weather'][0]['description']
                  .toString(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Feels like ' +
                  getTemp(widget.weatherData['current']['feels_like']),
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
                        itemCount: widget.weatherData['hourly'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return HourlyData(widget.weatherData['hourly'][index],
                              widget.weatherData['timezone_offset']);
                        }),
                  )
                ],
              )),
        ),
      );
    }

    Widget weatherWeek() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "WEEK",
              style: textTheme.headline5,
            ),
            Container(
              height: 320,
              // width: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.75),
                itemCount: widget.weatherData['daily'].length,
                onPageChanged: (int index) {
                  setState(() {
                    _index = index;
                    // _value = index.toDouble();
                  });
                },
                itemBuilder: (_, i) {
                  return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: DayData(widget.weatherData['daily'][i],
                          widget.weatherData['timezone_offset']));
                },
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        children: [
          weatherPlace(),
          weatherMain(),
          weatherHourly(),
          weatherWeek()
        ],
      ),
    );
  }
}
