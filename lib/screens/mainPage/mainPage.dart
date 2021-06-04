import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/widget/appLoader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'components/weatherCard.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // initial location if error fetching latitude
  // of current location
  String tempInitialLoc = 'london';

  var _controller = TextEditingController();

  // gets the current location using Geolocator api
  getLocationCurrent() async {
    late LocationPermission permission;
    bool serviceEnabled = true;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  getInitWeatherBloc() async {
    // adding to weatherbloc sink
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    try {
      Position _locationData = await getLocationCurrent();
      weatherBloc.add(
          GetWeatherLatLong(_locationData.latitude, _locationData.longitude));
    } catch (err) {
      weatherBloc.add(GetWeather(tempInitialLoc));
    }
  }

  @override
  void initState() {
    super.initState();
    getInitWeatherBloc();
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
          } else if (state is WeatherError) {
            return Text(
              state.message.toString(),
              style: Theme.of(context).textTheme.headline6,
            );
          } else {
            return AppLoader("Loading weather !!");
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
            onTap: () => getInitWeatherBloc(),
            child: FaIcon(
              FontAwesomeIcons.compass,
              size: 20,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => searchBar());
            },
            child: FaIcon(
              FontAwesomeIcons.searchLocation,
              size: 20,
            ),
          )
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
