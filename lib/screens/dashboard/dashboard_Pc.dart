// pages/dashboard_pc.dart
import 'package:admin/models/PointCollecte.dart';
import 'package:admin/screens/dashboard/pc_table.dart';
import 'package:flutter/material.dart';

class DashboardPC extends StatefulWidget {
  @override
  _DashboardPCState createState() => _DashboardPCState();
}

class _DashboardPCState extends State<DashboardPC> {
  List<PointCollecte> pointsCollecte = [
    PointCollecte(
      nomPc: 'Point Collecte 1',
      addressMailPc: 'pc1@example.com',
      addressPc: 'Adresse PC 1',
      numerotel: 123456789,
      x: 'X1',
      y: 'Y1',
    ),
    PointCollecte(
      nomPc: 'Point Collecte 2',
      addressMailPc: 'pc2@example.com',
      addressPc: 'Adresse PC 2',
      numerotel: 987654321,
      x: 'X2',
      y: 'Y2',
    ),
    // Ajoutez d'autres points de collecte selon vos besoins
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord des points de collecte'),
      ),
      body: PointCollecteTable(
        pointsCollecte: pointsCollecte,
        onDelete: supprimerPointCollecte,
        onEdit: modifierPointCollecte,
      ),
    );
  }
}

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
}*/
