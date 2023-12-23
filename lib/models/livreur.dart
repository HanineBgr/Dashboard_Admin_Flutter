
class Livreur {
  final String id;
  final String idlivraison;
  final bool etat;

  Livreur({
    required this.id,
    required this.idlivraison,
    required this.etat,
  });
  factory Livreur.fromJson(Map<String, dynamic> json){
    return Livreur(
      id: json['_id'],
       idlivraison: json['idlivraison'],
        etat: json['etat']
        );
  }
}
