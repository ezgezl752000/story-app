import 'dart:io';

import 'package:flutter/material.dart';

const dataNull = '';

const int maxFailedLoadAttempts = 60;

const imageQuality = 50;

const borderTextFieldColor = Color(0xffC9CFD3);

const searchBarBackgroundColor = Colors.white;

const borderDefaultColor = Color(0xffF0F1F2);

const blueColor = Color(0xff2880FE);

const orangeColor = Color(0xFFFFB541);

const yellowColor = Color(0xFFFFE205);

const blueTransparentColor = Color(0xffEAF5FF);

const colorBg = Colors.white;

const colorWhite = Colors.white;

const colorBlack = Colors.black;

const colorGrey = Color(0xeededede);

const colorRed = Color(0xffef0909);

const borderGray = Color(0xFF000000);

const Color textGray = Color(0xFF969696);

const blueDarkColor = Color(0xff0B2C57);

const blueLightColor = Color(0xff6F86AF);

const colorWhiteOpacity = Color(0x00ffffff);
const colorWhiteOpacity2 = Color(0xffffffff);
const colorWhiteOpacity3 = Color(0x99ffffff);

const double fontSize13 = 13;

const double fontSize12 = 12;
const double fontSize14 = 14;

const double fontSize15 = 15;

const double fontSize16 = 16;

const double fontSize18 = 18;

const double fontSize20 = 20;

const double fontSize22 = 22;

const double marginHorizontal = 15;

const double heightItemHeader = 91;

const double heightTextField = 50;

const double diaLogRadius = 10;

final borderOutLineTextFormField = OutlineInputBorder(
    borderSide: const BorderSide(color: borderTextFieldColor, width: 1),
    borderRadius: BorderRadius.circular(7));

const TextStyle textNormal = TextStyle(
  fontSize: fontSize13,
  color: Colors.black,
);

const TextStyle textStyleFullName = TextStyle(
    color: colorBlack,
    fontWeight: FontWeight.w500,
    fontSize: fontSize16
);

const TextStyle textStyleTagName = TextStyle(
    color: colorBlack,
    fontWeight: FontWeight.w400,
    fontSize: fontSize13
);

const TextStyle textNormalGray = TextStyle(
  fontSize: fontSize13,
  color: textGray,
);

const TextStyle textBlackThinTitle = TextStyle(
  fontSize: fontSize15,
  color: Colors.black,
);

const TextStyle textBoldBlack = TextStyle(
    fontSize: fontSize15, color: Colors.black, fontWeight: FontWeight.bold);

const TextStyle textHint = TextStyle(
  fontSize: fontSize13,
  color: Colors.grey,
);

const TextStyle textGreyItalic = TextStyle(
  fontSize: fontSize15,
  fontStyle: FontStyle.italic,
  color: Colors.black,
);

const TextStyle textNormalWhite = TextStyle(
  fontSize: fontSize13,
  color: Colors.white,
);

const TextStyle textHeaderWhite = TextStyle(
  fontSize: fontSize15,
  color: Colors.white,
);

const TextStyle textSmallWhite = TextStyle(
  fontSize: fontSize12,
  color: Colors.white,
);

const TextStyle textBoldBlue = TextStyle(
    fontSize: fontSize15, color: blueColor, fontWeight: FontWeight.bold);

const TextStyle textTitleBlack = TextStyle(
    fontSize: fontSize15, color: colorBlack, fontWeight: FontWeight.w600);

const TextStyle textBoldTitleBlack = TextStyle(
    fontSize: fontSize18, color: colorBlack, fontWeight: FontWeight.w500);

const TextStyle textSmallBlueLight = TextStyle(
  fontSize: fontSize13,
  color: blueLightColor,
);

const TextStyle textBoldNormalBlue = TextStyle(
    fontSize: fontSize14, color: blueColor, fontWeight: FontWeight.w400);

const TextStyle textBoldNormalBlueDark = TextStyle(
    fontSize: fontSize14, color: blueDarkColor, fontWeight: FontWeight.bold);

const TextStyle textBoldBlueTitle = TextStyle(
    fontSize: fontSize22, color: blueColor, fontWeight: FontWeight.bold);

const TextStyle textNormalBlueBig = TextStyle(
  fontSize: fontSize16,
  color: blueColor,
  // fontWeight: FontWeight.bold
);

final BoxDecoration textFieldDecoration = BoxDecoration(
  border: Border.all(color: borderTextFieldColor),
  borderRadius: BorderRadius.circular(10),
);

 final boxShadowRadious = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [BoxShadow(blurRadius: 5, offset: Offset(0, 1), color: Color.fromRGBO(0, 0, 0, .10))]);

const sizeBox20 = SizedBox(
  height: 20,
  width: 20,
);

const sizeBox10 = SizedBox(
  height: 10,
  width: 10,
);

const sizeBox15 = SizedBox(
  height: 15,
  width: 15,
);

const sizeBox5 = SizedBox(
  height: 5,
  width: 5,
);


final String interstitialAdUnitId = Platform.isIOS
    ? 'ca-app-pub-3320796159824143/5398770914'
    : 'ca-app-pub-3320796159824143/3538894334';
final String rewardedAdUnitId = Platform.isIOS
    ? 'ca-app-pub-3320796159824143/4085689248'
    : 'ca-app-pub-3320796159824143/7286567652';
final String bannerAdUnitId = Platform.isIOS
    ? 'ca-app-pub-3320796159824143/4519969362'
    : 'ca-app-pub-3320796159824143/5043547692';