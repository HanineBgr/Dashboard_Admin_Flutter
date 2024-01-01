import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Event.dart';

class EventService {
  static const String baseUrl =
      'https://recycleconnect.onrender.com/api/events';

  //get all events
  static Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data is List) {
        List<Event> events =
            data.map((event) => Event.fromJson(event)).toList();
        return events;
      } else if (data is Map && data.containsKey('events')) {
        final List<dynamic> eventsData = data['events'];
        List<Event> events =
            eventsData.map((event) => Event.fromJson(event)).toList();
        return events;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  //delete event
  static Future<void> deleteEvent(String eventId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$eventId'));

      if (response.statusCode == 200) {
        print('Event deleted successfully');
      } else {
        throw Exception('Failed to delete event');
      }
    } catch (error) {
      print('Error deleting event: $error');
    }
  }

  // Update event
  static Future<Event> updateEvent(String eventId, Event updatedEvent) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$eventId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedEvent.toJson()),
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Event.fromJson(data['event']);
      } else {
        print('Failed to update event. Server response: ${response.body}');
        throw Exception('Failed to update event');
      }
    } catch (error) {
      print('Error updating event: $error');
      throw error;
    }
  }
}
