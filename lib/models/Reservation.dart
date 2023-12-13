import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _searchController = TextEditingController();
  List<ReservationItem> allReservations = [];

  List<ReservationItem> displayedReservations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/reservation/'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['reservations'];
        setState(() {
          allReservations = List<ReservationItem>.from(
            responseData.map((reservation) => ReservationItem.fromJson(reservation)),
          );
          displayedReservations = List.from(allReservations);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails des Réservations'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Rechercher par ID, nom, ou date',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  filterReservations(value);
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: displayedReservations.length,
              itemBuilder: (context, index) {
                return displayedReservations[index];
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterReservations(String search) {
    setState(() {
      displayedReservations = allReservations
          .where((reservation) =>
              reservation.reservationId.contains(search) ||
              reservation.commentaire.contains(search))
          .toList();
    });
  }
}

class ReservationItem extends StatelessWidget {
  final String reservationId;
  final String dateCommentaire;
  final String commentaire;

  const ReservationItem({
    required this.reservationId,
    required this.dateCommentaire,
    required this.commentaire,
  });

  factory ReservationItem.fromJson(Map<String, dynamic> json) {
    return ReservationItem(
      reservationId: json['_id'],
      dateCommentaire: json['dateReservation'],
      commentaire: json['commentaire'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        ListTile(
          title: Text('ID de la Réservation: $reservationId'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date du Commentaire: $dateCommentaire'),
              Text('Commentaire: $commentaire'),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservationPage(),
  ));
}
