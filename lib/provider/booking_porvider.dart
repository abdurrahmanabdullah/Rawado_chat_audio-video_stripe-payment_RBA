import 'package:flutter/material.dart';

class BookingPorvider extends ChangeNotifier {
  int? _id;
  String? _trainerName;
  String? _address;
  String? _date;
  String? _startTime;
  String? _endTime;
  String? _serviceType;
  int? _charge;
  String? _serviceTime;
  List<String>? _serviceTimeList;

  int? get id => _id;
  String? get trainerName => _trainerName;
  String? get address => _address;
  String? get date => _date;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get serviceType => _serviceType;
  int? get charge => _charge;
  String? get serviceTime => _serviceTime;
  List<String>? get serviceTimeList => _serviceTimeList;

  void setBookingInfo({
    int? id,
    String? trainerName,
    String? address,
    String? serviceType,
    String? int,
    int? charge,
  }) {
    _id = id;
    _trainerName = trainerName;
    _address = address;
    _serviceType = serviceType;
    _charge = charge;
  }

  void setAddress() {}

  void setSelectedDate(String date) {
    _date = date;
    notifyListeners();
  }

  void setStartTime(String time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(String time) {
    _endTime = time;
    notifyListeners();
  }

  void setServiceTime(String time) {
    _serviceTime = time;
    notifyListeners();
  }

  void ganaretServiceTime(String startTime, String endTime) {
    List<String> serviceTimes = [];
    DateTime start = DateTime.parse("2000-01-01 $startTime");
    DateTime end = DateTime.parse("2000-01-01 $endTime");
    Duration interval = const Duration(hours: 1); // Define your interval

    while (start.isBefore(end)) {
      DateTime nextSlot = start.add(interval);
      if (nextSlot.isAfter(end)) {
        break;
      }
      serviceTimes.add("${_formatTime(start)} - ${_formatTime(nextSlot)}");
      start = nextSlot;
    }

    _serviceTimeList = serviceTimes;
    notifyListeners();
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  void removeServiceTime() {
    _serviceTime = null;

    notifyListeners();
  }

  void clearBookingInfo() {
    _id = null;
    _address = null;
    _date = null;
    _startTime = null;
    _endTime = null;
    _serviceType = null;
    _charge = null;

    notifyListeners();
  }
}
