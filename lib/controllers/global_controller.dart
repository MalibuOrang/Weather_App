import 'package:flutter_weather_app/api/fetch_weather.dart';
import 'package:flutter_weather_app/model/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //create variable app
  final RxBool _isLoading = true.obs;
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final weatherData = WeatherData().obs;
  WeatherData getData() {
    return weatherData.value;
  }

  //instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLat() => _lat;
  RxDouble getLong() => _long;
  RxInt getCurrentIndex() => _currentIndex;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnable;
    LocationPermission locationPermission;
    isServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnable) {
      return Future.error("Loacal service is not enabled");
    }
    // status of permission check
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // return permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location is denied by user");
      }
    }
    //getting the current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //get actual latitude and longitude
      _lat.value = value.latitude;
      _long.value = value.longitude;
      // calling weather API
      return FetchWeatherAPI()
          .getWeatherData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value!;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
