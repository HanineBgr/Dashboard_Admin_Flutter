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
                   DataColumn(label: Text('Description')),
                   DataColumn(label: Text('Etat')),        
                   DataColumn(label: Text('Catégorie')),

                  ],
                  rows: List<DataRow>.generate(Articles.length, (index) {
                    return DataRow(cells: [
                      
                      DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['NomArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                       DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['DescriptionArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                       DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['EtatArticle'] ?? 'N/A')
                            : SizedBox(),
                      ),
                       DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['CategorieId'] ?? 'N/A')
                            : SizedBox(),
                      ),
                     /* DataCell(
                        userVisibility[index]
                            ? Text(Articles[index]['NbreTotalArticles'] ?? 'N/A')
                            : SizedBox(),
                      ),
                     */

                     
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
