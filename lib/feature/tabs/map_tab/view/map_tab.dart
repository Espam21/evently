import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../manger/map_manger.dart';

class MapTab extends ConsumerStatefulWidget {
  const MapTab({super.key});

  @override
  ConsumerState<MapTab> createState() => _MapTabState();
}

class _MapTabState extends ConsumerState<MapTab> {
  GoogleMapController? _mapController;
  final MapManger _mapManager = MapManger();

  @override
  void initState() {
    super.initState();
    _mapManager.getLocation(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final locationData = ref.watch(selectedLocation);
    final locationMsg = ref.watch(selectedLocationMsg);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Location')),
      body: locationData == null
          ? Center(child: Text(locationMsg ?? 'Fetching location...'))
          : GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(locationData.latitude!, locationData.longitude!),
            infoWindow: const InfoWindow(title: 'You are here'),
          ),
        },
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mapManager.getLocation(context, ref),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
