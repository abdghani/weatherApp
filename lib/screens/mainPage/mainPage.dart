import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/data/api/weatherApi.dart';
import 'package:weather/widget/appLoader.dart';

import 'components/weatherCard.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String initialLoc = 'london';
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(initialLoc));
  }

  searchWeather() async {
    if (_controller.text.toString().isNotEmpty) {
      String loc = _controller.text.toString();
      final weatherBloc = BlocProvider.of<WeatherBloc>(context);
      weatherBloc.add(GetWeather(loc));
    }
  }

  Widget getHeader() {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            'New York',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              controller: _controller,
              onSubmitted: (_) {
                searchWeather();
                Navigator.of(context).pop();
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                filled: true,
                hintStyle: Theme.of(context).textTheme.subtitle1,
                hintText: "Enter a place",
                fillColor: Theme.of(context).backgroundColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchWeather();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget mainContent() {
    return Container(
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return AppLoader("Loading weather !!");
          } else if (state is WeatherLoaded) {
            return WeatherCard(state.weather);
            // return Text("loaded ${state.weather['dt']}");
          } else {
            return Text("No data found");
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget topSearch() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () {
                // showModalBottomSheet(
                //     shape: RoundedRectangleBorder(
                //         borderRadius:
                //             BorderRadius.vertical(top: Radius.circular(25.0))),
                //     // backgroundColor: Colors.black,
                //     context: context,
                //     isScrollControlled: true,
                // context: context,
                // isScrollControlled: true,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(30.0),
                //       topRight: Radius.circular(30.0)),
                // ),
                // builder: (ctx) {
                //   return searchBar();
                // });

                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    // backgroundColor: Colors.black,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => searchBar());
              },
              child: Icon(Icons.search))
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [topSearch(), mainContent()],
              )),
        ),
      ),
    );
  }
}
