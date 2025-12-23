
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:walkman/types/song.dart';

class SongLibraryState extends ChangeNotifier{
  List<Song> songList = [];

  void addSongs(List<XFile> selectedSongs){
    for (var file in selectedSongs) {
      Song newSong = Song(file.name.split('.mp3').first, file.path);

      if(!songList.contains(newSong)){
        songList.add(newSong);
      }
    }

    notifyListeners();
  }
}