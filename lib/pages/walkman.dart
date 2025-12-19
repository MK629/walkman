import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/song.dart';

class Walkman extends StatelessWidget {
  const Walkman({ super.key });

@override
  Widget build(BuildContext context){
    var walkmanState = context.watch<WalkmanState>();
    Song currentSong = walkmanState.currentSong;

    return Text(walkmanState.player.playing ? "There's music in the air! ${currentSong.title}." : "Nothing's playing shit.");
  }
}