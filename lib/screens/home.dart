import 'package:flutter/material.dart';
import 'package:flutter_my_own_first_app/data/api_service.dart';
import 'package:flutter_my_own_first_app/models/weather_model.dart';
import 'package:flutter_my_own_first_app/screens/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter_my_own_first_app/widgets/autocomplete_basic.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  Weather weatherData = Weather(region: "");
  late FToast fToast;
  var isLoading = false;
  var isWeatherDataReady = false;
  @override
  void initState() {
    super.initState();
    // weatherData.region = "İstanbulx";
    // getWeatherData();
    // print(weatherData.region);
    fToast = FToast();
    fToast.init(context);
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("Server error"),
      ],
    ),
  );

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
                  : FitnessAppHomeScreen(
                      weatherData: weatherData,
                      changeisWeatherDataReady: changeisWeatherDataReady,
                    ))
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
    if (weatherFuture != null) {
      setState(() {
        weatherData = weatherFuture;
        // weatherData = weatherFuture ?? Weather(region: "istanbul");
        // print("from home.dart :${this.weatherData.nextDays?[0].day.toString()}");
      });
      isWeatherDataReady = true;
    } else {
      print("home getWeatherData else: ");
      isWeatherDataReady = false;
      _showToast();
    }
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

  void changeisWeatherDataReady(dynamic childvalue) {
    setState(() {
      isLoading = false;
      isWeatherDataReady = false;
      print("home changeisWeatherDataReady $isWeatherDataReady ");
      print("home changeisWeatherDataReady2 $isLoading ");
    });
  }

  _showToast() {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
