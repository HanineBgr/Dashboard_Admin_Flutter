import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _searchController = TextEditingController();
  List<ReservationItem> allReservations = List.generate(
    5,
    (index) => ReservationItem(
      reservationId: '$index',
      dateCommentaire: '05/12/2023 22:47 $index',
      commentaire: 'test 1 $index',
    ),
  );

  List<ReservationItem> displayedReservations = [];

  @override
  void initState() {
    super.initState();
    displayedReservations = List.from(allReservations);
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
