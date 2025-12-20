import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/components/walkman/walkman_buttons.dart';
import 'package:walkman/components/walkman/walkman_display.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/song.dart';

class Walkman extends StatelessWidget {
  const Walkman({ super.key });

@override
  Widget build(BuildContext context){
    var walkmanState = context.watch<WalkmanState>();
    Song currentSong = walkmanState.currentSong;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WalkmanDisplay(state: walkmanState, currentSong: currentSong),
        WalkmanButtons(state: walkmanState)
      ],
    );
  }
}