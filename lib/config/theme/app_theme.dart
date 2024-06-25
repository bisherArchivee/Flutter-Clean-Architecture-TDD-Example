import 'package:education_app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // static final ThemeData lightTheme = ThemeData(
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   useMaterial3: true,
  //   fontFamily: AppFonts.POPPINS,
  //   brightness: Brightness.light,
  //   appBarTheme: const AppBarTheme(color: Colors.transparent),
  //   colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.primaryColour),
  // );
  //
  // static final ThemeData darkTheme = lightTheme.copyWith(
  //   brightness: Brightness.dark,
  //   appBarTheme: const AppBarTheme(color: Colors.black),
  //   colorScheme: ColorScheme.fromSwatch(accentColor: Colors.teal),
  //   // Customize other theme properties for dark mode
  // );
  /*Light Theme------------------------------------------------*/
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    ///TextTheme Shared For All App
    textTheme: const TextTheme().copyWith(
      bodyLarge: const TextStyle(
        color: Colors.black, // Set your desired text color here
      ),
      bodyMedium: const TextStyle(
        color: Colors.black, // Set your desired text color here
      ),
      bodySmall: const TextStyle(
        color: Colors.black, // Set your desired text color here
        // fontSize: 24,
        // fontWeight: FontWeight.bold,
      ),
      // Add more text styles as needed...
    ),
    primaryColor: AppColors.lightPrimaryColor,
    colorScheme: ThemeData.light().colorScheme.copyWith(
      background: AppColors.lightCardColor,
      // You can set other color scheme properties as needed.
    ),
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    cardColor: AppColors.lightCardColor,

    ///ElevatedButtonTheme Shared For All App
    elevatedButtonTheme: _elevatedButtonTheme(
      backgroundColorThemeColor: AppColors.lightButtonColor,
      foregroundColorThemeColor: AppColors.lightButtonColor,
    ),

    ///OutlinedButtonThemeData Shared For All App
    outlinedButtonTheme: _outlinedButtonThemeData(
      backgroundColorThemeColor: AppColors.lightButtonColor,
      borderColorThemeColor: AppColors.lightButtonColor,
    ),

    ///CardTheme Shared For All App
    cardTheme: _cardTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightCardColor,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    ///DialogTheme Shared For All App
    dialogTheme: const DialogTheme(
      elevation: 0,
      backgroundColor: AppColors.lightCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),

    ///BottomSheetThemeData Shared For All App
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: AppColors.lightCardColor,
      backgroundColor: AppColors.lightCardColor,
      elevation: 4,
      modalElevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),

    ///PopupMenuThemeData Shared For All App
    popupMenuTheme: const PopupMenuThemeData(
      elevation: 0,
      color: AppColors.lightCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      textStyle: TextStyle(
          //color: AppColors.greenColour, // Set your desired text color here
          ),
    ),

    ///InputDecorationTheme Shared For All App
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black.withOpacity(0.03),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.lightToggleableActiveColor,
        ),
      ),
    ),
    dividerColor: AppColors.lightDividerColor,

    ///SnackBarThemeData Shared For All App
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  /*Dark Theme------------------------------------------------*/
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    ///TextTheme Shared For All App
    textTheme: const TextTheme().copyWith(
      bodyLarge: const TextStyle(
        color: Colors.white, // Set your desired text color here
      ),
      bodyMedium: const TextStyle(
        color: Colors.white, // Set your desired text color here
      ),
      bodySmall: const TextStyle(
        color: Colors.white, // Set your desired text color here
        // fontSize: 24,
        // fontWeight: FontWeight.bold,
      ),
      // Add more text styles as needed...
    ),
    // textTheme: const TextTheme().apply(
    //     fontFamily: AppFonts.POPPINS,
    //     decorationColor: AppColors.darkPrimaryColor),

    primaryColor: AppColors.darkPrimaryColor,

    ///background Shared For All App
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          background: AppColors.darkCardColor,
          // You can set other color scheme properties as needed.
        ),

    ///ScaffoldBackgroundColor Shared For All App
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,

    ///CardColor Shared For All App
    cardColor: AppColors.darkCardColor,

    ///ElevatedButtonTheme Shared For All App
    elevatedButtonTheme: _elevatedButtonTheme(
      backgroundColorThemeColor: AppColors.darkButtonColor,
      foregroundColorThemeColor: AppColors.darkButtonColor,
    ),

    ///OutlinedButtonThemeData Shared For All App
    outlinedButtonTheme: _outlinedButtonThemeData(
      backgroundColorThemeColor: AppColors.darkButtonColor,
      borderColorThemeColor: AppColors.darkButtonColor,
    ),

    ///CardTheme Shared For All App
    cardTheme: _cardTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkCardColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    ///DialogTheme Shared For All App
    dialogTheme: const DialogTheme(
      elevation: 0,
      backgroundColor: AppColors.darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),

    ///BottomSheetThemeData Shared For All App
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: AppColors.darkCardColor,
      backgroundColor: Colors.white,
      elevation: 4,
      modalElevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),

    ///PopupMenuThemeData Shared For All App
    popupMenuTheme: const PopupMenuThemeData(
      elevation: 0,
      color: AppColors.darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      textStyle: TextStyle(
          //color: AppColors.greenColour,
          // Set your desired text color here
          ),
    ),

    ///InputDecorationTheme Shared For All App
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkCardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.darkToggleableActiveColor,
        ),
      ),
    ),
    dividerColor: AppColors.darkDividerColor,
    ///SnackBarThemeData Shared For All App
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),

  );

  /*Other Themes------------------------------------------------*/
  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color backgroundColorThemeColor,
    required Color foregroundColorThemeColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(16),
        backgroundColor: backgroundColorThemeColor,
        foregroundColor: foregroundColorThemeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonThemeData({
    required Color backgroundColorThemeColor,
    required Color borderColorThemeColor,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(16),
        backgroundColor: backgroundColorThemeColor,
        side: BorderSide(
          color: borderColorThemeColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: borderColorThemeColor,
          ),
        ),
      ),
    );
  }

  static CardTheme _cardTheme() {
    return const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  static Color getThemePrimaryColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? AppColors.lightPrimaryColor
        : AppColors.darkPrimaryColor;
  }
}
