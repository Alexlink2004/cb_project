import 'package:flutter/material.dart';

class AdminPageController extends ChangeNotifier {
  int _index = 0;

  int get index {
    return _index;
  }

  set index(int data) {
    _index = data;
    notifyListeners();
  }
}
