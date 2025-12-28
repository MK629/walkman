import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/components/walkman/shuffle_button.dart';
import 'package:walkman/components/walkman/walkman_buttons.dart';
import 'package:walkman/components/walkman/walkman_display.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/music_status.dart';
import 'package:walkman/types/song.dart';

class Walkman extends StatelessWidget {
  const Walkman({ super.key });

@override
  Widget build(BuildContext context){
    var walkmanState = context.watch<WalkmanState>();
    bool isPlayingMusic = walkmanState.isPlayingMusic;
    MusicStatus musicStatus = walkmanState.musicStatus;
    Song currentSong = walkmanState.currentSong;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("WALKMAN", style: TextStyle(fontSize: 30, color: Colors.cyanAccent),),
        WalkmanDisplay(isPlayingMusic: isPlayingMusic, musicStatus: musicStatus, currentSong: currentSong),
        WalkmanButtons(state: walkmanState),
        ShuffleButton(state: walkmanState)
      ],
    );
  }
}