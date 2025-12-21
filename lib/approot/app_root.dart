import 'package:flutter/material.dart';
import 'package:walkman/approot/root_widget.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Walkman",
      theme: getGlobalThemeData(),
      home: AppRootWidget()
    );
  }
}

ThemeData getGlobalThemeData(){
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Pixel",
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 8),
      bodyMedium: TextStyle(fontSize: 9),
      bodyLarge: TextStyle(fontSize: 10),
      displayLarge: TextStyle(fontSize: 8),
      displayMedium: TextStyle(fontSize: 7),
      displaySmall: TextStyle(fontSize: 6),
      labelLarge: TextStyle(fontSize: 8),
      labelMedium: TextStyle(fontSize: 7),
      labelSmall: TextStyle(fontSize: 6),
      titleLarge: TextStyle(fontSize: 8),
      titleMedium: TextStyle(fontSize: 7),
      titleSmall: TextStyle(fontSize: 6),
      headlineLarge: TextStyle(fontSize: 8),
      headlineMedium: TextStyle(fontSize: 7),
      headlineSmall: TextStyle(fontSize: 6)
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.cyan,
      onPrimary: Colors.black,
      secondary: Colors.cyan,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.black, // light grey plastic
      onSurface: Colors.teal,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((buttonState){
          if (buttonState.contains(WidgetState.pressed)){
            return 1;
          }
          else{
            return 4;
          }
        }),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          )
        ),
        padding: WidgetStateProperty.all(EdgeInsets.only(right: 6)),
        foregroundColor: WidgetStateProperty.all(Colors.teal),
        backgroundColor: WidgetStateProperty.all(Colors.black),
        side: WidgetStateProperty.all(BorderSide(color: Colors.teal)),
      )
    ),
  );
}
