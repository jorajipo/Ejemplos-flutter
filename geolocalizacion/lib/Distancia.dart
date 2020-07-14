import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Distancia extends StatelessWidget {
  GoogleMapController mapController;
  final Position posicion;

  Distancia({Key key, @required this.posicion}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(posicion.latitude,posicion.longitude),
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}