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
        BottomNavigationBarItem(icon: Icon(Icons.speaker), label: "Walkman"),
        BottomNavigationBarItem(icon: Icon(Icons.library_music_outlined), label: "Songs")
      ],
      selectedItemColor: Colors.cyanAccent,
      unselectedItemColor: Colors.tealAccent,
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      currentIndex: currentPage,
      onTap: (value) => navState.changePage(value),  
    );
  }
}