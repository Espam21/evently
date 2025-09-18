import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static ThemeData light=ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: Colors.black
      ),
      iconTheme: IconThemeData(
        color: Colors.black,

      ),
    ),
    primaryColor: AppColors.primaryLight,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.grey,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.grey,
          width: 2,
        ),
      ),
      prefixIconColor: AppColors.grey,
      suffixIconColor: AppColors.grey,
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      )
    ),
    iconButtonTheme: IconButtonThemeData(
      style:IconButton.styleFrom(
       backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryLight,
        shape: CircleBorder(),
          side: BorderSide(
              color: AppColors.primaryLight
          )
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryLight,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.lightBackground,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.lightBackground,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:AppColors.primaryLight,
      foregroundColor: AppColors.lightBackground,
        shape: CircleBorder(
          side: BorderSide(
            color: AppColors.lightBackground,
            width: 5,
          )
        ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.primaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightBodyText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium:TextStyle(
        color: AppColors.primaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryLight,
        decorationThickness: 3,
        decorationStyle: TextDecorationStyle.solid,
    ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(fontSize: 14,color: AppColors.lightBackground,fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontSize: 24,color: AppColors.lightBackground,fontWeight: FontWeight.w700),
      displaySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryLight),
      titleMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),
    )
  );
  static ThemeData dark=ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryLight,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryLight
          ),
          iconTheme: IconThemeData(color:AppColors.primaryLight)
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.transparent,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primaryLight,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primaryLight,
              width: 2,
            ),
          ),
          prefixIconColor: AppColors.darkBodyText,
          suffixIconColor: AppColors.darkBodyText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBodyText,
          )
      ),
      iconButtonTheme: IconButtonThemeData(
          style:IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primaryLight,
            shape: CircleBorder(),
            side: BorderSide(
              color: AppColors.primaryLight
            )
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.lightBackground,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.lightBackground,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:AppColors.darkBackground,
        foregroundColor: AppColors.lightBackground,
        shape: CircleBorder(
            side: BorderSide(
              color: AppColors.lightBackground,
              width: 5,
            )
        ),
      ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.primaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkBodyText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        color: AppColors.primaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryLight,
        decorationThickness: 2,
        decorationStyle: TextDecorationStyle.solid,
      ),
      displayMedium: TextStyle(
        color: AppColors.darkBodyText,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(fontSize: 14,color: AppColors.lightBackground,fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontSize: 24,color: AppColors.lightBackground,fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
      titleMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
    )
  );
}