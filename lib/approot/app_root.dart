import 'package:flutter/material.dart';
import 'package:walkman/approot/root_widget.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppRootWidget()
    );
  }
}
