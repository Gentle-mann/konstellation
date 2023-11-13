import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  bool _useSeparateTimes = false;
  bool _useIncrement = false;
  bool get useSeparateTimes => _useSeparateTimes;
  bool get useIncrement => _useIncrement;

  void toogleUseSeparateTimes() {
    _useSeparateTimes = !_useSeparateTimes;
    notifyListeners();
  }

  void toggleUseIncrement() {
    _useIncrement = !_useIncrement;
    notifyListeners();
  }
}
