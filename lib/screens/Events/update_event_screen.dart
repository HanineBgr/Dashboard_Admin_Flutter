import 'package:admin/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/Event.dart'; // Make sure to import your Event model

class UpdateEventScreen extends StatefulWidget {
  final Event event;

  UpdateEventScreen(this.event);

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the existing event details
    eventNameController.text = widget.event.nameEvent!;
    dateController.text = widget.event.startEvent!;
    locationController.text = widget.event.addressEvent!;
    descriptionController.text = widget.event.descriptionEvent!;
    //print event id to console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Implement the update logic here using the values from controllers
                String updatedEventName = eventNameController.text;
                String updatedDate = dateController.text;
                String updatedLocation = locationController.text;
                String updatedDescription = descriptionController.text;

                // Create an updated Event object
                Event updatedEvent = Event(
                  id: widget.event.id,
                  nameEvent: updatedEventName,
                  startEvent: updatedDate,
                  descriptionEvent: updatedDescription,
                  photoEvent: widget
                      .event.photoEvent, // Pass the existing photoEvent value
                  addressEvent: updatedLocation,
                  interested: widget
                      .event.interested, // Pass the existing interested list
                  going: widget.event.going, // Pass the existing going list
                  organizer: widget
                      .event.organizer, // Pass the existing organizer value
                  createdAt: widget
                      .event.createdAt, // Pass the existing createdAt value
                  latitudeaddress: widget.event
                      .latitudeaddress, // Pass the existing latitudeaddress value
                  longitudeaddress: widget.event
                      .longitudeaddress, // Pass the existing longitudeaddress value
                );

                try {
                  print(widget.event.id);
                  // Update the event using the EventService
                  await EventService.updateEvent(widget.event.id, updatedEvent);

                  // After updating, you might want to navigate back to the previous screen
                  Navigator.pop(context);
                } catch (error) {
                  // Handle the error as needed
                  print('Failed to update event: $error');
                }
              },
              child: Text('Update Event'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
