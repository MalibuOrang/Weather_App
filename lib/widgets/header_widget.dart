import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  String city = "";
  @override
  void initState() {
    getAddress(
        globalController.getLat().value, globalController.getLong().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(lat, lon, localeIdentifier: "uk");
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('uk', null);
    String date = DateFormat("yMMMMd", 'uk').format(DateTime.now().toLocal());
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(fontSize: 35, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 124, 122, 122),
                height: 1.5),
          ),
        ),
      ],
    );
  }
}
