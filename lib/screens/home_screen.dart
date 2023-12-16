import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/global_controller.dart';
import 'package:flutter_weather_app/widgets/comfort_level.dart';
import 'package:flutter_weather_app/widgets/current_wether_widget.dart';
import 'package:flutter_weather_app/widgets/header_widget.dart';
import 'package:flutter_weather_app/widgets/hourly_data_widget.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:get/get.dart';

import '../utils/custom_colors.dart';
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
      body: Stack(
        children: [
          Obx(() => globalController.checkLoading().isFalse
              ? WeatherBg(
                  weatherType: globalController.getAnimation(),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height)
              : Container(
                  color: Colors.white,
                )),
          Obx(
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
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: CustomColors.dividerLine.withAlpha(15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const HeaderWidget(),
                              //for our current weather
                              CurrentWeatherWidget(
                                weatherDataCurrent: globalController
                                    .getData()
                                    .getCurrentWether(),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: CustomColors.dividerLine.withAlpha(100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Прогноз на 24 год 🕐",
                                style: TextStyle(
                                  color: CustomColors.textColorBlack,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              HourlyDataWidget(
                                weatherDataHourly: globalController
                                    .getData()
                                    .getHourlyWeather(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        DailyDataForecast(
                          weatherDataDaily:
                              globalController.getData().getDailyWeather(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: CustomColors.dividerLine.withAlpha(100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ComfortLevel(
                              weatherDataCurrent: globalController
                                  .getData()
                                  .getCurrentWether()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
