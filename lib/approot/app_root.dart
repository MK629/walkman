import 'package:flutter/material.dart';
import 'package:walkman/components/home/home.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
