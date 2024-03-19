import 'package:flutter/material.dart';

class CheckLastScreenProvider with ChangeNotifier{
  bool _isLastScreen = false;
  bool get isLastScreen => _isLastScreen;
  void setLastScreen(bool value){
    _isLastScreen = value;
    notifyListeners();
  }
}