import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/global_controller.dart';
import 'package:flutter_weather_app/utils/custom_colors.dart';
import 'package:flutter_weather_app/widgets/comfort_level.dart';
import 'package:flutter_weather_app/widgets/current_wether_widget.dart';
import 'package:flutter_weather_app/widgets/header_widget.dart';
import 'package:flutter_weather_app/widgets/hourly_data_widget.dart';
import 'package:get/get.dart';

import '../widgets/daily_data_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call provided function to update the widget
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/icons/logo.png',
            height: 100,
            width: 100,
          ),
        ]),
      ),
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/load-icon.png",
                          height: 100, width: 100),
                      const CircularProgressIndicator(),
                    ],
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const HeaderWidget(),
                      //for our current weather
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWether(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),
                      DailyDataForecast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWether()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
