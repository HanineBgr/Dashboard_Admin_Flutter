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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget pour les détails du panier
            Container(
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
                    decoration: InputDecoration(
                      hintText: 'ID du Panier',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print('Bouton Modifier appuyé');
                        },
                        child: Text('Modifier le panier'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          print('Bouton Supprimer appuyé');
                        },
                        child: Text('Supprimer'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Widget pour les statistiques (graphique)
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                color: Colors.grey.shade200,
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
