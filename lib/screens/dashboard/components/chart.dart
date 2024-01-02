import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Categorie> categories = [];

  Future<void> fetchCategories() async {
    final url = Uri.parse('http://localhost:5000/api/categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      setState(() {
        categories = List<Categorie>.from(
          responseData.map((data) => Categorie.fromJson(data)),
        );
      });
    } else {
      print('Failed to fetch categories: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: generatePieChartSelectionData(categories),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categories.asMap().entries.map((entry) {
                    final index = entry.key;
                    final categorie = entry.value;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            color: generateRandomColor(index),
                          ),
                          SizedBox(width: 5),
                          Text(
                            categorie.nomCategorie,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> generatePieChartSelectionData(
    List<Categorie> categories,
  ) {
    return categories.map((categorie) {
      return PieChartSectionData(
        color: generateRandomColor(categories.indexOf(categorie)),
        value: categorie.nbreTotalArticles.toDouble(),
        showTitle: false,
        radius: 22,
      );
    }).toList();
  }

  Color generateRandomColor(int index) {
    return HSVColor.fromAHSV(
      1.0,
      (index * 77) % 360.0,
      1.0,
      1.0,
    ).toColor();
  }
}

class Categorie {
  final String nomCategorie;
  final int nbreTotalArticles;

  Categorie({
    required this.nomCategorie,
    required this.nbreTotalArticles,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      nomCategorie: json['NomCategorie'],
      nbreTotalArticles: json['NbreTotalArticles'],
    );
  }
}
