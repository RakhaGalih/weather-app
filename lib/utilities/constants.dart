import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none),
);

const LinearGradient kButtonLinearGradient =
    LinearGradient(colors: [Color(0xFF4BB2FE), Color(0xFF3279ED)]);

Align ambience(weatherAmbience) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
        weatherAmbience,
        const Color(0xFF191A1E).withOpacity(0),
      ])),
    ),
  );
}

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kBlack = Color(0xFF191A1E);
const kLightBlack = Color(0xFF21252E);
const kLightGrey = Color(0xFF8D98A5);
const kGrey = Color(0xFF6B737D);
const kSemiBoldTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 25);
const kMediumTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
