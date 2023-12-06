import 'package:admin/constants.dart';
import 'package:admin/models/livraison.dart';
import 'package:admin/screens/dashboard/livraison_table.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardLivraison extends StatefulWidget {
  @override
  _DashboardLivraisonState createState() => _DashboardLivraisonState();
}

class _DashboardLivraisonState extends State<DashboardLivraison> {
  List<Livraison> livraisons = [
    Livraison(
      nomArticle: 'Sac',
      nomClient: 'karim_kekli',
      addressMailClient: 'karim.kekli@esprit.tn',
      numeroClient: 23363948,
      ville: 'Tunis',
      addressClient: 'HZ',
    ),
    Livraison(
      nomArticle: 'Veste',
      nomClient: 'abir_karoui',
      addressMailClient: 'abir.karoui@esprit.tn',
      numeroClient: 55575542,
      ville: 'Aryena',
      addressClient: 'Aryena',
    ),
    // Ajoutez d'autres livraisons selon vos besoins
  ];

  int nombreTotalLivraisons = 100; // Remplacez par le nombre réel
  int nombreProduitsLivres = 75; // Remplacez par le nombre réel
  int nombreRetours = 25; // Remplacez par le nombre réel

  // Fonction de suppression
  void supprimerLivraison(Livraison livraison) {
    setState(() {
      livraisons.remove(livraison);
    });
    print('Livraison supprimée : ${livraison.nomArticle}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord de livraison'),
      ),
      body: Column(
        children: [
          // Affiche les statistiques dans des cardes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 150,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Nombre total de livraisons'),
                        Text('$nombreTotalLivraisons'),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Nombre de produits livrés'),
                        Text('$nombreProduitsLivres'),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Nombre de retours'),
                        Text('$nombreRetours'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Affiche le tableau de livraison
          Expanded(
            child: LivraisonTable(
              livraisons: livraisons,
              onDelete: supprimerLivraison,
            ),
          ),
          // Affiche le PieChart
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: paiChartSelectionData,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: defaultPadding),
                      Text(
                        '$nombreTotalLivraisons',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 0.5,
                            ),
                      ),
                      Text("Total Livraisons"),
                      // Ajoutez d'autres textes si nécessaire
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [

  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 75,
    showTitle: false,
    radius: 22,
  ),

  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 25,
    showTitle: false,
    radius: 16
  ),
];
  /*PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
    PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),*/







 
 
 /*import 'package:admin/models/livraison.dart';
import 'package:admin/screens/dashboard/livraison_table.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardLivraison extends StatefulWidget {
  @override
  _DashboardLivraisonState createState() => _DashboardLivraisonState();
}

class _DashboardLivraisonState extends State<DashboardLivraison> {
  List<Livraison> livraisons = [
    Livraison(
      nomArticle: 'Sac',
      nomClient: 'karim_kekli',
      addressMailClient: 'karim.kekli@esprit.tn',
      numeroClient: 23363948,
      ville: 'Tunis',
      addressClient: 'HZ',
    ),
    Livraison(
      nomArticle: 'Veste',
      nomClient: 'abir_karoui',
      addressMailClient: 'abir.karoui@esprit.tn',
      numeroClient: 55575542,
      ville: 'Aryena',
      addressClient: 'Aryena',
    ),
    // Ajoutez d'autres livraisons selon vos besoins
  ];

  // Fonction de suppression
  void supprimerLivraison(Livraison livraison) {
    setState(() {
      livraisons.remove(livraison);
    });
    print('Livraison supprimée : ${livraison.nomArticle}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord de livraison'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Statistiques de livraison',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      //BarChartRodData(y: livraisons.length.toDouble(), colors: [Colors.blue]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: LivraisonTable(
              livraisons: livraisons,
              onDelete: supprimerLivraison,
            ),
          ),
        ],
      ),
    );
  }
}*/