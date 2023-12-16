import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather_data_current.dart';
import 'package:flutter_weather_app/utils/custom_colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ComfortLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortLevel({super.key, required this.weatherDataCurrent});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
        child: const Text(
          "Додаткова інформація",
          style: TextStyle(
            fontSize: 18,
            color: CustomColors.textColorBlack,
          ),
        ),
      ),
      SizedBox(
        height: 180,
        child: Column(
          children: [
            Center(
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(
                    handlerSize: 0,
                    trackWidth: 12,
                    progressBarWidth: 12,
                  ),
                  infoProperties: InfoProperties(
                      bottomLabelText: "Вологість",
                      bottomLabelStyle: const TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.5,
                      )),
                  animationEnabled: true,
                  size: 140,
                  customColors: CustomSliderColors(
                    trackColor: CustomColors.firstGradientColor.withAlpha(60),
                    hideShadow: true,
                    progressBarColors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Відчувається: ",
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "${weatherDataCurrent.current.feelsLike} °🌡️",
                      style: const TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25, left: 20),
                  height: 25,
                  width: 1,
                  color: CustomColors.dividerLine,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Індекс УВ: ",
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "${weatherDataCurrent.current.uvIndex} ☀️",
                      style: const TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: CustomColors.textColorBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
