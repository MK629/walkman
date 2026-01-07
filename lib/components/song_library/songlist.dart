import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:walkman/helpers/music_helper.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Songs:"),
              ElevatedButton.icon(
                onPressed: () async {
                  var selectedSongs = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: [".mp3"], withData: false);
                  if(selectedSongs!.files.isNotEmpty){
                    await MusicHelper.importMusic(selectedSongs.files);
                    Box<String> musicBox = await Hive.openBox("MusicBox");
                    List<String> importedSongsPath = musicBox.values.toList();
                    songLibraryState.addSongs(importedSongsPath);
                  }
                },
                label: Text("Add more songs"),
                icon: Icon(Icons.playlist_add),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.only(right: 8, left: 8)),
                ),
              )
            ],
          ),
        ), 
        Divider(color: Colors.tealAccent,height: 1,thickness: 1,), 
        for(Song song in selectedSongList)
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.music_note_outlined),
                title: Text(song.title),
                onTap: () {
                  walkmanState.playMusic(song);
                },
                style: ListTileStyle.drawer,
                splashColor: Colors.tealAccent,
                trailing: IconButton(onPressed: () async {
                  await MusicHelper.removeMusic(song.path);
                  songLibraryState.removeSong(song);
                }, icon: Icon(Icons.delete_sweep)),
              ),
              Divider(color: Colors.tealAccent,height: 1,thickness: 0.5,), 
            ],
          )
      ],
    );
  }
}