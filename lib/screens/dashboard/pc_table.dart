import 'package:flutter/material.dart';
import 'package:admin/models/PointCollecte.dart';

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
    return Container(
      height: 300, // Ajustez cette hauteur en fonction de vos besoins
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              DataCell(Text(pc.x.toString())),
              DataCell(Text(pc.y.toString())),
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


