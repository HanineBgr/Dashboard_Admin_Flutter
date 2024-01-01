import 'package:admin/constants.dart';
import 'package:admin/screens/Events/events_list.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/Event.dart';
import 'package:admin/services/event_service.dart';
import 'package:flutter_map/flutter_map.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Text(
                      "Events",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: defaultPadding),
                    FutureBuilder<List<Event>>(
                      future: EventService.getEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CharityEventsList(
                            charityEvents: snapshot.data!,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        // By default, show a loading indicator
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
