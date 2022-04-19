import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_my_own_first_app/data/api_service.dart';
import 'package:flutter_my_own_first_app/models/weather_model.dart';
import 'package:flutter_my_own_first_app/screens/fitness_app/fitness_app_home_screen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State {
  // late Weather weatherData;
  Weather weatherData = Weather(region: "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // weatherData.region = "İstanbulx";
    getWeatherData();
    // print(weatherData.region);
  }

  @override
  Widget build(BuildContext context) {
    // print("first weather : $weatherData");

    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      top: false,
      bottom: false,
      child: weatherData.region == ""
          ? Center(
              child: Text("Loading"),
            )
          : FitnessAppHomeScreen(weatherData: weatherData),
    ));
  }

  void getWeatherData() async {
    var weatherFuture = (await ApiService().getWeather());
    setState(() {
      weatherData = weatherFuture!;
      // print("from home.dart :${this.weatherData.region.toString()}");
    });
    // print(weatherData);
    // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
}
