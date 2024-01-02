
class Livraison {
  final String id; // Nouveau champ ajouté
  final String nomArticle;
  final String nomClient;
  final String addressMailClient;
  final int numeroClient;
  final String ville;
  final String addressClient;

  Livraison({
    required this.id, // Ajout du champ id dans le constructeur
    required this.nomArticle,
    required this.nomClient,
    required this.addressMailClient,
    required this.numeroClient,
    required this.ville,
    required this.addressClient,
  });

  factory Livraison.fromJson(Map<String, dynamic> json) {
    return Livraison(
      id: json['_id'], // Assurez-vous que le champ _id existe dans votre backend
      nomArticle: json['Nom_Article'],
      nomClient: json['Nom_Client'],
      addressMailClient: json['address_mail_Client'],
      numeroClient: json['numero_Client'],
      ville: json['ville'],
      addressClient: json['address_Client'],
    );
  }
}
