/*import 'package:flutter/material.dart';
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
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _addressPcController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _numerotelController,
                decoration: InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'Coordonnée X'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _yController,
                decoration: InputDecoration(labelText: 'Coordonnée Y'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    PointCollecte nouveauPointCollecte = PointCollecte(
                      id: '', // Provide the appropriate id value or leave it empty based on your application logic.
                      nomPc: _nomPcController.text,
                      addressMailPc: _addressMailPcController.text,
                      addressPc: _addressPcController.text,
                      numerotel: int.parse(_numerotelController.text),
                      x: double.parse(_xController.text),
                      y: double.parse(_yController.text),
                    );

                    widget.onAjouter(nouveauPointCollecte);
                    Navigator.pop(context); // Close the add point page
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
}*/
/*
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
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _addressPcController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _numerotelController,
                decoration: InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'Coordonnée X'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              TextFormField(
                controller: _yController,
                decoration: InputDecoration(labelText: 'Coordonnée Y'),
                validator: (value) {
                  // Add validations as needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    PointCollecte nouveauPointCollecte = PointCollecte(
                      id: '', // Provide the appropriate id value or leave it empty based on your application logic.
                      nomPc: _nomPcController.text,
                      addressMailPc: _addressMailPcController.text,
                      addressPc: _addressPcController.text,
                      numerotel: int.parse(_numerotelController.text),
                      x: double.parse(_xController.text),
                      y: double.parse(_yController.text),
                    );

                    widget.onAjouter(nouveauPointCollecte);
                    Navigator.pop(context); // Close the add point page
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
}*/
import 'package:flutter/material.dart';
import 'package:admin/models/PointCollecte.dart';

class AjoutPointCollecte extends StatefulWidget {
  final Function(PointCollecte) onAjouter;
  final PointCollecte? pointToUpdate;

  AjoutPointCollecte({required this.onAjouter, this.pointToUpdate});

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
  void initState() {
    super.initState();
    if (widget.pointToUpdate != null) {
      // Pré-remplir les champs si vous mettez à jour un point de collecte
      _nomPcController.text = widget.pointToUpdate!.nomPc;
      _addressMailPcController.text = widget.pointToUpdate!.addressMailPc;
      _addressPcController.text = widget.pointToUpdate!.addressPc;
      _numerotelController.text = widget.pointToUpdate!.numerotel.toString();
      _xController.text = widget.pointToUpdate!.x.toString();
      _yController.text = widget.pointToUpdate!.y.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pointToUpdate != null
            ? 'Modifier un Point de Collecte'
            : 'Ajouter un Point de Collecte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomPcController,
                decoration: InputDecoration(
                  labelText: 'Nom du Point de Collecte',
                ),
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
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),
              TextFormField(
                controller: _addressPcController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),
              TextFormField(
                controller: _numerotelController,
                decoration:
                    InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),
              TextFormField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'Coordonnée X'),
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),
              TextFormField(
                controller: _yController,
                decoration: InputDecoration(labelText: 'Coordonnée Y'),
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    PointCollecte nouveauPointCollecte = PointCollecte(
                      id: widget.pointToUpdate?.id ?? '', // Utilisez l'id existant ou laissez-le vide pour un nouvel ajout
                      nomPc: _nomPcController.text,
                      addressMailPc: _addressMailPcController.text,
                      addressPc: _addressPcController.text,
                      numerotel: int.parse(_numerotelController.text),
                      x: double.parse(_xController.text),
                      y: double.parse(_yController.text),
                    );

                    widget.onAjouter(nouveauPointCollecte);
                    Navigator.pop(context); // Fermez la page d'ajout/modification de point
                  }
                },
                child: Text(widget.pointToUpdate != null
                    ? 'Modifier'
                    : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





