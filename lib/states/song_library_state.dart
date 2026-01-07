import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:walkman/types/song.dart';

class SongLibraryState extends ChangeNotifier{
  List<Song> songList = [];

  SongLibraryState(List<String> importedSongs){
    for (String fullPath in importedSongs) {
      Song newSong = Song(basenameWithoutExtension(fullPath), fullPath);
      songList.add(newSong);
    }

    songList.sort((a,b) => a.title.compareTo(b.title));
  }

  void addSongs(List<String> importedSongs) {
    for (String fullPath in importedSongs) {

      Song newSong = Song(basenameWithoutExtension(fullPath), fullPath);

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