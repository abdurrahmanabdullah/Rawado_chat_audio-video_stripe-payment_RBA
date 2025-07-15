import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  String? _address;
  String? _lat = '23.8223';
  String? _lon = '90.3654';

  String? get address => _address;
  String? get lat => _lat;
  String? get lon => _lon;

  void setAddress(String address, String lat, String lon) {
    _address = address;
    _lat = lat;
    _lon = lon;
    notifyListeners();
  }

  void clearAddress() {
    _address = null;
    _lat = null;
    _lon = null;
    notifyListeners();
  }
}
