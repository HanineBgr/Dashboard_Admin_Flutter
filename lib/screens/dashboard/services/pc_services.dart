import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin/models/PointCollecte.dart';

class PointCollecteService {
  final String baseUrl;

  PointCollecteService({required this.baseUrl});

  Future<List<PointCollecte>> getPointsCollecte() async {
    final response = await http.get(Uri.parse('http://localhost:5000/pointCollecte'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => PointCollecte.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des points de collecte');
    }
  }

  Future<void> deletePointCollecte(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:5000/pointCollecte/$id'));

    if (response.statusCode == 200) {
      print('Point de collecte supprimé avec succès');
    } else {
      throw Exception('Échec de la suppression du point de collecte');
    }
  }

  Future<PointCollecte> createPointCollecte(PointCollecte newPointCollecte) async {
    final response = await http.post(Uri.parse('http://localhost:5000/pointCollecte'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newPointCollecte.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return PointCollecte.fromJson(data);
    } else {
      throw Exception('Erreur lors de la création du point de collecte');
    }
  }
  Future<PointCollecte> updatePointCollecte(PointCollecte updatedPointCollecte) async {
  final response = await http.put(
    Uri.parse('http://localhost:5000/pointCollecte/${updatedPointCollecte.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedPointCollecte.toJson()),
  );

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    return PointCollecte.fromJson(data);
  } else {
    throw Exception('Erreur lors de la mise à jour du point de collecte');
  }
}
  Future<int> countTotalPoints() async {
    final response = await http.get(Uri.parse('http://localhost:5000/pointCollecte/countTotalPc'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return data['totalPoints'] as int;
    } else {
      throw Exception('Erreur lors de la récupération du nombre total de points de collecte');
    }
  }
  
Future<int> countInactivePoints() async {
  final response = await http.get(Uri.parse('http://localhost:5000/pointCollecte/countInactivePoints'));

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    // Use null-aware operator ?? to provide a default value of 0 if the data is null
    return data['countInactivePoints'] as int ?? 0;
  } else {
    throw Exception('Erreur lors de la récupération du nombre de points de collecte inactifs');
  }
}
  Future<int> countActivePoints() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/pointCollecte/countActivePoints'));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return data['totalPoints'] as int ?? 0 ;
      } else {
        throw Exception('Erreur lors de la récupération du nombre de points actifs');
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération du nombre de points actifs: $error');
    }
  }
  
}