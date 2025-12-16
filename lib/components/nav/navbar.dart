import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkman/states/nav_notifier.dart';

class Navbar extends StatelessWidget {
  const Navbar({ super.key });

  @override
  Widget build(BuildContext context){
    var navState = context.watch<NavNotifier>();
    var currentPage = navState.page;

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.play_circle_outlined), label: "Walkman"),
        BottomNavigationBarItem(icon: Icon(Icons.library_music_outlined), label: "Songs")
      ], 
      currentIndex: currentPage,
      onTap: (value) => navState.changePage(value),  
    );
  }
}