/*import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';



class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox GL Example'),
      ),
      body: MapboxMap(
        accessToken: 'sk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDkzdTlmMDl4NjJtcTB0dnZpd2V0ZyJ9.0Phj48kWvVP4C9MI4ymA0w',
        styleString: 'mapbox://styles/mapbox/streets-v11',
        onMapCreated: (MapboxMapController controller) {
          setState(() {
            this.controller = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Coordonnées de San Francisco, changez-les selon vos besoins
          zoom: 11.0,
        ),
      ),
    );
  }
}*/
/*
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LocalMap extends StatefulWidget {
  @override
  _LocalMapState createState() => _LocalMapState();
}

class _LocalMapState extends State<LocalMap> {
  MapboxMapController? mapboxMapController;

  void _onMapCreated(MapboxMapController controller) {
    mapboxMapController = controller;
    // Ajouter un symbole après que la carte soit créée
    _addSymbol();
  }

  // Charger une image à partir d'un fichier
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapboxMapController!.addImage(name, list);
  }

  // Ajouter un symbole à la carte
  Future<void> _addSymbol() async {
    // Charger l'image du marqueur
    await addImageFromAsset('marquer', 'assets/marker.png');
    // Ajouter le symbole avec l'image et la géométrie
    mapboxMapController!.addSymbol(
      SymbolOptions(
        geometry: LatLng(36.809328, 10.086327),
        iconImage: 'marquer',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: MapboxMap(
          // Notez le changement ici pour utiliser platformViewRegistry de dart:ui_web
          accessToken:
              'pk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDhwOXBxMDZidDJrcWVrM3VrdWJsZyJ9.LRS6GZWfeeYByOvy5BcTUA',
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(36.809328, 10.086327),
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
class LocalMap extends StatefulWidget {
  @override
  _LocalMapState createState() => _LocalMapState();
}

class _LocalMapState extends State<LocalMap> {
  MapboxMapController? mapboxMapController;

  void _onMapCreated(MapboxMapController controller) {
    mapboxMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: MapboxMap(
          // Notez le changement ici pour utiliser platformViewRegistry de dart:ui_web
          accessToken: 'pk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDhwOXBxMDZidDJrcWVrM3VrdWJsZyJ9.LRS6GZWfeeYByOvy5BcTUA',
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(36.809328, 10.086327),
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:ui_web' as ui;


class LocalMap extends StatefulWidget {
  @override
  _LocalMapState createState() => _LocalMapState();
}

class _LocalMapState extends State<LocalMap> {
  MapboxMapController? mapboxMapController;
  bool isMapLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: MapboxMap(
          accessToken: 'pk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDhwOXBxMDZidDJrcWVrM3VrdWJsZyJ9.LRS6GZWfeeYByOvy5BcTUA',
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(36.809328, 10.086327),
            zoom: 10.0,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapboxMapController = controller;

    // Wait for the map to be fully loaded before adding the circle
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isMapLoaded = true;
        addCircle();
      });
    });
  }

  void addCircle() {
    if (isMapLoaded && mapboxMapController != null) {
      mapboxMapController!.addCircle(
        CircleOptions(
          geometry: LatLng(36.809328, 10.086327),
          circleColor: '#d22355',
          circleRadius: 15,
        ),
      );

      // Notify Flutter that the state has changed
      setState(() {});
    }
  }
}












