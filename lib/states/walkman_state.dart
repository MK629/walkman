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
        //Even though playMusic() calls player.stop() internally, this must be called outside seperately as playMusic is an async function that we can't await.
        //Or else, it will cause race conditions that can conflict with the native cleanup process. This fires stop() at an earlier stage, giving native processes time to breathe.
        player.stop();
        playNext();
      }
    });
  }

  void notify(){
    notifyListeners();
  }

  void playMusic(Song currentSong) async {
    await player.stop();
    await player.processingStateStream.firstWhere((s) => s == ProcessingState.idle);

    this.currentSong = currentSong;

    await player.setFilePath(currentSong.path);
    player.play();
    notifyListeners();
  }

  void playNext() async{
    if(currentSong.path.isNotEmpty && currentSong.title.isNotEmpty && loadedSongs.isNotEmpty){

      Song nextSong;

      if(currentSong.path == loadedSongs.last.path){
        nextSong = loadedSongs[0];
      }
      else{
        nextSong = loadedSongs[loadedSongs.indexWhere((s) => s.path == currentSong.path) + 1];
      }

      // ignore: await_only_futures
      playMusic(nextSong);
    }
  }

  void stopMusic() async {
    await player.stop();
    //Wait until the player is actually done cleaning up. Await on player.stop() will not actually wait for native cleanup to finish.
    //On player.stop(), dart sends a command and awaits a Future response. The response will return without the native cleanup actually being done. We must wait more.
    await player.processingStateStream.firstWhere((s) => s == ProcessingState.idle);
    notifyListeners();
  }

  void loadSongs(List<Song> loadedSongs) {
    this.loadedSongs = loadedSongs;
  }
}