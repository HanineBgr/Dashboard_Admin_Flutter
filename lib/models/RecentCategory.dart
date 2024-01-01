class RecentCategory {
  final String? id, PhotoCatergorie, NomCatergorie, NbreTotalArticles ;

  RecentCategory( { this.id, this.PhotoCatergorie, this.NomCatergorie,this.NbreTotalArticles,});
}

List demoRecentCategorys = [
  RecentCategory(
  id: "1",
  PhotoCatergorie: "Meubles.jpg",
  NomCatergorie: "Meubles",
  NbreTotalArticles: "10"
  ),
  RecentCategory(
   id: "2",
  PhotoCatergorie: "Produits_beaute.jpg",
   NomCatergorie: "Produits de beauté",
   NbreTotalArticles: "20"
  ),
 RecentCategory(
   id: "3",
  PhotoCatergorie: "Gadgets_electroniques.jpg",
   NomCatergorie: "Gadgets élétroniques ",
   NbreTotalArticles: "25"
  ),
  RecentCategory(
   id: "4",
  PhotoCatergorie: "Livres.jpg",
   NomCatergorie: "TLivres",
   NbreTotalArticles: "20"
  ),

];
