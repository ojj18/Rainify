import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  /// GET CURRENT POSITION
  Future<bool> checkLocationPermission(BuildContext context) async {
    try {
      /// CHECK LOCATION SERVICE
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      /// LOCATION SERVICE DISABLED
      if (!serviceEnabled && context.mounted) {
        final bool openSettings = await _showLocationDialog(
          context,
          title: 'Location Disabled',
          message: 'Please enable location services.',
        );

        if (openSettings) {
          await Geolocator.openLocationSettings();
        }

        throw Exception('Location services are disabled.');
      }

      /// CHECK PERMISSION
      LocationPermission permission = await Geolocator.checkPermission();

      /// REQUEST PERMISSION
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied.');
        }
      }

      /// PERMISSION DENIED FOREVER
      if (permission == LocationPermission.deniedForever && context.mounted) {
        final bool openSettings = await _showLocationDialog(
          context,
          title: 'Permission Required',
          message: 'Please enable location permission in app settings.',
        );

        if (openSettings) {
          await Geolocator.openAppSettings();
        }

        throw Exception('Location permission permanently denied.');
      }
      return serviceEnabled;
    } on TimeoutException {
      throw Exception('Location request timeout.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Position> getCurrentPosition({bool isPerciseLocation = false}) async {
    /// GET POSITION
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: isPerciseLocation
            ? LocationAccuracy.medium
            : LocationAccuracy.low,
        // timeLimit: const Duration(seconds: 30),
      ),
    );
    return position;
  }

  /// COMMON DIALOG
  Future<bool> _showLocationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,

      barrierDismissible: false,

      builder: (context) {
        return AlertDialog(
          title: Text(title),

          content: Text(message),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
