import 'package:flutter/material.dart';
import 'package:flutter_my_own_first_app/data/api_service.dart';
import 'package:flutter_my_own_first_app/models/weather_model.dart';
import 'package:flutter_my_own_first_app/screens/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter_my_own_first_app/widgets/autocomplete_basic.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  Weather weatherData = Weather(region: "");
  var isLoading = false;
  var isWeatherDataReady = false;
  @override
  void initState() {
    super.initState();
    // weatherData.region = "İstanbulx";
    // getWeatherData();
    // print(weatherData.region);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: false,
          child: isLoading
              ? (!isWeatherDataReady
                  ? const Center(
                      child: Text(
                        "Loading",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : FitnessAppHomeScreen(weatherData: weatherData))
              : Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset('assets/fitness_app/symbol.png',
                        width: 100, height: 100),
                    const SizedBox(height: 40),
                    AutoComplete(notifyParent: refresh),
                    // const SizedBox(height: 5),
                    const Text("Type and choose your location"),
                  ],
                )),
    );
  }

  void getWeatherData(city) async {
    var weatherFuture = (await ApiService().getWeather(city));
    setState(() {
      weatherData = weatherFuture ?? Weather(region: "istanbul");
      // print("from home.dart :${this.weatherData.nextDays?[0].day.toString()}");
    });
    isWeatherDataReady = true;
  }

  void refresh(dynamic childvalue) {
    setState(() {
      weatherData.region = childvalue;
      // print("from setstate : $childvalue");
      // print("from setstate2  : ${weatherData.region}");
      getWeatherData(childvalue);
      isLoading = true;
    });
  }
}
