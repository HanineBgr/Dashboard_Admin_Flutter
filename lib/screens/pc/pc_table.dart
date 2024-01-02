
import 'package:flutter/material.dart';
import 'package:admin/models/PointCollecte.dart';

class PointCollecteTable extends StatelessWidget {
  final List<PointCollecte> pointsCollecte;
  final Function(PointCollecte) onDelete;
  final Function(PointCollecte) onEdit;
  final Function onTableRefresh;
  final Function(PointCollecte) onPosition; 

  PointCollecteTable({
    required this.pointsCollecte,
    required this.onDelete,
    required this.onEdit,
    required this.onTableRefresh,
    required this.onPosition, 
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, 
      child: DataTable(
        columns: [
          DataColumn(label: Text('Nom du Point de Collecte')),
          DataColumn(label: Text('Adresse Email')),
          DataColumn(label: Text('Adresse')),
          DataColumn(label: Text('Numéro de Téléphone')),
          DataColumn(label: Text('Longitude')),
          DataColumn(label: Text('Latitude')),
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
                    onTableRefresh();
                  },
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete(pc);
                    onTableRefresh(); 
                  },
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    onPosition(pc); 
                  },
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
