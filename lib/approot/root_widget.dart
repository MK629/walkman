import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/pages/current_page.dart';
import 'package:walkman/components/nav/navbar.dart';
import 'package:walkman/states/nav_notifier.dart';
import 'package:walkman/states/song_library_state.dart';
import 'package:walkman/states/walkman_state.dart';

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({ super.key });

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavNotifier()),
        ChangeNotifierProvider(create: (context) => SongLibraryState()),
        ChangeNotifierProvider(create: (context) => WalkmanState())
      ],
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: CurrentPage()),
            Navbar()
          ],
        )
      ),
    );
  }
}