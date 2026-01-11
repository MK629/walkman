import 'package:flutter/material.dart';

class NavNotifier extends ChangeNotifier {
  int page = 1;

  void changePage(int newPage){
    page = newPage;
    notifyListeners();
  }
}