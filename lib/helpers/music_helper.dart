import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MusicHelper {

  static Future<String> getHiveHome() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/hive";
  }

  static Future<String> getMusicHome() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/music";
  }

  static Future<void> importMusic(List<PlatformFile> selectedSongs)async{
    final musicHome = Directory(await getMusicHome());
    if (!await musicHome.exists()) {
      await musicHome.create(recursive: true);
    }

    Box<String> musicBox = await Hive.openBox("MusicBox");

    for (var file in selectedSongs) {
      //Convert XFile to dart.io.File because XFile eagerly caches unnecessarily
      File fileToCopy = File(file.path.toString());
      String newImportedSongPath = "${musicHome.path}/${file.name}";

      if(!musicBox.values.contains(newImportedSongPath)){
        //Copy file to app's music dir
        await fileToCopy.copy(newImportedSongPath);
        //Add path to Hive
        await musicBox.add(newImportedSongPath);
      }
    }
  }

  static Future<void> removeMusic(String importedSongPath) async {
    Box<String> musicBox = await Hive.openBox("MusicBox");

    if(musicBox.values.contains(importedSongPath)){
      //get key of importedSongPath in MusicBox
      final key = musicBox.keys.firstWhere((k) => musicBox.get(k) == importedSongPath, orElse: () => null);
      if(key != null){
        //remove the imported file
        File songFileToRemove = File(importedSongPath);
        if(await songFileToRemove.exists()){
          await songFileToRemove.delete();
        }
        //remove from hive
        await musicBox.delete(key);
      }
    }
  }

  static void debug() async {
    
  }
}