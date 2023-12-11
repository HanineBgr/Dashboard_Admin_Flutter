import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/PointCollecte.dart';
import 'package:admin/screens/dashboard/formulaire_pc.dart';
import 'package:admin/screens/dashboard/pc_table.dart';
import 'package:admin/screens/dashboard/services/pc_services.dart';

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

  Future<void> fetchPc() async {
    try {
      List<PointCollecte> fetchedPC =
          await pointCollecteService.getPointsCollecte();
          int totalPoints = (await pointCollecteService.countTotalPoints()) ?? 0;
          int inactivePoints = (await pointCollecteService.countInactivePoints()) ?? 0;
/*
      int totalPoints = await pointCollecteService.countTotalPoints();
      int inactivePoints = await pointCollecteService.countInactivePoints();*/

      setState(() {
        pointsCollecte = fetchedPC;
        nombreTotalPointCollecte = totalPoints;
        nombrePointCollecteActif = 0; // Laissez-le à 0 pour le moment
        nombrePointCollecteInactif = inactivePoints;
      });
    } catch (error) {
      print('Erreur lors de la récupération des Point Collecte: $error');
    }
  }

  Future<void> supprimerPointCollecte(PointCollecte pointCollecte) async {
    try {
      await pointCollecteService.deletePointCollecte(pointCollecte.id);

      int totalPoints = await pointCollecteService.countTotalPoints();

      setState(() {
        pointsCollecte.remove(pointCollecte);
        nombreTotalPointCollecte = totalPoints; // Mettez à jour le total
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

      int totalPoints = await pointCollecteService.countTotalPoints();

      setState(() {
        pointsCollecte.add(pointCree);
        nombreTotalPointCollecte = totalPoints; // Mettez à jour le total
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
        title: Text('Tableau de bord des points de collecte'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('Nombre total', nombreTotalPointCollecte),
              _buildStatCard('Actif', nombrePointCollecteActif),
              _buildStatCard('Inactif', nombrePointCollecteInactif),
            ],
          ),
          Expanded(
            child: PointCollecteTable(
              pointsCollecte: pointsCollecte,
              onDelete: supprimerPointCollecte,
              onEdit: modifierPointCollecte,
            ),
          ),
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
                      SizedBox(height: 16),
                      Text(
                        '$nombreTotalPointCollecte',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                      ),
                      Text("Total Points de Collecte"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: naviguerVersAjoutPointCollecte,
        tooltip: 'Ajouter un Point de Collecte',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Container(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title),
              Text('$value'),
            ],
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 5,
    title: '',
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 1,
    title: '',
    radius: 16,
  ),
];




/*import 'package:admin/models/PointCollecte.dart';
import 'package:admin/screens/dashboard/formulaire_pc.dart';
import 'package:admin/screens/dashboard/pc_table.dart';
import 'package:admin/screens/dashboard/services/pc_services.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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

  Future<void> fetchPc() async {
    try {
      List<PointCollecte> fetchedPC =
          await pointCollecteService.getPointsCollecte();
      setState(() {
        pointsCollecte = fetchedPC;
        nombreTotalPointCollecte = pointsCollecte.length;
        nombrePointCollecteActif = 0; // Laissez-le à 0 pour le moment
        nombrePointCollecteInactif = 0; // Laissez-le à 0 pour le moment
      });
    } catch (error) {
      print('Erreur lors de la récupération des Point Collecte: $error');
    }
  }

  Future<void> supprimerPointCollecte(PointCollecte pointCollecte) async {
    try {
      await pointCollecteService.deletePointCollecte(pointCollecte.id);
      fetchPc(); // Refresh the Point Collecte list after deletion
    } catch (error) {
      print('Erreur lors de la suppression de Point Collecte: $error');
    }
  }

  void modifierPointCollecte(PointCollecte pointCollecte) {
    print('Modifier le point de collecte : ${pointCollecte.nomPc}');
  }

void ajouterPointCollecte(PointCollecte nouveauPointCollecte) async {
  try {
    // Appel à createPointCollecte pour ajouter le nouveau point côté serveur
    PointCollecte pointCree = await pointCollecteService.createPointCollecte(nouveauPointCollecte);
    
    setState(() {
      pointsCollecte.add(pointCree);
      // Effectuez d'autres mises à jour d'état si nécessaire
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

  @override
  void initState() {
    super.initState();
    fetchPc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord des points de collecte'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('Nombre total', nombreTotalPointCollecte),
              _buildStatCard('Actif', nombrePointCollecteActif),
              _buildStatCard('Inactif', nombrePointCollecteInactif),
            ],
          ),
          Expanded(
            child: PointCollecteTable(
              pointsCollecte: pointsCollecte,
              onDelete: supprimerPointCollecte,
              onEdit: modifierPointCollecte,
            ),
          ),
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
                      SizedBox(height: 16),
                      Text(
                        '$nombreTotalPointCollecte',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 0.5,
                            ),
                      ),
                      Text("Total Points de Collecte"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: naviguerVersAjoutPointCollecte,
        tooltip: 'Ajouter un Point de Collecte',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Container(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title),
              Text('$value'),
            ],
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 55,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 45,
    showTitle: false,
    radius: 16,
  ),
];
*/




/*import 'package:admin/models/PointCollecte.dart';
import 'package:admin/screens/dashboard/formulaire_pc.dart';
import 'package:admin/screens/dashboard/pc_table.dart';
import 'package:fl_chart/fl_chart.dart'; // Importer la bibliothèque FL Chart
import 'package:flutter/material.dart';

class DashboardPC extends StatefulWidget {
  @override
  _DashboardPCState createState() => _DashboardPCState();
}

class _DashboardPCState extends State<DashboardPC> {
  List<PointCollecte> pointsCollecte = [
    PointCollecte(
      nomPc: 'Tunis',
      addressMailPc: 'karim.kekli2000@gmail.com',
      addressPc: 'Bardo',
      numerotel: 233363948,
      x: '36.22',
      y: '25.00',
    ),
    PointCollecte(
      nomPc: 'Sfax',
      addressMailPc: 'amal.kekli@gmail.com',
      addressPc: 'Manouba',
      numerotel: 22733772,
      x: '10.00',
      y: '45.00',
    ),
  ];
    // Ajoutez d'autres points de collecte selon vos besoins
  int nombreTotalPointCollecte = 100; // Remplacez par le nombre réel
  int nombrePointCollecteActif = 55; // Remplacez par le nombre réel
  int nombrePointCollecteInactif = 45;

  // Fonction de suppression
  void supprimerPointCollecte(PointCollecte pointCollecte) {
    setState(() {
      pointsCollecte.remove(pointCollecte);
    });
    print('Point de collecte supprimé : ${pointCollecte.nomPc}');
  }

  // Fonction de modification (à implémenter selon vos besoins)
  void modifierPointCollecte(PointCollecte pointCollecte) {
    // Mettez ici la logique de modification
    print('Modifier le point de collecte : ${pointCollecte.nomPc}');
  }

  // Fonction pour ajouter un nouveau point de collecte
  void ajouterPointCollecte(PointCollecte nouveauPointCollecte) {
    setState(() {
      pointsCollecte.add(nouveauPointCollecte);
    });
    print('Nouveau Point de collecte ajouté : ${nouveauPointCollecte.nomPc}');
  }

  // Fonction pour naviguer vers le formulaire d'ajout
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord des points de collecte'),
      ),
      body: Column(
        children: [
          // Affiche les statistiques dans des cartes horizontales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('Nombre total', nombreTotalPointCollecte),
              _buildStatCard('Actif', nombrePointCollecteActif),
              _buildStatCard('Inactif', nombrePointCollecteInactif),
            ],
          ),
          // Affiche le tableau de points de collecte
          Expanded(
            child: PointCollecteTable(
              pointsCollecte: pointsCollecte,
              onDelete: supprimerPointCollecte,
              onEdit: modifierPointCollecte,
            ),
          ),
          // Ajoutez le PieChart ici
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
                      SizedBox(height: 16),
                      Text(
                        '$nombreTotalPointCollecte',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                      ),
                      Text("Total Points de Collecte"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: naviguerVersAjoutPointCollecte,
        tooltip: 'Ajouter un Point de Collecte',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Container(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title),
              Text('$value'),
            ],
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 55,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 45,
    showTitle: false,
    radius: 16,
  ),
];
*/





/*
class DashboardPC extends StatelessWidget {
  final List<PointCollecte> pointsCollecte = [
    PointCollecte(
      nomPc: 'Tunis',
      addressMailPc: 'karim.kekli2000@gmail.com',
      addressPc: 'Bardo',
      numerotel: 233363948,
      x: '36.22',
      y: '25.00',
    ),
    PointCollecte(
      nomPc: 'Sfax',
      addressMailPc: 'amal.kekli@gmail.com',
      addressPc: 'Manouba',
      numerotel: 22733772,
      x: '10.00',
      y: '45.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord des points de collecte'),
      ),
      body: PointCollecteTable(pointsCollecte: pointsCollecte),
    );
  }
}
*/