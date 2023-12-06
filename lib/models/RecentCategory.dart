class RecentCategory {
  final String? id ,Nom, Adresse, Adresse_mail, telephone ,Role  ;

  RecentCategory( { this.id, this.Nom, this.Adresse, this .Adresse_mail ,this.telephone, this.Role,  });
}

List demoRecentCategorys = [
  RecentCategory(
  id: "1",
  Nom: "Hanine Bouguerra",
  Adresse: "Eljem",
  Adresse_mail: "bouguerra.hanine@esprit.tn",
  telephone: "93159203",
  Role: "Client"
  ),
  RecentCategory(
   id: "2",
   Nom: "Mariem",
   Adresse: "Bardo-Tunis",
   Adresse_mail: "mariem.marsaoui@esprit.tn",
   telephone: "95463820",
   Role: "Client"
  ),
 RecentCategory(
   id: "3",
   Nom: "Futur génération",
   Adresse: "Bardo-Tunis",
   Adresse_mail: "mariem.marsaoui@esprit.tn",
   telephone: "95463820",
   Role: "Organisation"
  ),
  RecentCategory(
   id: "4",
   Nom: "CRT ",
   Adresse: "Tunis",
   Adresse_mail: "crt.Tunis@gmail.com",
   telephone: "95263820",
   Role: "Organisation"
  ),

];
