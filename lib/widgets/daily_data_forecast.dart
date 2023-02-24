import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather_data_daily.dart';
import 'package:flutter_weather_app/utils/custom_colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({super.key, required this.weatherDataDaily});
  String getDayofWeek(final dayOfWeek) {
    DateTime timeF = DateTime.fromMillisecondsSinceEpoch(dayOfWeek * 1000);
    final r =
        DateFormat("EEE", "uk").format(timeF).substring(0, 1).toUpperCase() +
            DateFormat("EEE", "uk").format(timeF).substring(1);
    return r;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("uk", null);
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Прогноз на 7 днів 🗓",
              style:
                  TextStyle(color: CustomColors.textColorBlack, fontSize: 15),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          getDayofWeek(weatherDataDaily.daily[index].dt),
                          style: const TextStyle(
                              color: CustomColors.textColorBlack, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                      ),
                      Text(
                        "${weatherDataDaily.daily[index].temp?.day}° / ${weatherDataDaily.daily[index].temp?.night}° 🌡️",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.dividerLine,
                )
              ],
            );
          },
        ));
  }
}
