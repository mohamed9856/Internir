import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  int _currentPage = 0;

  int type = 0;

  int get currentPage => _currentPage;

  void setPage(int pageIndex) {
    _currentPage = pageIndex;
    notifyListeners();
  }

  void setType(int type) {
    this.type = type;
    notifyListeners();
  }
}