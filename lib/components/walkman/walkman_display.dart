import 'package:flutter/material.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/song.dart';

class WalkmanDisplay extends StatelessWidget {

  final WalkmanState state;
  final Song currentSong;

  const WalkmanDisplay({required this.state, required this.currentSong, super.key});
  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.teal,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
          color: Colors.cyan,
        ),
        child: Column(
        children: [
            Text(style: TextStyle(color: Colors.black, fontSize: 10), !state.player.playing ? "Press play button to play..." : "Now playing:"),
            SizedBox(height: 20,),
            Text(style: TextStyle(color: Colors.black, fontSize: 9), currentSong.title.isEmpty ? "" : currentSong.title),
          ],
        ),
      ),
    );
  }
}