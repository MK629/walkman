
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:walkman/helpers/music_helper.dart';
import 'package:walkman/states/song_library_state.dart';
import 'package:walkman/states/walkman_state.dart';

class EmptySongList extends StatelessWidget {
  const EmptySongList({super.key});
  
  @override
  Widget build(BuildContext context) {

    var songLibraryState = context.read<SongLibraryState>();
    var walkmanState = context.read<WalkmanState>();
    
    walkmanState.loadSongs(songLibraryState.songList);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Uh oh. Looks pretty empty.", style: TextStyle(color: Colors.tealAccent),),
        SizedBox(height: 10,),
        ElevatedButton.icon(
          onPressed: () async {
            //Note to self: Never use file_selector. Not efficient. Use file_picker instead.
            var selectedSongs = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: [".mp3"], withData: false);
            if(selectedSongs!.files.isNotEmpty){
              await MusicHelper.importMusic(selectedSongs.files);
              Box<String> musicBox = await Hive.openBox("MusicBox");
              List<String> importedSongsPath = musicBox.values.toList();
              songLibraryState.addSongs(importedSongsPath);
            }
          },
          label: Text("Pick some awesome music"),
          icon: Icon(Icons.folder),
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.only(right: 8, left: 8)),
          ),
        )
      ],
    );
  }
}