import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:walkman/types/song.dart';

class WalkmanState extends ChangeNotifier{

  AudioPlayer player = AudioPlayer();

  bool get isPlayingMusic => player.playing;

  Song currentSong = Song("", "");

  List<Song> loadedSongs = [];

  WalkmanState(){
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playMusic(loadedSongs[loadedSongs.indexOf(currentSong) + 1].path);
      }
    });
  }

  void setCurrentSong(Song currentSong){
    this.currentSong = currentSong;
    playMusic(currentSong.path);
    notifyListeners();
  }

  void playMusic(String songPath) async {
    if(player.playing){
      await player.stop();
    }
    await player.setFilePath(songPath);
    await player.play();
    notifyListeners();
  }

  void stopMusic() async {
    await player.stop();
    notifyListeners();
  }

  void loadSongs(List<Song> loadedSongs) {
    this.loadedSongs = loadedSongs;
  }
}