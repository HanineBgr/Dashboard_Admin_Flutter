class RecentArticle{
  final String? id ,Nom, Adresse, Adresse_mail, telephone ,Role  ;

  RecentArticle( { this.id, this.Nom, this.Adresse, this .Adresse_mail ,this.telephone, this.Role,  });
}

List demoRecentArticles = [
  RecentArticle(
  id: "1",
  Nom: "Hanine Bouguerra",
  Adresse: "Eljem",
  Adresse_mail: "bouguerra.hanine@esprit.tn",
  telephone: "93159203",
  Role: "Client"
  ),
  RecentArticle(
   id: "2",
   Nom: "Mariem",
   Adresse: "Bardo-Tunis",
   Adresse_mail: "mariem.marsaoui@esprit.tn",
   telephone: "95463820",
   Role: "Client"
  ),
 RecentArticle(
   id: "3",
   Nom: "Futur génération",
   Adresse: "Bardo-Tunis",
   Adresse_mail: "mariem.marsaoui@esprit.tn",
   telephone: "95463820",
   Role: "Organisation"
  ),
  RecentArticle(
   id: "4",
   Nom: "CRT ",
   Adresse: "Tunis",
   Adresse_mail: "crt.Tunis@gmail.com",
   telephone: "95263820",
   Role: "Organisation"
  ),

];
