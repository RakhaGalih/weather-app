import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen(
      {super.key, this.locationWeather, this.todayLocationWeather});

  final locationWeather;
  final todayLocationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late String cityName, weatherMessage, weatherIcon;
  late int temprature, humidity, speed;
  late List weathers;
  late Color weatherAmbience;
  late bool isError;

  void getWeather(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        weatherIcon = 'error';
        weatherMessage = 'Unable to get weather data';
        cityName = 'City Not Found';
        weatherAmbience = weather.getWeatherAmbience(1000);
        isError = true;
        return;
      }
      int condition = weatherData['weather'][0]['id'];
      var temp = weatherData['main']['temp'];
      humidity = weatherData['main']['humidity'];
      double spdTemp = weatherData['wind']['speed'];
      speed = spdTemp.toInt();
      temprature = temp.toInt();
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(condition);
      weatherAmbience = weather.getWeatherAmbience(condition);
      isError = false;
      print(cityName);
      print(temprature);
    });
  }

  getTodayWeather(dynamic weatherData) {
    setState(() {
      weathers = weatherData['list'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather(widget.locationWeather);
    getTodayWeather(widget.todayLocationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            children: [
              ambience(weatherAmbience),
              Padding(
                padding: const EdgeInsets.only(top: 360),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      temprature.toString(),
                      style: kSemiBoldTextStyle.copyWith(fontSize: 128),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '°C',
                            style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child: GestureDetector(
                      onTap: () async {
                        var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CityScreen()));
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          var todayWeatherData =
                              await weather.getTodayCityWeather(typedName);
                          getWeather(weatherData);
                          getTodayWeather(todayWeatherData);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.place),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            cityName,
                            style: kSemiBoldTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/$weatherIcon.png',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(
                    height: (isError) ? 130 : 105,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      weatherMessage,
                      textAlign: TextAlign.center,
                      style: kMediumTextStyle.copyWith(
                          fontSize: (isError) ? 25 : 32, color: kLightGrey),
                    ),
                  ),
                  SizedBox(
                    height: (isError) ? 0 : 30,
                  ),
                  (isError)
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 224,
                          decoration: BoxDecoration(
                              color: const Color(0xFF212227),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/windspeed.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    Text(
                                      '$speed km/h',
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Wind',
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 12, color: kGrey),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: const Color(0xFF292A2F),
                                height: 50,
                                width: 3,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/humidity.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    Text(
                                      '$humidity%',
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Humidity',
                                      style: kMediumTextStyle.copyWith(
                                          fontSize: 12, color: kGrey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  (isError)
                      ? const Padding(
                          padding:
                              EdgeInsets.only(bottom: 80, left: 20, right: 20),
                          child: Text(
                            'please provide a valid city name',
                            textAlign: TextAlign.center,
                            style: kMediumTextStyle,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                'Today',
                                style: kMediumTextStyle,
                              ),
                            ),
                            SizedBox(
                              height: 170,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 15, 20, 0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: weathers.length,
                                  itemBuilder: (context, index) {
                                    String todayTemprature = weathers[index]
                                            ['main']['temp']
                                        .toInt()
                                        .toString();
                                    String todayIcon = weather.getWeatherIcon(
                                        weathers[index]['weather'][0]['id']);
                                    String dateString =
                                        weathers[index]['dt_txt'];
                                    DateFormat format =
                                        DateFormat("yyyy-MM-dd HH:mm:ss");
                                    DateTime dateTime =
                                        format.parse(dateString);
                                    String hour =
                                        changeTo00Format(dateTime.hour);
                                    String minute =
                                        changeTo00Format(dateTime.minute);
                                    DateTime dateTimeNow = DateTime.now();
                                    bool isCurrentWeather = dateTimeNow.hour >=
                                            dateTime.hour &&
                                        dateTimeNow.hour < dateTime.hour + 3;
                                    bool isCurrentDay =
                                        dateTimeNow.day == dateTime.day;
                                    return (isCurrentDay)
                                        ? Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 15),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                    color: kLightBlack,
                                                    gradient: (isCurrentWeather)
                                                        ? kButtonLinearGradient
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '$todayTemprature°',
                                                      style: kSemiBoldTextStyle
                                                          .copyWith(
                                                              fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Image.asset(
                                                      'images/$todayIcon.png',
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      '$hour.$minute',
                                                      style: kMediumTextStyle
                                                          .copyWith(
                                                              color:
                                                                  (isCurrentWeather)
                                                                      ? Colors
                                                                          .white
                                                                      : kGrey,
                                                              fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox();
                                  }),
                            )
                          ],
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// var typedName = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CityScreen()));
//                       if (typedName != null) {
//                         var weatherData =
//                             await weather.getCityWeather(typedName);
//                         updateUI(weatherData);
//                       }