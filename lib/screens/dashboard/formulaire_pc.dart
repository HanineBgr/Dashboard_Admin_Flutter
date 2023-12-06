import 'package:flutter/material.dart';
import 'package:admin/models/PointCollecte.dart';

class AjoutPointCollecte extends StatefulWidget {
  final Function(PointCollecte) onAjouter;

  AjoutPointCollecte({required this.onAjouter});

  @override
  _AjoutPointCollecteState createState() => _AjoutPointCollecteState();
}

class _AjoutPointCollecteState extends State<AjoutPointCollecte> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nomPcController = TextEditingController();
  TextEditingController _addressMailPcController = TextEditingController();
  TextEditingController _addressPcController = TextEditingController();
  TextEditingController _numerotelController = TextEditingController();
  TextEditingController _xController = TextEditingController();
  TextEditingController _yController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Point de Collecte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomPcController,
                decoration: InputDecoration(labelText: 'Nom du Point de Collecte'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du Point de Collecte';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressMailPcController,
                decoration: InputDecoration(labelText: 'Adresse Email'),
                validator: (value) {
                  // Ajoutez des validations selon vos besoins
                  return null;
                },
              ),
              TextFormField(
                controller: _addressPcController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  // Ajoutez des validations selon vos besoins
                  return null;
                },
              ),
              TextFormField(
                controller: _numerotelController,
                decoration: InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Ajoutez des validations selon vos besoins
                  return null;
                },
              ),
              TextFormField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'Coordonnée X'),
                validator: (value) {
                  // Ajoutez des validations selon vos besoins
                  return null;
                },
              ),
              TextFormField(
                controller: _yController,
                decoration: InputDecoration(labelText: 'Coordonnée Y'),
                validator: (value) {
                  // Ajoutez des validations selon vos besoins
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    PointCollecte nouveauPointCollecte = PointCollecte(
                      nomPc: _nomPcController.text,
                      addressMailPc: _addressMailPcController.text,
                      addressPc: _addressPcController.text,
                      numerotel: int.parse(_numerotelController.text),
                      x: _xController.text,
                      y: _yController.text,
                    );

                    widget.onAjouter(nouveauPointCollecte);
                    Navigator.pop(context); // Ferme la page d'ajout
                  }
                },
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
