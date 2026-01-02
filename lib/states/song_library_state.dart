import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:walkman/types/song.dart';

class SongLibraryState extends ChangeNotifier{
  List<Song> songList = [];

  SongLibraryState(List<String> importedSongs){
    for (String fullPath in importedSongs) {
      XFile importedSong = XFile(fullPath);

      Song newSong = Song(importedSong.name.split('.mp3').first, importedSong.path);
      
      songList.add(newSong);
    }

    songList.sort((a,b) => a.title.compareTo(b.title));
  }

  void addSongs(List<String> importedSongs) {
    for (String fullPath in importedSongs) {
      XFile importedSong = XFile(fullPath);

      Song newSong = Song(importedSong.name.split('.mp3').first, importedSong.path);

      if(!songList.contains(newSong)){
        songList.add(newSong);
      }
    }

    songList.sort((a,b) => a.title.compareTo(b.title));

    notifyListeners();
  }

  void removeSong(Song songToRemove){
    if(songList.contains(songToRemove)){
      songList.remove(songToRemove);
    }

    notifyListeners();
  }
}