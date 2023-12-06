
import 'package:admin/models/PointCollecte.dart';
import 'package:flutter/material.dart';

class PointCollecteTable extends StatelessWidget {
  final List<PointCollecte> pointsCollecte;
  final Function(PointCollecte) onDelete;
  final Function(PointCollecte) onEdit;

  PointCollecteTable({
    required this.pointsCollecte,
    required this.onDelete,
    required this.onEdit,
  });

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
            DataColumn(label: Text('Nom du Point de Collecte')),
            DataColumn(label: Text('Adresse Email')),
            DataColumn(label: Text('Adresse')),
            DataColumn(label: Text('Numéro de Téléphone')),
            DataColumn(label: Text('Coordonnée X')),
            DataColumn(label: Text('Coordonnée Y')),
            DataColumn(label: Text('Actions')),
          ],
          rows: pointsCollecte.map((pc) {
            return DataRow(cells: [
              DataCell(Text(pc.nomPc)),
              DataCell(Text(pc.addressMailPc)),
              DataCell(Text(pc.addressPc)),
              DataCell(Text(pc.numerotel.toString())),
              DataCell(Text(pc.x)),
              DataCell(Text(pc.y)),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      onEdit(pc);
                    },
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDelete(pc);
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
class PointCollecteTable extends StatelessWidget {
  final List<PointCollecte> pointsCollecte;

  PointCollecteTable({required this.pointsCollecte});

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
            DataColumn(label: Text('Nom du Point de Collecte')),
            DataColumn(label: Text('Adresse Email')),
            DataColumn(label: Text('Adresse')),
            DataColumn(label: Text('Numéro de Téléphone')),
            DataColumn(label: Text('Coordonnée X')),
            DataColumn(label: Text('Coordonnée Y')),
            DataColumn(label: Text('Actions')),
          ],
          rows: pointsCollecte.map((pc) {
            return DataRow(cells: [
              DataCell(Text(pc.nomPc)),
              DataCell(Text(pc.addressMailPc)),
              DataCell(Text(pc.addressPc)),
              DataCell(Text(pc.numerotel.toString())),
              DataCell(Text(pc.x)),
              DataCell(Text(pc.y)),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logique de suppression pour le point de collecte
                      print('Supprimer point de collecte ${pc.nomPc}');
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
}
*/