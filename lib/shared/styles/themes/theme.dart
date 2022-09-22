import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.grey,
      elevation: 20,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: HexColor('333739'),
        elevation: 0,
        titleSpacing: 20,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        )),
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    fontFamily: 'jannah');
ThemeData lightTheme = ThemeData(
    fontFamily: 'jannah',
    textTheme: TextTheme(
        bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    )),
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      elevation: 20,
    ));
