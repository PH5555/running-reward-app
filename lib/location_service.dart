import 'package:location/location.dart';
import 'dart:math' as Math;

class LocationService {
  static Location location = new Location();

  static Future<bool> checkPermission() async {
    bool _serviceEnabled = false;
    late PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  static Future<LocationData> getLocation() async {
    late LocationData _locationData;
    _locationData = await location.getLocation();
    return _locationData;
  }

  static double getDistance(LocationData oldData, LocationData newData) {
    const R = 6371e3; // metres
    double alpha1 = oldData.latitude! * Math.pi / 180; // φ, λ in radians
    double alpha2 = newData.latitude! * Math.pi / 180;
    double deltaAlpha = (newData.latitude! - oldData.latitude!) * Math.pi / 180;
    double deltaGamma =
        (newData.longitude! - oldData.longitude!) * Math.pi / 180;

    double a = Math.sin(deltaAlpha / 2) * Math.sin(deltaAlpha / 2) +
        Math.cos(alpha1) *
            Math.cos(alpha2) *
            Math.sin(deltaGamma / 2) *
            Math.sin(deltaGamma / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    double d = R * c; // in metres
    return d;
  }
}
