import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  CameraPosition? _initialPosition;
  LatLng? _currentPosition;
  final srhUniversity = const LatLng(49.413905, 8.651047);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  // Fetch the current location
  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permission denied');
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _initialPosition = CameraPosition(
        target: _currentPosition!,
        zoom: 14.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: _initialPosition!,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: {
                Marker(
                  markerId: const MarkerId('SRH University Heidelberg'),
                  position: srhUniversity,
                ),
              },
              myLocationEnabled: true,  // Show current location on the map
              myLocationButtonEnabled: true,  // Show location button
            ),
    );
  }
}
