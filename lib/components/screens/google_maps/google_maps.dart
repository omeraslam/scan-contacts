import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMaps();
  }
}

class _GoogleMaps extends State<GoogleMaps> {
  GoogleMapController mapController;
  Set<Marker> markers = Set();

  final LatLng _center = const LatLng(31.5105, 74.3520);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        markers: markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
