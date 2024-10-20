import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int _index = 3;

  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
