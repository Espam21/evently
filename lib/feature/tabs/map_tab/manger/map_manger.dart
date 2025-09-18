import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final selectedLocation = StateProvider<LocationData?>((ref) => null);
final selectedLocationMsg = StateProvider<String?>((ref) => null);
class MapManger{
  var location = Location();

  Future<void>getLocation(BuildContext context,WidgetRef ref)async{
    ref.read(selectedLocationMsg.notifier).state = 'check for location services';
    bool locationPermissionGranted=await _getLocationPermission();
    if(!locationPermissionGranted){
      ref.read(selectedLocationMsg.notifier).state = 'location permission denied';
      return;
    }
    bool locationServiceEnabled=await _locationServiceEnabled();
    if(!locationServiceEnabled){
      ref.read(selectedLocationMsg.notifier).state = 'location service disabled';
      return;
    }
    try {
      LocationData locationData = await location.getLocation();
      ref.read(selectedLocation.notifier).state = locationData;
      ref.read(selectedLocationMsg.notifier).state =
      'Lat: ${locationData.latitude}, Lng: ${locationData.longitude}';
    } catch (e) {
      ref.read(selectedLocationMsg.notifier).state = 'Failed to get location: $e';
    }

  }

  Future<bool> _getLocationPermission()async{
    var permissionStatus=await location.hasPermission();
    if(permissionStatus==PermissionStatus.denied){
      permissionStatus=await location.requestPermission();
    }

      return permissionStatus==PermissionStatus.granted;
  }
  Future<bool> _locationServiceEnabled()async{
    var locationService=await location.serviceEnabled();
    if(!locationService){
      locationService=await location.requestService();
    }

    return locationService;
  }
}





