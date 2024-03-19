import 'package:flutter/material.dart';
import 'package:instagram/utils/app_color.dart';

class AppStyle {
  // **********************  APP NAME TEXT STYLE **************************
  static const TextStyle appNameStyle = TextStyle(
      fontSize: 28,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'cursive');

  // **********************  BUTTON TEXT STYLE **************************
  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: 17,
      color: AppColor.mobileBackgroundColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'serif');

  // **********************  HEADER TEXT STYLE **************************
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 22,
    color: AppColor.mobileBackgroundColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.2,
  );

  // **********************  REGULAR TEXT STYLE **************************
  static const TextStyle regularTextStyle = TextStyle(
    fontSize: 16,
    color: AppColor.primaryBlackColor,
    fontWeight: FontWeight.w400,
  );

  // **********************  REGULAR TEXT STYLES **************************
  static const TextStyle regularTextStyles = TextStyle(
    fontSize: 16,
    color: AppColor.mobileBackgroundColor,
    fontWeight: FontWeight.w400,
  );

  // ********************** TEXT BUTTON STYLE **************************
  static const TextStyle textButtonStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  // ********************** TUT TEXT STYLE **************************
  static const TextStyle tutTextStyle = TextStyle(
    fontSize: 16,
    color: AppColor.primaryBlackColor,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  // ********************** SMALL TEXT STYLE **************************
  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    color: AppColor.primaryColor,
    fontWeight: FontWeight.w300,
  );

  // ********************** SMALL RED TEXT STYLE **************************
  static const TextStyle smallRedTextStyle = TextStyle(
    fontSize: 16,
    color: AppColor.red,
    fontWeight: FontWeight.w300,
  );

  // ********************** USER NAME STYLE **************************
  static const TextStyle userNameStyle = TextStyle(
      fontSize: 22,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'serif');
}
