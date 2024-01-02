import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin/screens/dashboard/components/CategoryForm.dart';

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

  Future<void> deleteCategory(String categorieId) async {
    final url = Uri.parse('http://localhost:5000/api/categories/$categorieId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Successful deletion, update the UI or handle accordingly
      print('Category deleted successfully');
      fetchcategories(); // Refresh the categories after deletion
    } else {
      print('Failed to delete category: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchcategories();
  }

  void navigateToAddCategoryForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryForm()));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catégories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: defaultPadding,
                  ),
                ),
                onPressed: navigateToAddCategoryForm,
                icon: Icon(Icons.add),
                label: Text("Add New"),
              ),
            ],
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
                    DataColumn(label: Text('Photo de la catégorie')),
                    DataColumn(label: Text('Nom de la catégorie')),
                    DataColumn(label: Text('Nombre total des articles')),
                    // DataColumn(label: Text('Actions')),
                  ],
                  rows: List<DataRow>.generate(categories.length, (index) {
                    return DataRow(cells: [
                      DataCell(
                        userVisibility[index]
                            ? Image.network(
                                categories[index]['PhotoCategorie'] ?? '',
                                width: 50, // Adjust the width as needed
                                height: 50, // Adjust the height as needed
                                fit: BoxFit.cover,
                              )
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(categories[index]['NomCategorie'] ?? 'N/A')
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(
                                categories[index]['NbreTotalArticles']
                                        .toString() ??
                                    'N/A',
                              )
                            : SizedBox(),
                      ),
                      /*DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteCategory(categories[index]['_id']);
                          },
                        ),
                      ),*/
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
