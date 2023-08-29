import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        body: SafeArea(
          child: Stack(
            children: [
              ambience(const Color(0xFF36EEFA).withOpacity(0.4)),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Search Location',
                          style: kSemiBoldTextStyle,
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'images/place.png',
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
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
                    child: TextField(
                      onChanged: (value) {
                        cityName = value;
                      },
                      style: kMediumTextStyle.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                          hintText: 'Enter City Name',
                          hintStyle: kMediumTextStyle.copyWith(
                              color: kLightGrey, fontSize: 16),
                          border: InputBorder.none,
                          focusColor: const Color(0xFF4BB2FE)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: kButtonLinearGradient,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Get Weather',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
