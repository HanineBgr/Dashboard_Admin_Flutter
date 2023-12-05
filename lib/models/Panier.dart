import 'package:flutter/material.dart';

class PanierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Panier'),
        actions: [
          IconButton(
            onPressed: () {
              // Action pour le bouton de recherche
              print('Bouton de recherche appuyé');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Row(
        children: [
          // Affichage des listes de tous les paniers à gauche
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Liste de tous les paniers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                
          
                ],
              ),
            ),
          ),
     
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Text(
                    'Détail Panier',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150, 
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'ID du Panier',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                         
                          print('Bouton Modifier appuyé');
                        },
                        child: Text('Modifier le panier'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade700),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                         
                          print('Bouton Supprimer appuyé');
                        },
                        child: Text('Supprimer'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
         
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Détails d\'un article',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                 
            
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
