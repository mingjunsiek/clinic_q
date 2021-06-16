import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    Key? key,
    required this.clinicId,
    required this.clinicName,
    required this.lat,
    required this.lng,
    required this.streetName,
  }) : super(key: key);

  final clinicId;
  final clinicName;
  final lat;
  final lng;
  final streetName;

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _googleMapController;
  final Set<Marker> _clinicMarkers = {};

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _googleMapController = _cntlr;

    _clinicMarkers.add(Marker(
      markerId: MarkerId(widget.clinicId),
      position: LatLng(widget.lat, widget.lng),
      infoWindow:
          InfoWindow(title: widget.clinicName, snippet: widget.streetName),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.lat,
          widget.lng,
        ),
        zoom: 16,
      ),
      onMapCreated: _onMapCreated,
      markers: _clinicMarkers,
    );
  }
}
