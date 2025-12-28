import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/components/song_library/empty_songlist.dart';
import 'package:walkman/components/song_library/songlist.dart';
import 'package:walkman/states/song_library_state.dart';

class SongLibrary extends StatelessWidget {
  const SongLibrary({ super.key });

  @override
  Widget build(BuildContext context){
    var songLibraryState = context.watch<SongLibraryState>();
    
    Widget currentListPage;
    
    if(songLibraryState.songList.isEmpty){
      currentListPage = EmptySongList();
    }
    else{
      currentListPage = SongList();
    }

    return currentListPage;
  }
}