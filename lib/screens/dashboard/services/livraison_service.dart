
import 'dart:convert';
import 'package:admin/models/livraison.dart';
import 'package:admin/models/livreur.dart';
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
Future<int> countAndShowDeliveredLivraisons() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/livraison/livraison_livree'));
    print('Response from API: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      // Vérifiez si la clé 'totalDeliveredLivraisons' existe dans la réponse JSON
      if (data != null && data.containsKey('totalDeliveredLivraisons')) {
        return data['totalDeliveredLivraisons'] as int ?? 0;
      } else {
        throw Exception('La clé "totalDeliveredLivraisons" est manquante dans la réponse JSON');
      }
    } else {
      throw Exception('Erreur lors de la récupération du nombre total de livraisons livrées');
    }
  } catch (error) {
    print('Error in countAndShowDeliveredLivraisons: $error');
    throw error;
  }
}
Future<void> livrerLivraison(String id) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:5000/livraison/livraison_livree'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idLivraison': id, 'etat': true}),
    );

    if (response.statusCode == 200) {
      print('Livraison effectuée avec succès');
    } else {
      print('Erreur lors de la livraison: ${response.statusCode}');
      throw Exception('Erreur lors de la livraison');
    }
  } catch (error) {
    print('Erreur lors de la livraison: $error');
    throw error;
  }
}


}
/*
  Future<void> livrerLivraison(String id) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:5000/livraison/livraison_livree'),
      body: jsonEncode({'idLivraison': id}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Livraison effectuée avec succès');
    } else {
      throw Exception('Échec de la mise à jour de l\'état de la livraison');
    }
  } catch (error) {
    print('Erreur lors de la livraison: $error');
    throw error;
  }
}
}*/


