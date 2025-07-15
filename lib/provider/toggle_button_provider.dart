import 'package:flutter/material.dart';

class PropertySelectorProvider with ChangeNotifier {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  void toggleSelection() {
    _isSelected = !_isSelected;
    notifyListeners();
  }

  void selectBuy() {
    _isSelected = false;
    notifyListeners();
  }

  void selectRent() {
    _isSelected = true;
    notifyListeners();
  }

  void clearslect() {
    _isSelected = false;
    notifyListeners();
  }
}
