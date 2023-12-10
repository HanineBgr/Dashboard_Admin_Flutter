/*class PointCollecte {
  final String id;
  final String nomPc;
  final String addressMailPc;
  final String addressPc;
  final num numerotel;
  final num x;
  final num y;

  PointCollecte({
    required this.id,
    required this.nomPc,
    required this.addressMailPc,
    required this.addressPc,
    required this.numerotel,
    required this.x,
    required this.y,
  });

  // Rest of the class remains unchanged

  factory PointCollecte.fromJson(Map<String, dynamic> json) {
    return PointCollecte(
      id: json['_id'],
      nomPc: json['Nom_Pc'],
      addressMailPc: json['address_mail_Pc'],
      addressPc: json['address_Pc'],
      numerotel: json['numero_tel'] ?? 0,
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }
}*/
class PointCollecte {
  final String id;
  final String nomPc;
  final String addressMailPc;
  final String addressPc;
  final num numerotel;
  final num x;
  final num y;

  PointCollecte({
    required this.id,
    required this.nomPc,
    required this.addressMailPc,
    required this.addressPc,
    required this.numerotel,
    required this.x,
    required this.y,
  });

  factory PointCollecte.fromJson(Map<String, dynamic> json) {
    return PointCollecte(
      id: json['_id'],
      nomPc: json['Nom_Pc'],
      addressMailPc: json['address_mail_Pc'],
      addressPc: json['address_Pc'],
      numerotel: json['numero_tel'] ?? 0,
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Nom_Pc': nomPc,
      'address_mail_Pc': addressMailPc,
      'address_Pc': addressPc,
      'numero_tel': numerotel,
      'x': x,
      'y': y,
    };
  }
}



/*class PointCollecte {
  final String id;
  final String nomPc;
  final String addressMailPc;
  final String addressPc;
  final String image;
  final num x; // Utilisez "num" au lieu de "double"
  final num y; // Utilisez "num" au lieu de "double"
  final num numerotel; // Utilisez "num" au lieu de "int"

  PointCollecte({
    required this.id,
    required this.nomPc,
    required this.addressMailPc,
    required this.addressPc,
    required this.image,
    required this.x,
    required this.y,
    required this.numerotel,
  });

  factory PointCollecte.fromJson(Map<String, dynamic> json) {
    return PointCollecte(
      id: json['_id'],
      nomPc: json['Nom_Pc'],
      addressMailPc: json['address_mail_Pc'],
      addressPc: json['address_Pc'],
      image: json['image'],
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
      numerotel: json['numero_tel'] ?? 0,
    );
  }
}*/
/*
class PointCollecte {
  final String id;
  final String nomPc;
  final String addressMailPc;
  final String addressPc;
  final int numerotel;
 // final File image; // Ajout du champ imageUrl
  final double x;
  final double y;

  PointCollecte({
    required this.id,
    required this.nomPc,
    required this.addressMailPc,
    required this.addressPc,
    //required this.image,
        required this.numerotel,
    required this.x,
    required this.y,

  });

  factory PointCollecte.fromJson(Map<String, dynamic> json) {
    return PointCollecte(
      id: json['_id'],
      nomPc: json['Nom_Pc'],
      addressMailPc: json['address_mail_Pc'],
      addressPc: json['address_Pc'],
     // image: json['image'] ?? '', // Remplacez 'imageUrl' par le champ réel dans votre API
      numerotel: json['numero_tel'] ?? 0,
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Nom_Pc': nomPc,
      'address_mail_Pc': addressMailPc,
      'address_Pc': addressPc,
      //'image': image.path,
      'numero_tel': numerotel,
      'x': x,
      'y': y,
    };
  }
}
*/