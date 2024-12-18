import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '/generated/l10n.dart'; // Import the generated localization class

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
  TextEditingController searchController = TextEditingController();
  String? apiKey;
  Set<Marker> _markers = {}; // Store markers

  @override
  void initState() {
    super.initState();
    apiKey = dotenv.env['GOOGLE_MAPS_API_KEY']; // Load API key from .env
    if (apiKey == null) {
      showError('API key not found!');
      return;
    }
    getCurrentLocation();
  }

  // Fetch the current location
  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showError('Location services are disabled.');
        return;
      }

      // Check for location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          showError('Location permission denied.');
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
    } catch (e) {
      showError('Failed to get location: $e');
    }
  }

  // Show an error message to the user
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Fetch search predictions from Google Places API
  Future<void> _onSearchPlace() async {
    final query = searchController.text;
    if (query.isEmpty || apiKey == null) return;

    // Ensure the query is properly encoded
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedQuery&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final predictions = data['predictions'];

        if (predictions.isNotEmpty) {
          final place = predictions[0]; // Use the first prediction
          final placeId = place['place_id'];

          // Get the details of the selected place
          await _getPlaceDetails(placeId);
        } else {
          showError(S.of(context).noPlacesFound); // Use localized string
        }
      } else {
        showError('Failed to fetch search results.');
      }
    } catch (e) {
      showError('Failed to search place: $e');
    }
  }

  // Fetch place details by place ID
  Future<void> _getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['result'];

        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];

        // Update the camera position to the selected place
        mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

        // Update markers
        setState(() {
          _markers = {
            Marker(
              markerId: const MarkerId('SRH University Heidelberg'),
              position: srhUniversity,
            ),
            Marker(
              markerId: const MarkerId('Search Result'),
              position: LatLng(lat, lng),
            ),
          };
        });
      } else {
        showError('Failed to fetch place details.');
      }
    } catch (e) {
      showError('Failed to get place details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).map),  // Use localized string for the map page title
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition!,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: _markers, // Dynamically update markers
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: apiKey == null
                ? const CircularProgressIndicator()
                : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: S.of(context).searchPlaceholder, // Use localized string for search placeholder
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _onSearchPlace,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
