
import 'dart:convert';
import 'package:admin/models/livraison.dart';

import 'package:http/http.dart' as http;

class LivraisonService {
  final String baseUrl;

  LivraisonService({required this.baseUrl});

  Future<List<Livraison>> getLivraisons() async {
    final response = await http.get(Uri.parse('http://localhost:5000/livraison'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Livraison.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des livraisons');
    }
  }

Future<void> deleteLivraison(String id) async {
  final response = await http.delete(Uri.parse('http://localhost:5000/livraison/$id'));

  if (response.statusCode == 200) {
    print('Livraison deleted successfully');
  } else {
    throw Exception('Failed to delete Livraison');
  }
}

Future<int> countLiv() async {
  final response = await http.get(Uri.parse('http://localhost:5000/livraison/countLiv'));
  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    // Utilisez l'opérateur null-aware ?? pour fournir une valeur par défaut de 0 si les données sont null
    return data['totalLivraisons'] as int ?? 0;
  } else {
    throw Exception('Erreur lors de la récupération du nombre total de Livraisons');
  }
}
Future<int> getStatLiv() async {
  final response = await http.get(Uri.parse('http://localhost:5000/livraison/livraison_livree'));
    if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    return data['totalLivree'] as int ?? 0;
    }else {
      throw Exception("err");
    }
}
}