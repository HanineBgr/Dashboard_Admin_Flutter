import 'package:admin/models/livraison.dart';
import 'package:flutter/material.dart';

class LivraisonTable extends StatelessWidget {
  final List<Livraison> livraisons;
  final Function(Livraison) onDelete;

  LivraisonTable({required this.livraisons, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
        ),
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
                      // Logique de suppression
                      onDelete(livraison);
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
/*
class LivraisonTable extends StatelessWidget {
  final List<Livraison> livraisons;

  LivraisonTable({required this.livraisons});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
        ),
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
                  ElevatedButton(
                    onPressed: () {
                      // Logique de suppression
                      print('Supprimer livraison ${livraison.nomArticle}');
                    },
                    child: Text('Supprimer'),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}*/


