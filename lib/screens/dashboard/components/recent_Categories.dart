import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentCategories extends StatefulWidget {
  const RecentCategories({Key? key}) : super(key: key);

  @override
  _RecentCategoriesState createState() => _RecentCategoriesState();
}

class _RecentCategoriesState extends State<RecentCategories> {
  List<Map<String, dynamic>> categories = [];
  late List<bool> userVisibility;

  Future<void> fetchcategories() async {
    final url = Uri.parse('http://localhost:5000/api/categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        categories = List<Map<String, dynamic>>.from(responseData);
        userVisibility = List<bool>.filled(categories.length, true);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchcategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catégories",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: [
                   // DataColumn(label: Text('Visibility')),
                    DataColumn(label: Text('Nom')),
                   DataColumn(label: Text('Nombre total des articles')),
                  
                  ],
                  rows: List<DataRow>.generate(categories.length, (index) {
                    return DataRow(cells: [
                      
                      DataCell(
                        userVisibility[index]
                            ? Text(categories[index]['NomCategorie'] ?? 'N/A')
                            : SizedBox(),
                      ),
                     /* DataCell(
                        userVisibility[index]
                            ? Text(categories[index]['NbreTotalArticles'] ?? 'N/A')
                            : SizedBox(),
                      ),
                     */
                     DataCell(
    userVisibility[index]
        ? Text(
            categories[index]['NbreTotalArticles']
                .toString() ?? 'N/A',
          )
        : SizedBox(),
  ),
                     
                    ]);
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
