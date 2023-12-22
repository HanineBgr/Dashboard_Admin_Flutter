import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _searchController = TextEditingController();
  List<ReservationItem> allReservations = [];
  List<ReservationItem> displayedReservations = [];
  String selectedLanguage = 'fr';

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

  Future<void> translateAllCommentaires() async {
    final translator = GoogleTranslator();

    for (int i = 0; i < allReservations.length; i++) {
      Translation translation = await translator.translate(allReservations[i].commentaire, to: selectedLanguage);
      await Future.delayed(Duration(milliseconds: 500)); // Ajout d'un délai de 500 ms
      setState(() {
        allReservations[i].commentaire = translation.text;
      });
    }
  }

  Future<void> _showLanguageSelectorPopup() async {
    String selectedLanguage = 'fr'; // Default language is French

    await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choisissez la Langue'),
          content: DropdownButton<String>(
            value: selectedLanguage,
            items: [
              DropdownMenuItem(
                value: 'fr',
                child: Text('Français'),
              ),
              DropdownMenuItem(
                value: 'en',
                child: Text('Anglais'),
              ),
              DropdownMenuItem(
                value: 'es',
                child: Text('Espagnol'),
              ),
              DropdownMenuItem(
                value: 'ar',
                child: Text('Arabe'),
              ),
            ],
            onChanged: (value) {
              selectedLanguage = value!;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedLanguage);
              },
              child: Text('Traduire'),
            ),
          ],
        );
      },
    );
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
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () async {
              await _showLanguageSelectorPopup();
              translateAllCommentaires();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageButtonBar(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: displayedReservations.length,
                itemBuilder: (context, index) {
                  return _buildReservationCard(displayedReservations[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCard(ReservationItem reservation) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('ID de la Réservation: ${reservation.reservationId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date du Commentaire: ${reservation.dateCommentaire}'),
            Text('Commentaire: ${reservation.commentaire}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLanguageButton('Français', 'fr', Colors.green),
        _buildLanguageButton('Anglais', 'en', Colors.blue),
        _buildLanguageButton('Espagnol', 'es', Colors.red),
        _buildLanguageButton('Arabe', 'ar', Colors.yellow),
      ],
    );
  }

  Widget _buildLanguageButton(String language, String languageCode, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: selectedLanguage == languageCode ? color : Colors.grey,
        shadowColor: selectedLanguage == languageCode ? Colors.black : Colors.transparent,
      ),
      onPressed: () async {
        await Future.delayed(Duration(milliseconds: 500)); // Ajout d'un délai de 500 ms
        setState(() {
          selectedLanguage = languageCode;
        });
        translateAllCommentaires();
      },
      child: Text(language),
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

class ReservationItem {
  final String reservationId;
  final String dateCommentaire;
  String commentaire;

  ReservationItem({
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
}

void main() {
  runApp(MaterialApp(
    home: ReservationPage(),
  ));
}
