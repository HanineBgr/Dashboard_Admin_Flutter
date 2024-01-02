import 'package:flutter/material.dart';

class LivraisonProvider extends ChangeNotifier {
  int nombreTotalLivraisons = 0;
  int nombreProduitsLivres = 0;
  int nombreRetours = 0;

  void updateData(int totalLivraisons, int produitsLivres, int retours) {
    nombreTotalLivraisons = totalLivraisons;
    nombreProduitsLivres = produitsLivres;
    nombreRetours = retours;
    notifyListeners();
  }
}
