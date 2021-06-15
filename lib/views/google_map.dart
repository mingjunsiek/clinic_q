import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/widgets/ConfirmationPanel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/NearbyClinicPanel.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location _location = Location();
  late GoogleMapController _googleMapController;
  late LocationData _locationData;
  final Set<Marker> _clinicMarkers = {};
  final clinicController = Get.find<ClinicController>();

// slider
  final initFabHeight = 125.0;
  final fabHeight = 0.0.obs;
  final panelHeightOpen = 0.0.obs;
  final panelHeightClosed = 100.0.obs;

  //if user booked an appointment
  final isBookedAppt = false.obs;

  LatLng _initialCameraPosition = LatLng(
    1.3538107695634425,
    103.85797370238132,
  );

  @override
  void initState() {
    checkForLocationPermission();
    fabHeight.value = initFabHeight;
    super.initState();
  }

  checkForLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        Get.defaultDialog(
          title: 'You currently do not have any services',
          titleStyle: TextStyle(color: Colors.black),
          textConfirm: 'Okay',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
        );
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.defaultDialog(
          title: 'Please enable permission in your settings',
          titleStyle: TextStyle(color: Colors.black),
          textConfirm: 'Okay',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
        );
        return;
      }
    }

    _locationData = await _location.getLocation();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.latitude} : ${currentLocation.longitude}");
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

    clinicController.clinicList.forEach((clinic) {
      _clinicMarkers.add(Marker(
        markerId: MarkerId(clinic.clinicID),
        position: LatLng(clinic.lat, clinic.lng),
        infoWindow:
            InfoWindow(title: clinic.clinicName, snippet: clinic.streetName),
      ));
    });
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: _initialCameraPosition,
            // LatLng(
            //   l.latitude ?? 1.3538107695634425,
            //   l.longitude ?? 103.85797370238132,
            // ),
            zoom: 16),
      ),
    );
    // setState(() {
    //   _location.onLocationChanged.listen((LocationData l) {
    //     _googleMapController.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //             target: LatLng(
    //               l.latitude ?? 1.3538107695634425,
    //               l.longitude ?? 103.85797370238132,
    //             ),
    //             zoom: 16),
    //       ),
    //     );
    //   });
    // });
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

  @override
  Widget build(BuildContext context) {
    panelHeightOpen.value = MediaQuery.of(context).size.height - 300;

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              SlidingUpPanel(
                maxHeight: panelHeightOpen(),
                minHeight: panelHeightClosed(),
                parallaxEnabled: true,
                parallaxOffset: 0.5,
                panelBuilder: (ScrollController sc) => isBookedAppt()
                    ? ConfirmationPanel(controller: sc)
                    : NearbyClinicPanel(controller: sc),
                body: Center(
                  child: _googleMap(),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                onPanelSlide: (double pos) => fabHeight.value =
                    pos * (panelHeightOpen() - panelHeightClosed()) +
                        initFabHeight,
              ),
              Obx(
                () => Positioned(
                  right: 20.0,
                  bottom: fabHeight(),
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
              ),
              Container(
                padding: EdgeInsets.only(
                  top: defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding,
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
        ),
      ),
    );
  }
}
