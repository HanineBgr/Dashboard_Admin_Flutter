import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<Map<String, dynamic>> chartData = [];
  Map<String, int> panierCounts = {
    'En cours': 0,
    'Validé': 0,
    'Terminé': 0,
    'Annulé': 0,
  };
  Map<String, dynamic>? panierDetails;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/panier/'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['paniers'];
        setState(() {
          chartData = List<Map<String, dynamic>>.from(responseData);

          // Réinitialiser les compteurs
          panierCounts = {
            'En cours': 0,
            'Validé': 0,
            'Terminé': 0,
            'Annulé': 0,
          };

          // Compter le nombre de paniers dans chaque état
          for (final panier in chartData) {
            final etatPanier = panier['etatPanier'] as String;
            if (panierCounts.containsKey(etatPanier)) {
              panierCounts[etatPanier] = panierCounts[etatPanier]! + 1;
            }
          }

          print('panierCounts: $panierCounts');
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Gérer l'erreur de manière appropriée, par exemple, afficher un message à l'utilisateur.
    }
  }

  void updatePanierDetails(String panierId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/panier/$panierId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = jsonDecode(response.body)['panier'];

        if (responseData != null) {
          // Mettez à jour les détails du panier affichés dans le widget
          setState(() {
            panierDetails = responseData;
          });

          print('Détails du panier: $responseData');
        } else {
          print('Error: Panier details not found');
        }
      } else {
        throw Exception('Failed to load panier details');
      }
    } catch (error) {
      print('Error updating panier details: $error');
    }
  }

  Future<void> deletePanier(String panierId) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:5000/api/panier/$panierId'));
      if (response.statusCode == 200) {
        print('Panier deleted successfully');
        // You can add any additional logic after successful deletion
      } else {
        throw Exception('Failed to delete panier');
      }
    } catch (error) {
      print('Error deleting panier: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Panier'),
        actions: [
          IconButton(
            onPressed: () {
              // Action pour le bouton de recherche
              print('Bouton de recherche appuyé');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Widget pour les détails du panier
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Détail Panier',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _searchController,
                      onChanged: (panierId) {
                        updatePanierDetails(panierId);
                      },
                      decoration: InputDecoration(
                        hintText: 'ID du Panier',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Widget pour afficher les détails du panier
                    if (panierDetails != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${panierDetails!['_id']}'),
                          Text('Total Panier: ${panierDetails!['totalPanier']}'),
                          Text('État Panier: ${panierDetails!['etatPanier']}'),
                          // Ajoutez d'autres détails du panier ici
                        ],
                      ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Action pour le bouton Supprimer
                        if (_searchController.text.isNotEmpty) {
                          deletePanier(_searchController.text);
                        }
                      },
                      child: Text('Supprimer'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Widget pour les statistiques (graphique)
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 16),
                color: Colors.black,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Statistiques: ${chartData.length} paniers',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // Ajoutez votre widget de graphique ici
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: panierCounts.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(showTitles: true, interval: 1),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              rotateAngle: 45,
                              getTitles: (double value) {
                                final index = value.toInt();
                                final etats = panierCounts.keys.toList();
                                if (index >= 0 && index < etats.length) {
                                  return etats[index];
                                }
                                return '';
                              },
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [BarChartRodData(y: panierCounts['En cours']!.toDouble(), colors: [Colors.blue], width: 16)],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [BarChartRodData(y: panierCounts['Validé']!.toDouble(), colors: [Colors.green], width: 16)],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [BarChartRodData(y: panierCounts['Terminé']!.toDouble(), colors: [Colors.orange], width: 16)],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [BarChartRodData(y: panierCounts['Annulé']!.toDouble(), colors: [Colors.red], width: 16)],
                              showingTooltipIndicators: [0],
                            ),
                          ],
                        ),
                      ),
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

void main() {
  runApp(MaterialApp(
    home: PanierPage(),
  ));
}
