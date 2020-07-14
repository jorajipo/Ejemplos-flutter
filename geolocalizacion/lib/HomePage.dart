import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Distancia.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Instancia del objeto Geolocator
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //De este objeto sacaremos las coordenadas
  Position _currentPosition;

  //En esta cadena guardamos la dirección
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubicación"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Si el objeto que contiene las coordenadas no es nulo, muestra la ubicación
            if (_currentPosition != null)
              //Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            Text(_currentAddress),
            FlatButton(
              child: Text("Obtener ubicación"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
            FlatButton(
              child: Text("ir a pantalla de Mapa"),
              onPressed: () {
                //Abro pantalla pasando como parámetro el objeto Position
                Navigator.push(context, MaterialPageRoute(builder: (context) => Distancia(posicion: _currentPosition,)));
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    //En caso de éxito, actualizamos el estado y en caso de error, mostramos mensaje
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      //Convertimos cooordenadas a dirección
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {

    //_currentPosition es un objeto de tipo Position y de aquí sacamos las coordenadas
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

}