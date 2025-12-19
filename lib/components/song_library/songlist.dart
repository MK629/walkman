import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/states/song_library_state.dart';
import 'package:walkman/states/walkman_state.dart';
import 'package:walkman/types/song.dart';

class SongList extends StatelessWidget {
  const SongList({super.key});
  
  @override
  Widget build(BuildContext context) {
    var walkmanState = context.read<WalkmanState>();
    var songLibraryState = context.watch<SongLibraryState>();

    List<Song> selectedSongList = songLibraryState.songList;
    walkmanState.loadSongs(selectedSongList);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Songs:"),
        ),

        for(Song song in selectedSongList)
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text(song.title),
            onTap: () {
              walkmanState.playMusic(song);
            },
          )
      ],
    );
  }
}