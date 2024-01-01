import 'dart:math';

import 'package:admin/models/Event.dart';
import 'package:admin/screens/Events/event_map.dart';
import 'package:admin/screens/Events/update_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/services/event_service.dart';
import 'package:geocode/geocode.dart'; // Import geocode package
import 'package:latlong2/latlong.dart';
import '../../../constants.dart';

class CharityEventsList extends StatefulWidget {
  final List<Event> charityEvents;
  const CharityEventsList({
    Key? key,
    required this.charityEvents,
  }) : super(key: key);

  @override
  _CharityEventsListState createState() => _CharityEventsListState();
}

class _CharityEventsListState extends State<CharityEventsList> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Charity Events",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Event Name"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Location"),
                      ),
                      DataColumn(
                        label: Text("Description"),
                      ),
                      DataColumn(
                        label: Text("Actions"),
                      ),
                    ],
                    rows: List.generate(
                      widget.charityEvents.length,
                      (index) => charityEventDataRow(
                          widget.charityEvents[index], context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow charityEventDataRow(Event eventInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(eventInfo.nameEvent!)),
        DataCell(Text(eventInfo.startEvent!)),
        DataCell(Text(eventInfo.addressEvent!)),
        DataCell(Text(eventInfo.descriptionEvent!)),
        DataCell(
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'update',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  iconColor: Colors.green,
                  title: Text('Update'),
                  textColor: Colors.green,
                ),
              ),
              PopupMenuItem<String>(
                value: 'location',
                child: ListTile(
                  leading: Icon(Icons.map),
                  iconColor: Colors.blue,
                  title: Text('Location'),
                  textColor: Colors.blue,
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  iconColor: Colors.red,
                  title: Text('Delete'),
                  textColor: Colors.red,
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'update') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEventScreen(eventInfo),
                  ),
                );
                // Handle update action with eventInfo.id
                print('Update Event: ${eventInfo.id}');
              } else if (value == 'delete') {
                // Delete with deleteEvent from event_service.dart
                EventService.deleteEvent(eventInfo.id);
                // Refresh the page by rebuilding the widget tree
                setState(() {
                  widget.charityEvents.remove(eventInfo);
                });
                print('Delete Event: ${eventInfo.id}');
              } else if (value == 'location') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventMap(
                      latitude: eventInfo.latitudeaddress,
                      longitude: eventInfo.longitudeaddress,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
