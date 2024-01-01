class Event {
  String id;
  String nameEvent;
  String startEvent;
  String descriptionEvent;
  String photoEvent;
  String addressEvent;
  String organizer;
  List<String> interested;
  List<String> going;
  DateTime createdAt;
  double latitudeaddress;
  double longitudeaddress;

  Event({
    required this.id,
    required this.nameEvent,
    required this.startEvent,
    required this.descriptionEvent,
    required this.photoEvent,
    required this.addressEvent,
    required this.interested,
    required this.going,
    required this.organizer,
    required this.createdAt,
    required this.latitudeaddress,
    required this.longitudeaddress,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      nameEvent: json['nameEvent'],
      startEvent: json['startEvent'],
      descriptionEvent: json['descriptionEvent'],
      photoEvent: json['PhotoEvent'],
      addressEvent: json['addressEvent'],
      organizer: json['organizer'],
      interested: List<String>.from(json['interested']),
      going: List<String>.from(json['going']),
      createdAt: DateTime.parse(json['createdAt']),
      latitudeaddress: json['latitudeaddress'] ?? 0.0,
      longitudeaddress: json['longitudeaddress'] ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nameEvent': nameEvent,
      'startEvent': startEvent,
      'addressEvent': addressEvent,
      'descriptionEvent': descriptionEvent,
      'PhotoEvent': photoEvent,
      'organizer': organizer,
      'interested': interested,
      'going': going,
      'latitudeaddress': latitudeaddress,
      'longitudeaddress': longitudeaddress,

      // Add other fields as needed
    };
  }
}
