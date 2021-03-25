import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(primarySwatch: Colors.blue).copyWith(
      primaryColor: Color(0xFFFFD000),
      accentColor: Color(0xFFFFD000),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
        backgroundColor: Color(0xFFFFD000),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xFF333333),
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Color(0xFF333333),
        labelStyle: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 28.sp,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF333333),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) return Color(0xFFFFD000);
          return null;
        }),
      ),
    );
  }
}
