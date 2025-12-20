import 'package:flutter/material.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/song.dart';

class WalkmanDisplay extends StatelessWidget {

  final WalkmanState state;
  final Song currentSong;

  const WalkmanDisplay({required this.state, required this.currentSong, super.key});
  
  @override
  Widget build(BuildContext context) {

    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
          children: [
              Text(!state.player.playing ? "Press play button to play..." : "Now playing:"),
              Text(currentSong.title.isEmpty ? "" : currentSong.title)
            ],
          ),
        );
  }
}