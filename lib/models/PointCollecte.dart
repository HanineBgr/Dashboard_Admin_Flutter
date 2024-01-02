
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