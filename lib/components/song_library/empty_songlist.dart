
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/states/song_library_state.dart';

class EmptySongList extends StatelessWidget {
  const EmptySongList({super.key});
  
  @override
  Widget build(BuildContext context) {

    var songLibraryState = context.read<SongLibraryState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("There is no selected music."),
        ElevatedButton.icon(
          onPressed: () async {
            var typeGroup = XTypeGroup(label: 'audio', extensions: ['mp3', 'wav']);
            var selectedSongs = await openFiles(acceptedTypeGroups: [typeGroup]);
            songLibraryState.addSongs(selectedSongs);
          },
          label: Text("Pick some awesome music"),
          icon: Icon(Icons.folder)
        )
      ],
    );
  }
}