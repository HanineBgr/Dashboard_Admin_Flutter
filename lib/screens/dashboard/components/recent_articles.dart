import 'dart:convert';

import 'package:admin/models/RecentArticle.dart';
import 'package:admin/models/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/RecentCategory.dart';
import '../../../responsive.dart';
import 'package:http/http.dart' as http;

class RecentArticles extends StatefulWidget {
  const RecentArticles({Key? key}) : super(key: key);

  @override
  _RecentArticlesState createState() => _RecentArticlesState();
}

class _RecentArticlesState extends State<RecentArticles> {
  List<Map<String, dynamic>> Articles = [];
  late List<bool> userVisibility;

  Future<void> fetchArticles() async {
    final url = Uri.parse('http://localhost:5000/api/articles');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        Articles = List<Map<String, dynamic>>.from(responseData);
        userVisibility = List<bool>.filled(Articles.length, true);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> deleteArticle(String articleId) async {
    final url = Uri.parse('http://localhost:5000/api/articles/$articleId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Successful deletion, update the UI or handle accordingly
      print('Article deleted successfully');
      fetchArticles(); // Refresh the articles after deletion
    } else {
      print('Failed to delete article: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
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
            "Articles",
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
                    DataColumn(label: Text('Photo')),
                    DataColumn(label: Text('Nom')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Etat')),
                    DataColumn(label: Text('Catégorie')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List<DataRow>.generate(Articles.length, (index) {
                    return DataRow(cells: [
                      DataCell(
                        userVisibility[index]
                            ? Image.network(
                                Articles[index]['PhotoArticle'] ?? '',
                                width: 50, // Adjust the width as needed
                                height: 50, // Adjust the height as needed
                                fit: BoxFit.cover,
                              )
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['NomArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(
                                Articles[index]['DescriptionArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['EtatArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                      DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['Categorie']
                                    ['NomCategorie'] ??
                                'N/A')
                            : SizedBox(),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteArticle(Articles[index]['_id']);
                          },
                        ),
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
