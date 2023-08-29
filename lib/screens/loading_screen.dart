import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    await Geolocator.requestPermission();
    dynamic weatherData;
    dynamic todayWeatherData;
    try {
      weatherData = await Future.value(WeatherModel().getLocationWeather())
          .timeout(const Duration(seconds: 5));
      todayWeatherData =
          await Future.value(WeatherModel().getTodayLocationWeather())
              .timeout(const Duration(seconds: 5));
    } catch (e) {
      print('Failed to get data by $e');
    }
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  locationWeather: weatherData,
                  todayLocationWeather: todayWeatherData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Loading...',
                style: kMediumTextStyle.copyWith(color: kLightGrey),
              )
            ],
          ),
        ));
  }
}
