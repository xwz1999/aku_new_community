import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(primarySwatch: Colors.blue).copyWith(
      primaryColor: Color(0xFFFFD000),
      accentColor: Color(0xFFFFD000),
      textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: TextStyle(
              fontSize: 28.sp,
              color: Color(0xFF333333),
            ),
          ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled))
              return Color(0xFFFFF4D7);
            return Color(0xFFFFD000);
          }),
          elevation: MaterialStateProperty.all(0),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled))
              return Color(0xFF666666);
            return Color(0xFF333333);
          }),
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          )),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 76.w, vertical: 22.w),
          ),
          enableFeedback: true,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      dividerColor: Color(0xFFE8E8E8),
    );
  }
}
