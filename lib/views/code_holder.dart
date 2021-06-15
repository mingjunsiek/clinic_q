import 'dart:async';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:location/location.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  Location _location = Location();
  late LocationData _locationData;
  final Set<Marker> _clinicMarkers = {};

// slider
  final double _initFabHeight = 125.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 100.0;

  LatLng _initialCameraPosition =
      LatLng(1.3538107695634425, 103.85797370238132);

  @override
  void initState() {
    // TODO: implement initState
    checkForLocationPermission();
    _fabHeight = _initFabHeight;
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

  Widget _googleMap() {
    return Container(
      child: GoogleMap(
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
    );
  }

  Widget _scrollingList(ScrollController sc) {
    final items = List<String>.generate(10, (i) => "Item $i");

    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Container(
          height: 5.0,
          width: 30.0,
          color: kPrimaryBtnColor,
        ),
        Expanded(
          child: ListView.builder(
              controller: sc,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () {},
                  title: Text(
                    '${items[index]}',
                    style: TextStyle(color: Colors.black),
                  ),
                ));
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height - 300;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            panelBuilder: (ScrollController sc) => _scrollingList(sc),
            body: Center(
              child: _googleMap(),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: kPrimaryBtnColor,
              ),
              onPressed: () {
                _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: _initialCameraPosition,
                  zoom: 16,
                )));
              },
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 70.0,
              left: 8.0,
              right: 8.0,
            ),
            child: FormTextField(
              labelText: "SEARCH CLINICS",
              fieldKeyboardType: TextInputType.visiblePassword,
              validatorFunction: (value) => !isEmail(value)
                  ? "Sorry, we do not recognize this email address"
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
