import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/pages/song_library.dart';
import 'package:walkman/pages/walkman.dart';
import 'package:walkman/states/nav_notifier.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({ super.key });

  @override
  Widget build(BuildContext context){
    var navState = context.watch<NavNotifier>();
    int currentPage = navState.page;

    Widget page;

    switch(currentPage){
      case 0: page = Walkman();
      case 1: page = SongLibrary();
      default: throw UnimplementedError('no widget for $currentPage');
    }
    
    return SafeArea(child: page);
  }
}