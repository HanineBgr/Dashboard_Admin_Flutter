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
              /*
              TextFormField(
                controller: _addressMailPcController,
                decoration: InputDecoration(labelText: 'Adresse Email'),
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),*/
              TextFormField(
                controller: _addressMailPcController,
                decoration: InputDecoration(labelText: 'Adresse Email'),
                validator: (value) {
                if (value == null || value.isEmpty) {
                return 'Veuillez entrer une adresse email';
                }
                String emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                RegExp regExp = RegExp(emailPattern);

                if (!regExp.hasMatch(value)) {
               return 'Veuillez entrer une adresse email valide';
              }
              return null;
              },
              ),

              TextFormField(
                controller: _addressPcController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l adresse de  Point de Collecte';
                  }
                  return null;
                },
              ),
              /*
              TextFormField(
                controller: _numerotelController,
                decoration:
                    InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Ajoutez des validations au besoin
                  return null;
                },
              ),*/
              TextFormField(
                controller: _numerotelController,
                decoration: InputDecoration(labelText: 'Numéro de Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un numéro de téléphone';
                }
              // Supprimez les espaces éventuels dans le numéro de téléphone
              String cleanedPhoneNumber = value.replaceAll(RegExp(r'\s+\b|\b\s'), '');
              // Vérifiez si le numéro de téléphone a exactement 8 chiffres
              if (cleanedPhoneNumber.length != 8) {
             return 'Le numéro de téléphone doit contenir exactement 8 chiffres';
            }
              // Vérifiez si tous les caractères sont des chiffres
            if (!cleanedPhoneNumber.contains(RegExp(r'^[0-9]+$'))) {
            return 'Veuillez entrer un numéro de téléphone valide';
            }
            return null;
           },
            ),

              TextFormField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'Longitude '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer longitude du Point de Collecte';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yController,
                decoration: InputDecoration(labelText: 'Latitude '),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Veuillez entrer latitude du Point de Collecte';
                  }
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

