import 'package:flutter/material.dart';
import 'package:flutter_my_own_first_app/screens/home.dart';

import '../../models/weather_model.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fitness_app_theme.dart';
import 'models/tab_icon_data.dart';
import 'my_diary/my_diary_screen.dart';
import 'training/training_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  late Weather weatherData;
  final Function(dynamic selection) changeisWeatherDataReady;

  // Weather weatherData = Weather(region: "İstanbulx");
  FitnessAppHomeScreen(
      {required this.weatherData, required this.changeisWeatherDataReady});

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    final _weatherData = widget.weatherData;
    // print("fintnesapphomsecreen init ${_weatherData.region}");
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    for (final TabIconData tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;
    tabBody = MyDiaryScreen(
        animationController: animationController, weatherData: _weatherData);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("finessAppHomeScreen : ${widget.weatherData.region}");
    return Material(
      color: FitnessAppTheme.background,
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            // print("if worked");
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    final _weatherData = widget.weatherData;
    // print("bottom bar works ${_weatherData.region}");

    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = MyDiaryScreen(
                        animationController: animationController,
                        weatherData: _weatherData);
                  });
                }
                return;
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = TrainingScreen(
                        animationController: animationController);
                  });
                }
                return;
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = Home();
                  });
                }
                return;
              });
            }
          },
          changeisWeatherDataReady: widget.changeisWeatherDataReady,
        ),
      ],
    );
  }
}
