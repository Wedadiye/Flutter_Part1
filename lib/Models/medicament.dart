import '../Controlleurs/medicamentController.dart';
import 'package:get/get.dart';

class Medicament {
  final int id;
  final String nom;
  final double prix;
  final int quantite;
  final bool disponible;
  final String description;
  final String image;
  final int? categorie;
  final int? pharmacie;
  final int? commande;

  Medicament({
    required this.id,
    required this.nom,
    required this.categorie,
    required this.prix,
    required this.quantite,
    required this.disponible,
    required this.description,
    required this.image,
    required this.commande,
    required this.pharmacie



  });


  factory Medicament.fromJson(Map<String, dynamic> json) {
    final controller = Get.find<MedicamentController>(); // Récupérer l'instance du contrôleur

    return Medicament(

    id: json['id'],
      nom: json['nom'],
      // Convertir la valeur du prix en double
      prix: json['prix'] is String ? double.parse(json['prix']) : json['prix'],

      quantite: json['quantite'],
      // Convertir la valeur du disponible en booléen
      disponible: json['disponible'] is bool
          ? json['disponible']
          : json['disponible'] is String
          ? json['disponible'].toLowerCase() == 'true'
          : false,
      description: json['description'],
     // image: 'http://192.168.56.141:8000/${json['image']}', // Assurez-vous que l'URL est correctement formatée
      image: '${controller.url}${json['image']}', // Utiliser l'URL de l'image du contrôleur

     categorie: json['categorie'],
      commande: json['commande'] ?? 0,
      pharmacie: json['pharmacie']?? 0,

    );
  }

}