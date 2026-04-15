import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class CurrentLocationHelper {
  static Future<String?> getCurrentAddress() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return _fallbackLatLng(position.latitude, position.longitude);
      }

      final place = placemarks.first;
      final parts = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
      ];

      final formatted =
          parts
              .where((part) => part != null && part.trim().isNotEmpty)
              .map((part) => part!.trim())
              .toList();

      if (formatted.isEmpty) {
        return _fallbackLatLng(position.latitude, position.longitude);
      }

      return formatted.join(', ');
    } catch (_) {
      return null;
    }
  }

  static String _fallbackLatLng(double lat, double lng) {
    return '${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}';
  }
}
