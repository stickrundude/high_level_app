import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String?> getCurrentCity() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks[0].locality;
    }
  } catch (e) {
    print("Error retrieving location: $e");
  }
  return null;
}
