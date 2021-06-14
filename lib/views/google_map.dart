import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final Set<Marker> _clinicMarkers = {};

  LatLng _initialCameraPosition =
      LatLng(1.3538107695634425, 103.85797370238132);

  @override
  void initState() {
    // TODO: implement initState
    checkForLocationPermission();
    super.initState();
  }

  checkForLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    } else {
      print('service enabled');
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('permission not granted');
        return;
      }
    } else {
      print('permission granted');
    }

    _locationData = await _location.getLocation();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _locationData = currentLocation;
        _initialCameraPosition = LatLng(
          _locationData.latitude ?? 1.3538107695634425,
          _locationData.longitude ?? 103.85797370238132,
        );
      });
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _googleMapController = _cntlr;

    setState(() {
      _clinicMarkers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(1.4273975047772334, 103.82951289010866),
        infoWindow: InfoWindow(title: 'clinic A', snippet: 'A clinical placec'),
      ));

      _location.onLocationChanged.listen((LocationData l) {
        _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                  l.latitude ?? 1.3538107695634425,
                  l.longitude ?? 103.85797370238132,
                ),
                zoom: 16),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 12,
        ),
        onMapCreated: _onMapCreated,
        markers: _clinicMarkers,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryBtnColor,
        foregroundColor: Colors.black,
        child: Icon(Icons.center_focus_strong),
        onPressed: () => {
          _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _initialCameraPosition,
                zoom: 16,
              ),
            ),
          ),
        },
      ),
    );
  }
}
