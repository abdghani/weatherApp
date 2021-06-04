import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/screens/mainPage/mainPage.dart';
import 'package:weather/util/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // Using the WeatherBloc provider in parent widget
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ], child: MainPage()),
      theme: lighTheme,
    );
  }
}
