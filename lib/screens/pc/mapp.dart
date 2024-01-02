
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

      setState(() {});
    }
  }
}
