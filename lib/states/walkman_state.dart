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
        /**
         * NOTE TO FUTURE-SELF:
         * 
          * ProcessingState.completed does NOT mean native cleanup is finished.
          * Dart may transition to `idle` while the native audio engine is still
          * tearing down the previous source.
          *
          * Even though `player.stop()` is called inside `playMusic()`, calling it
          * again here ensures the native cleanup begins immediately at `completed`,
          * instead of racing with `setFilePath()`.
          *
          * Without this, `setFilePath()` may execute while native teardown is still
          * in progress, causing the player to reuse the previous audio buffer and
          * play the wrong track deterministically.
          *
          * Calling `stop()` here serializes the lifecycle:
          * completed → stop → native cleanup → idle → load next source
          *
          * This avoids async conflicts between Dart and the native player.
         *
         * IDK, just_audio is a bit wierd. Might think of trying other options in the future. This works for now.
         */
        player.stop();
        playNext();
      }
    });
  }

  void playMusic(Song currentSong) async {
    await player.stop();
    await player.processingStateStream.firstWhere((s) => s == ProcessingState.idle);

    this.currentSong = currentSong;

    await player.setFilePath(currentSong.path);
    player.play();
    notifyListeners();
  }

  void playNext(){
    if(currentSong.path.isNotEmpty && currentSong.title.isNotEmpty && loadedSongs.isNotEmpty){

      Song nextSong;

      if(currentSong == loadedSongs.last){
        nextSong = loadedSongs[0];
      }
      else{
        nextSong = loadedSongs[loadedSongs.indexOf(currentSong) + 1];
      }

      playMusic(nextSong);
    }
  }

  void playPrev(){
    if(currentSong.path.isNotEmpty && currentSong.title.isNotEmpty && loadedSongs.isNotEmpty){

      Song prevSong;

      if(currentSong == loadedSongs.first){
        prevSong = loadedSongs[loadedSongs.length - 1];
      }
      else{
        prevSong = loadedSongs[loadedSongs.indexOf(currentSong) - 1];
      }

      playMusic(prevSong);
    }
  }

  void pauseMusic() async {
    if(currentSong.title.isNotEmpty && currentSong.path.isNotEmpty && player.playing){
      await player.pause();
    }
  }

  void resumeMusic() async {
    if(currentSong.title.isEmpty && currentSong.path.isEmpty && loadedSongs.isNotEmpty){
      playMusic(loadedSongs.first);
    }
    else if(currentSong.title.isNotEmpty && currentSong.path.isNotEmpty && !player.playing){
      await player.play();
    }
  }

  void stopMusic() async {
    await player.stop();
    //Wait until the player is actually done cleaning up. Await on player.stop() will not actually wait for native cleanup to finish.
    //On player.stop(), dart sends a command and awaits a Future response. The response will return without the native cleanup actually being done. We must wait more.
    await player.processingStateStream.firstWhere((s) => s == ProcessingState.idle);
    currentSong = Song("", "");
    notifyListeners();
  }

  void loadSongs(List<Song> loadedSongs) {
    this.loadedSongs = loadedSongs;
  }
}