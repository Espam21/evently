import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EventLocationPicker extends StatefulWidget {
  const EventLocationPicker({super.key});

  @override
  State<EventLocationPicker> createState() => _EventLocationPickerState();
}

class _EventLocationPickerState extends State<EventLocationPicker> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Location')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.7963, 30.9986), // Default to Tanta
          zoom: 14,
        ),
        onMapCreated: (controller) => _mapController = controller,
        onTap: (latLng) {
          setState(() => _selectedLatLng = latLng);
        },
        markers: _selectedLatLng != null
            ? {
          Marker(
            markerId: const MarkerId('selected'),
            position: _selectedLatLng!,
          ),
        }
            : {},
      ),
      floatingActionButton: _selectedLatLng != null
          ? FloatingActionButton.extended(
        onPressed: () {
          final locationData = LocationData.fromMap({
            'latitude': _selectedLatLng!.latitude,
            'longitude': _selectedLatLng!.longitude,
          });
          Navigator.pop(context, locationData);
        },
        label: const Text('Confirm Location'),
        icon: const Icon(Icons.check),
      )
          : null,
    );
  }
}