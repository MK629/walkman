import 'package:flutter/material.dart';

class NavNotifier extends ChangeNotifier {
  int page = 0;

  void changePage(int newPage){
    page = newPage;
    notifyListeners();
  }
}