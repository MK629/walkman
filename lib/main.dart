import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:walkman/approot/app_root.dart';
import 'package:walkman/helpers/music_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  
  String hiveHome = await MusicHelper.getHiveHome();
  Hive.init(hiveHome);

  Box<String> musicBox = await Hive.openBox("MusicBox");
  List<String> importedSongs = musicBox.values.toList();

  runApp(AppRoot(importedSongs: importedSongs,));
}