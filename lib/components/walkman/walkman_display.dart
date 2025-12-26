import 'package:flutter/material.dart';
import 'package:walkman/types/music_status.dart';
import 'package:walkman/types/song.dart';

class WalkmanDisplay extends StatelessWidget {

  final bool isPlayingMusic;
  final MusicStatus musicStatus;
  final Song currentSong;

  const WalkmanDisplay({required this.isPlayingMusic, required this.musicStatus, required this.currentSong, super.key});
  
  @override
  Widget build(BuildContext context) {

    Icon statusIcon;

    switch(musicStatus){
      case MusicStatus.playing:
        statusIcon = Icon(Icons.play_arrow, color: Colors.black);
      break;
      case MusicStatus.paused:
        statusIcon = Icon(Icons.pause, color: Colors.black);
      break;
      case MusicStatus.stopped:
        statusIcon = Icon(Icons.stop, color: Colors.black);
      break;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 170,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.tealAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
          color: Colors.cyan,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 11),
              children: [
                getHeadText(isPlayingMusic)
              ]
            )),
            SizedBox(height: 25,),
            // ignore: sized_box_for_whitespace
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 25,
              child: Text(style: TextStyle(color: Colors.black, fontSize: 9), currentSong.title.isEmpty ? "" : currentSong.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
            ),
            SizedBox(height: 25,),
            statusIcon
          ],
        ),
      ),
    );
  }
}

TextSpan getHeadText(bool isPlayingMusic){
  if(isPlayingMusic){
    return TextSpan(text: "Now playing:");
  }
  else{
    return TextSpan(
      children: [
        TextSpan(text: "Press "),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(Icons.play_arrow, color: Colors.black, size: 16)
        ),
        TextSpan(text: " to play or resume...")
      ]
    );
  }
}