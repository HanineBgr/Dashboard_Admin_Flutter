import 'package:admin/models/livraison.dart';
import 'package:admin/screens/dashboard/dashboard_card.dart';
import 'package:admin/screens/dashboard/livraison_table.dart';
import 'package:admin/screens/dashboard/services/livraison_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardLivraison extends StatefulWidget {
  @override
  _DashboardLivraisonState createState() => _DashboardLivraisonState();
}

class _DashboardLivraisonState extends State<DashboardLivraison> {
  LivraisonService livraisonService =
      LivraisonService(baseUrl: 'http://localhost:5000');
  List<Livraison> livraisons = [];

  int nombreTotalLivraisons = 0;
  int nombreProduitsLivres = 0;
  int nombreRetours = 0;

  List<PieChartSectionData> paiChartSelectionData = [
    PieChartSectionData(
      color: Color(0xFF26E5FF),
      value: 5,
      title: 'livre',
      radius: 22,
    ),
    PieChartSectionData(
      color: Color(0xFFEE2727),
      value: 1,
      title: 'non livre',
      radius: 16,
    ),
  ];

  Future<void> fetchLivraisons() async {
    try {
      List<Livraison> fetchedLivraisons =
          await livraisonService.getLivraisons();
      int totalLivraisons = (await livraisonService.countLiv()) ?? 0;
      int produitsLivres = 1; // Remplacez cette valeur par la vraie valeur

      setState(() {
        livraisons = fetchedLivraisons;
        nombreTotalLivraisons = totalLivraisons;
        nombreProduitsLivres = produitsLivres;
        nombreRetours = totalLivraisons - produitsLivres;
      });
    } catch (error) {
      print('Erreur lors de la récupération des livraisons: $error');
    }
  }

  Future<void> supprimerLivraison(Livraison livraison) async {
    try {
      await livraisonService.deleteLivraison(livraison.id);
      fetchLivraisons(); // Rafraîchir la liste des livraisons après la suppression
    } catch (error) {
      print('Erreur lors de la suppression de la livraison: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLivraisons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord de livraison'),
      ),
      body: Row(
        children: [
          // Premier conteneur centré avec le tableau
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: LivraisonTable(
                  livraisons: livraisons,
                  onDelete: supprimerLivraison,
                ),
              ),
            ),
          ),
          SizedBox(width: 5), // Espace entre les deux conteneurs
          // Deuxième conteneur à droite avec DashboardCard et le graphique
          Container(
            width: 200, // Ajustez la largeur selon vos besoins
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





/*import 'package:admin/constants.dart';
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
];*/