import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class EventMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  EventMap({required this.latitude, required this.longitude});
  @override
  State<EventMap> createState() => _MapPageState();
}

class _MapPageState extends State<EventMap> {
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(widget.latitude, widget.longitude),
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(widget.latitude, widget.longitude),
                        // Use the `child` parameter for the widget
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () async {
                          if (await canLaunch(
                              'https://openstreetmap.org/copyright')) {
                            await launch('https://openstreetmap.org/copyright');
                          } else {
                            throw 'Could not launch';
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
