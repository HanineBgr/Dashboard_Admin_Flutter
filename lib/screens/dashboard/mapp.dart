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
  final double x;
  final double y;

  LocalMap({required this.x, required this.y});

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
        title: Text('Local Map'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: MapboxMap(
          accessToken: 'pk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDhwOXBxMDZidDJrcWVrM3VrdWJsZyJ9.LRS6GZWfeeYByOvy5BcTUA',
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.x, widget.y),
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
          geometry: LatLng(widget.x, widget.y),
          circleColor: '#d22355',
          circleRadius: 15,
        ),
      );

      // Notify Flutter that the state has changed
      setState(() {});
    }
  }
}
/*
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
}*/

/*
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LocalMap extends StatefulWidget {
  @override
  _LocalMapState createState() => _LocalMapState();
}

class _LocalMapState extends State<LocalMap> {
  MapboxMapController? mapboxMapController;
  bool isMapLoaded = false;
  double circleRadius = 15.0;
  LatLng circleLatLng = LatLng(36.809328, 10.086327);
  String textToShow = 'Votre texte ici';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox Example'),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: MapboxMap(
              accessToken: 'pk.eyJ1Ijoia2FyaW0yMjMiLCJhIjoiY2xvdDhwOXBxMDZidDJrcWVrM3VrdWJsZyJ9.LRS6GZWfeeYByOvy5BcTUA',
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(36.809328, 10.086327),
                zoom: 10.0,
              ),
            ),
          ),
          if (isMapLoaded)
            Positioned(
              left: circleLatLng.longitude,
              top: circleLatLng.latitude,
              child: CustomPaint(
                painter: CircleTextPainter(circleRadius, textToShow),
              ),
            ),
        ],
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
          geometry: circleLatLng,
          circleColor: '#d22355',
          circleRadius: circleRadius,
        ),
      );

      // Notify Flutter that the state has changed
      setState(() {});
    }
  }
}

class CircleTextPainter extends CustomPainter {
  final double circleRadius;
  final String text;

  CircleTextPainter(this.circleRadius, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.red;
    Paint textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    double circleCenterX = size.width / 2;
    double circleCenterY = size.height / 2;

    canvas.drawCircle(Offset(circleCenterX, circleCenterY), circleRadius, circlePaint);

    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(canvas, Offset(circleCenterX - painter.width / 2, circleCenterY - painter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}*/



/*
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
      body: Stack(
        children: [
          Container(
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: MediaQuery.of(context).size.width * 0.5 - 50, // Adjust as needed
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(96, 20, 20, 20),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Votre point de collecte',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
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
*/