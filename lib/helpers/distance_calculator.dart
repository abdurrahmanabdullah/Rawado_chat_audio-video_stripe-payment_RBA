import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<double> calculateDistance(
    BuildContext context, double lat2, double lon2) async {
  Position position = await getCurrentPosition(context);
  const earthRadius = 6371.0; // Earth's radius in kilometers

  // Convert degrees to radians
  double toRadians(double degree) => degree * pi / 180;

  final dLat = toRadians(lat2 - position.latitude);
  final dLon = toRadians(lon2 - position.longitude);

  final radLat1 = toRadians(position.latitude);
  final radLat2 = toRadians(lat2);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radLat1) * cos(radLat2) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance in kilometers
}

Future<Position> getCurrentPosition(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Handle the case where permission is denied
      // You can show an alert dialog or a snackbar here
      // return;
    }
  }

  Position position = await Geolocator.getCurrentPosition();

  return position;
}
