
import 'package:admin/screens/pc/formumair_pc.dart';
import 'package:admin/screens/pc/mapp.dart';
import 'package:admin/screens/pc/pc_table.dart';
import 'package:admin/services/pc_services.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:admin/models/PointCollecte.dart';
class DashboardPC extends StatefulWidget {
  @override
  _DashboardPCState createState() => _DashboardPCState();
}

class _DashboardPCState extends State<DashboardPC> {
  PointCollecteService pointCollecteService =
      PointCollecteService(baseUrl: 'http://localhost:5000');
  List<PointCollecte> pointsCollecte = [];
  int nombreTotalPointCollecte = 0;
  int nombrePointCollecteActif = 0;
  int nombrePointCollecteInactif = 0;
  String searchTerm = '';

  Future<void> fetchPc() async {
    try {
      List<PointCollecte> fetchedPC =
          await pointCollecteService.getPointsCollecte();
      int totalPoints = (await pointCollecteService.countTotalPoints()) ?? 0;
      int inactivePoints =
          (await pointCollecteService.countInactivePoints()) ?? 0;
      int activePoints =
          await pointCollecteService.countActivePoints() ?? 0;

      setState(() {
        pointsCollecte = fetchedPC;
        nombreTotalPointCollecte = totalPoints;
        nombrePointCollecteActif = activePoints;
        nombrePointCollecteInactif = inactivePoints;
      });
    } catch (error) {
      print('Erreur lors de la récupération des Point Collecte: $error');
    }
  }

  Future<void> fetchStatistics() async {
    try {
      int totalPoints = (await pointCollecteService.countTotalPoints()) ?? 0;
      int inactivePoints =
          (await pointCollecteService.countInactivePoints()) ?? 0;
      int activePoints =
          await pointCollecteService.countActivePoints() ?? 0;

      setState(() {
        nombreTotalPointCollecte = totalPoints;
        nombrePointCollecteActif = activePoints;
        nombrePointCollecteInactif = inactivePoints;
      });
    } catch (error) {
      print('Erreur lors de la récupération des statistiques: $error');
    }
  }

  Future<void> supprimerPointCollecte(PointCollecte pointCollecte) async {
    try {
      await pointCollecteService.deletePointCollecte(pointCollecte.id);

      await fetchStatistics(); // Update statistics

      setState(() {
        pointsCollecte.remove(pointCollecte);
      });

      print('Point de collecte supprimé : ${pointCollecte.nomPc}');
    } catch (error) {
      print('Erreur lors de la suppression du point de collecte : $error');
    }
  }

  void modifierPointCollecte(PointCollecte pointCollecte) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AjoutPointCollecte(
          onAjouter: mettreAjourPointCollecte,
          pointToUpdate: pointCollecte,
        ),
      ),
    );
  }

  void ajouterPointCollecte(PointCollecte nouveauPointCollecte) async {
    try {
      PointCollecte pointCree =
          await pointCollecteService.createPointCollecte(nouveauPointCollecte);

      await fetchStatistics(); // Update statistics

      setState(() {
        pointsCollecte.add(pointCree);
      });

      print('Nouveau Point de collecte ajouté : ${nouveauPointCollecte.nomPc}');
    } catch (error) {
      print('Erreur lors de l\'ajout du point de collecte : $error');
    }
  }

  void naviguerVersAjoutPointCollecte() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AjoutPointCollecte(
          onAjouter: ajouterPointCollecte,
        ),
      ),
    );
  }

  void naviguerVersLocalMap(PointCollecte pointCollecte) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalMap(x: pointCollecte.x.toDouble(), y: pointCollecte.y.toDouble()),
      ),
    );
  }

  void mettreAjourPointCollecte(PointCollecte updatedPointCollecte) async {
    try {
      PointCollecte pointMisAjour =
          await pointCollecteService.updatePointCollecte(updatedPointCollecte);

      setState(() {
        int index =
            pointsCollecte.indexWhere((pc) => pc.id == pointMisAjour.id);
        if (index != -1) {
          pointsCollecte[index] = pointMisAjour;
        }
      });

      print('Point de collecte mis à jour : ${pointMisAjour.nomPc}');
    } catch (error) {
      print('Erreur lors de la mise à jour du point de collecte : $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPc();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Liste des points de collecte'),
    ),
    body: Row(
      children: [
        // Conteneur pour le tableau et le bouton
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
ElevatedButton(
  onPressed: naviguerVersAjoutPointCollecte,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.add), // Icône +
      SizedBox(width: 5), // Espacement entre l'icône et le texte
      Text('Ajouter un Point de Collecte'),
    ],
  ),
),
SizedBox(height: 10), // Espacement
TextField(
  onChanged: (value) {
    setState(() {
      searchTerm = value;
    });
  },
                    decoration: InputDecoration(
                      labelText: 'Rechercher point collecte',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  PointCollecteTable(
                    pointsCollecte: pointsCollecte
                        .where((point) =>
                            point.nomPc
                                .toLowerCase()
                                .contains(searchTerm.toLowerCase()))
                        .toList(),
                    onDelete: supprimerPointCollecte,
                    onEdit: modifierPointCollecte,
                    onTableRefresh: fetchPc,
                    onPosition: naviguerVersLocalMap,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 20), // Espacement entre les deux conteneurs
        // Conteneur pour les cartes et le graphique
        Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: PieChart(
                  PieChartData(
                    sections: getPieChartSelectionData(),
                  ),
                ),
              ),
              Container(
                width: double.infinity, // Utiliser la largeur maximale
                child: DashboardCard(
                  title: 'Nombre total',
                  value: nombreTotalPointCollecte,
                ),
              ),
              Container(
                width: double.infinity,
                child: DashboardCard(
                  title: 'Actif',
                  value: nombrePointCollecteActif,
                  valueStyle: TextStyle(
                    color: Color(0xFF26E5FF),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: DashboardCard(
                  title: 'Inactif',
                  value: nombrePointCollecteInactif,
                  valueStyle: TextStyle(
                    color: Color(0xFFEE2727),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),

  );
}

  List<PieChartSectionData> getPieChartSelectionData() {
    return [
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: nombrePointCollecteActif.toDouble(),
        title: 'Actif',
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: nombrePointCollecteInactif.toDouble(),
        title: 'Inactif',
        radius: 16,
      ),
    ];
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int value;
  final TextStyle? valueStyle;

  DashboardCard({
    required this.title,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value.toString(),
              style: valueStyle ?? TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
