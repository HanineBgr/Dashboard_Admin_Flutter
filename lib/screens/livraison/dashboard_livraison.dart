import 'package:admin/services/livraison_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:admin/models/livraison.dart';
import 'package:admin/screens//livraison/dashboard_card.dart';
import 'package:admin/screens/livraison/livraison_table.dart';

class DashboardLivraison extends StatefulWidget {
  @override
  _DashboardLivraisonState createState() => _DashboardLivraisonState();
}

class _DashboardLivraisonState extends State<DashboardLivraison> {
  LivraisonService livraisonService = LivraisonService(baseUrl: 'http://localhost:5000');
  List<Livraison> livraisons = [];
  int nombreTotalLivraisons = 0;
  int nombreProduitsLivres = 0;
  int nombreRetours = 0;
  late List<PieChartSectionData> paiChartSelectionData;
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    fetchLivraisons();

    // Initialize paiChartSelectionData here
    paiChartSelectionData = [
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: 0, // Set an initial value
        title: 'livre',
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: 0, // Set an initial value
        title: 'non livre',
        radius: 16,
      ),
    ];
  }

  Future<void> fetchLivraisons() async {
    try {
      List<Livraison> fetchedLivraisons = await livraisonService.getLivraisons();
      int totalLivraisons = (await livraisonService.countLiv()) ?? 0;
      int produitsLivres = (await livraisonService.countAndShowDeliveredLivraisons()) ?? 0;

      setState(() {
        livraisons = fetchedLivraisons;
        nombreTotalLivraisons = totalLivraisons;
        nombreProduitsLivres = produitsLivres;
        nombreRetours = totalLivraisons - produitsLivres;

        paiChartSelectionData = [
          PieChartSectionData(
            color: Color(0xFF26E5FF),
            value: nombreProduitsLivres.toDouble(),
            title: 'livre',
            radius: 22,
          ),
          PieChartSectionData(
            color: Color(0xFFEE2727),
            value: nombreRetours.toDouble(),
            title: 'non livre',
            radius: 16,
          ),
        ];
      });
    } catch (error) {
      print('Erreur lors de la récupération des livraisons: $error');
    }
  }

  Future<void> supprimerLivraison(Livraison livraison) async {
    try {
      await livraisonService.deleteLivraison(livraison.id);
      fetchLivraisons();
    } catch (error) {
      print('Erreur lors de la suppression de la livraison: $error');
    }
  }

  Future<void> livrerLivraison(Livraison livraison) async {
    try {
      await livraisonService.livrerLivraison(livraison.id);
      print('Livraison effectuée pour ${livraison.nomClient}');
      fetchLivraisons();
    } catch (error) {
      print('Erreur lors de la livraison: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de livraison'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchTerm = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Rechercher par client',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    LivraisonTable(
                      livraisons: livraisons
                          .where((livraison) =>
                              livraison.nomClient
                                  .toLowerCase()
                                  .contains(searchTerm.toLowerCase()))
                          .toList(),
                      onDelete: supprimerLivraison,
                      onLivrer: livrerLivraison,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(16),
                  child: PieChart(
                    PieChartData(
                      sections: paiChartSelectionData,
                    ),
                  ),
                ),
                DashboardCard(
                  title: 'Total Livraisons',
                  value: nombreTotalLivraisons,
                ),
                DashboardCard(
                  title: 'Produits Livrés',
                  value: nombreProduitsLivres,
                  valueStyle: TextStyle(color: Color(0xFF26E5FF)),
                ),
                DashboardCard(
                  title: 'Produits non Livrés',
                  value: nombreRetours,
                  valueStyle: TextStyle(color: Color(0xFFEE2727)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
