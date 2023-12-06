import 'package:admin/models/livraison.dart';
import 'package:flutter/material.dart';
import 'livraison_table.dart';

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
      body: LivraisonTable(
        livraisons: livraisons,
        onDelete: supprimerLivraison,
      ),
    );
  }
}

/*
class DashboardLivraison extends StatelessWidget {
  final List<Livraison> livraisons = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord de livraison'),
      ),
      body: LivraisonTable(livraisons: livraisons),
    );
  }
}*/