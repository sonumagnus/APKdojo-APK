import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

/// textTheme properties useCase :-
///
/// using labelMedium  to style app name in [ SingleGridApp ] and [SingleVerticalApp] and main APKdojo SVG Logo color
///
/// using titleLarge property for [AppType] widget's 'main-heading' and category name in category List
///
/// using titleMedium for ListTile widgets title in [SingleHorizontalApp] widget
///
/// using titleSmall for [AppType] widget's followupText and [SingleHorizontalApp] widget's subtitle, and [SlugDescription] widget's content
///
/// displayMedium property has been used in [shimmerColor] base-color and "All Reviews" button in user review's expansion pannel
///
/// displaySmall property has been used in [shimmerColor] highlightColor

abstract class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.grey.shade200, opacity: 0.8),
    shadowColor: Colors.black,
    buttonTheme: ButtonThemeData(buttonColor: Colors.grey.shade800),
    hintColor: Colors.white60,
    textTheme: TextTheme(
      labelMedium: const TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.grey.shade100),
      titleMedium: TextStyle(color: Colors.grey.shade200),
      titleSmall: TextStyle(color: Colors.grey.shade500),
      displayMedium: TextStyle(color: Colors.grey.shade800),
      displaySmall: TextStyle(color: Colors.grey.shade700),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.grey.shade700, opacity: 0.8),
    shadowColor: Colors.black12,
    hintColor: Colors.grey.shade700,
    textTheme: TextTheme(
      labelMedium: TextStyle(color: Colors.grey.shade700),
      titleLarge: TextStyle(color: Colors.grey.shade900),
      titleMedium: TextStyle(color: Colors.grey.shade800),
      titleSmall: TextStyle(color: Colors.grey.shade600),
      displayMedium: TextStyle(color: Colors.grey.shade100),
      displaySmall: TextStyle(color: Colors.grey.shade50),
    ),
  );
}
