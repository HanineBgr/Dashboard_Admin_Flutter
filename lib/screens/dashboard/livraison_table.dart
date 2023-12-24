import 'package:admin/models/livraison.dart';
import 'package:flutter/material.dart';

class LivraisonTable extends StatelessWidget {
  final List<Livraison> livraisons;
  final Function(Livraison) onDelete;
  final Function(Livraison) onLivrer; // Ajout de la fonction pour gérer l'événement de livraison

  LivraisonTable({required this.livraisons, required this.onDelete, required this.onLivrer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Article')),
              DataColumn(label: Text('Client')),
              DataColumn(label: Text('Adresse Email')),
              DataColumn(label: Text('Numéro Client')),
              DataColumn(label: Text('Ville')),
              DataColumn(label: Text('Adresse Client')),
              DataColumn(label: Text('Actions')),
              DataColumn(label: Text('Livrer')), // Nouvelle colonne pour le bouton Livrer
            ],
            rows: livraisons.map((livraison) {
              return DataRow(cells: [
                DataCell(Text(livraison.nomArticle)),
                DataCell(Text(livraison.nomClient)),
                DataCell(Text(livraison.addressMailClient)),
                DataCell(Text(livraison.numeroClient.toString())),
                DataCell(Text(livraison.ville)),
                DataCell(Text(livraison.addressClient)),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        onDelete(livraison);
                      },
                    ),
                  ],
                )),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.delivery_dining), // Utilisez l'icône appropriée pour la livraison
                      onPressed: () {
                        onLivrer(livraison);
                      },
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ...

