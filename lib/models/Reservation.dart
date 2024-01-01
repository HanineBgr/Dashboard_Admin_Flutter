import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _searchController = TextEditingController();
  List<ReservationItem> allReservations = [];
  List<ReservationItem> displayedReservations = [];
  String selectedLanguage = 'fr';
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final response = await http.get(Uri.parse('http://localhost:5000/api/reservation/'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['reservations'];
        setState(() {
          allReservations = List<ReservationItem>.from(
            responseData.map((reservation) => ReservationItem.fromJson(reservation, prefs)),
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
      Translation translation =
          await translator.translate(allReservations[i].commentaire, to: selectedLanguage);
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        allReservations[i].commentaire = translation.text;
      });
    }
  }

  Future<void> _showLanguageSelectorPopup() async {
    String selectedLanguage = 'fr';

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
            Row(
              children: [
                Text('Commentaire: ${reservation.commentaire}'),
                if (!reservation.valider) _buildTraiterButton(reservation),
                if (reservation.valider) _buildValiderIcon(),
                if (!reservation.valider && !reservation.reprocessable) _buildCrossIcon(reservation),
                // _buildDeleteIcon(reservation),
              ],
            ),
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
        primary: selectedLanguage == languageCode ? color : Colors.indigo.shade300,
        shadowColor: selectedLanguage == languageCode ? Colors.black : Colors.transparent,
      ),
      onPressed: () async {
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          selectedLanguage = languageCode;
        });
        translateAllCommentaires();
      },
      child: Text(language),
    );
  }

  Widget _buildTraiterButton(ReservationItem reservation) {
    return IconButton(
      onPressed: () {
        _showTraiterPopup(reservation);
      },
      icon: Icon(Icons.edit),
    );
  }

  Widget _buildValiderIcon() {
    return Icon(Icons.check, color: Colors.green);
  }

  Widget _buildCrossIcon(ReservationItem reservation) {
    return IconButton(
      onPressed: () {
        _reprocessComment(reservation);
      },
      icon: Icon(Icons.clear, color: Colors.red),
    );
  }

  // Widget _buildDeleteIcon(ReservationItem reservation) {
  //   return IconButton(
  //     onPressed: () {
  //       _deleteReservation(reservation.reservationId);
  //     },
  //     icon: Icon(Icons.delete, color: Colors.red),
  //   );
  // }

  void filterReservations(String search) {
    setState(() {
      displayedReservations = allReservations
          .where((reservation) =>
              reservation.reservationId.contains(search) ||
              reservation.commentaire.contains(search))
          .toList();
    });
  }

  void _showTraiterPopup(ReservationItem reservation) async {
    bool? valider = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Traitement du Commentaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Valider ce commentaire ?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (valider != null) {
      handleComment(reservation.reservationId, valider);
    }
  }

  void _reprocessComment(ReservationItem reservation) {
    // Add your logic here for reprocessing the comment
    // You can set the reprocessable property to false if the comment is successfully reprocessed
    setState(() {
      reservation.reprocessable = false;
    });
  }

  // void _deleteReservation(String reservationId) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse('http://localhost:5000/api/reservation/$reservationId'),
  //     );

  //     if (response.statusCode == 200) {
  //       // Delete successful
  //       setState(() {
  //         allReservations.removeWhere((reservation) => reservation.reservationId == reservationId);
  //         displayedReservations.removeWhere((reservation) => reservation.reservationId == reservationId);
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Reservation deleted successfully')),
  //       );
  //     } else {
  //       // Delete failed
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to delete reservation')),
  //       );
  //       print('Failed to delete reservation. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (error) {
  //     print('Error deleting reservation: $error');
  //   }
  // }

  void handleComment(String reservationId, bool valider) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setBool('$reservationId-valider', valider);

    setState(() {
      final index =
          allReservations.indexWhere((reservation) => reservation.reservationId == reservationId);
      if (index != -1) {
        allReservations[index].valider = valider;
        filterReservations(_searchController.text);
      }
    });
  }
}

class ReservationItem {
  final String reservationId;
  final String dateCommentaire;
  String commentaire;
  bool valider;
  bool reprocessable;

  ReservationItem({
    required this.reservationId,
    required this.dateCommentaire,
    required this.commentaire,
    this.valider = false,
    this.reprocessable = false,
  });

  factory ReservationItem.fromJson(Map<String, dynamic> json, SharedPreferences prefs) {
    return ReservationItem(
      reservationId: json['_id'],
      dateCommentaire: json['dateReservation'],
      commentaire: json['commentaire'],
      valider: prefs.getBool('${json['_id']}-valider') ?? false,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservationPage(),
  ));
}
