class RecentArticle{
  final String? id ,NomArticle, DescriptionArticle, Categorie ;

  RecentArticle( { this.id, this.NomArticle, this.DescriptionArticle ,this.Categorie,});
}

List demoRecentArticles = [
  RecentArticle(
  id: "1",
  NomArticle: "Rangement",
  DescriptionArticle: "Un rangement de  5 étages",
  Categorie: "Meubles",
  ),
  RecentArticle(
   id: "2",
   NomArticle: "Rouge à lévres",
   DescriptionArticle: "Rouge à lévres rouge de la marque YSL",
   Categorie: "Produits de beauté"
  ),
 RecentArticle(
   id: "3",
   NomArticle: "PC",
   DescriptionArticle: "Pc hp noir",
   Categorie: "Gadgets éléctroniques"
  ),
  RecentArticle(
   id: "4",
   NomArticle: "Table ",
   DescriptionArticle: "Table basse en vernis",
   Categorie: "Meubles"
  ),

];
