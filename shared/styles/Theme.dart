import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled4/shared/styles/color.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch:defaultColor ,

  scaffoldBackgroundColor: HexColor("333739"),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,

    backgroundColor:  HexColor("333739"),
    systemOverlayStyle: SystemUiOverlayStyle(

      statusBarColor:  HexColor("333739"),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(

      color: Colors.white,
    ),

    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.white,
        fontFamily: "font"
    ),


  ),


  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 30.0,
    backgroundColor: HexColor("333739"),
    unselectedItemColor: Colors.grey,
  ),
 // fontFamily: "font",
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color:  Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color:  Colors.white,
      height: 1.3,
    ),
  ),
);
ThemeData lightTheme = ThemeData(
     primarySwatch:defaultColor ,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,


      systemOverlayStyle: SystemUiOverlayStyle(

        statusBarColor: Colors.cyan,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: Colors.cyan,
      ),
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.black,
          fontFamily: "font"
      ),


    ),


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 30.0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color:  Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color:  Colors.black,
        height: 1.3,
      ),
    ),
  // fontFamily: "font",
//
);