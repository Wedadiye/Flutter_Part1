import 'dart:convert';

import '../Models/medicament.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MedicamentController extends GetxController {
  var medicaments = <Medicament>[].obs;
  var result = <Medicament>[].obs;
  var allMedicaments = <Medicament>[].obs; // Nouvelle variable pour stocker tous les médicaments

  var url = 'http://192.168.56.141:8000';
  void resetResult() {
    result.assignAll(allMedicaments); // Utiliser tous les médicaments au lieu des résultats actuels
  }

  void fetchMedicaments(int pharmacyId) async {
    try {
      print('Récupération des médicaments pour l\'ID de pharmacie : $pharmacyId');

      final response = await http.get(Uri.parse('$url/Pharmacies/medicaments-by-pharmacie/$pharmacyId/by_pha'
          'rmacie/'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData != null) {
          allMedicaments.assignAll(responseData.map((data) => Medicament.fromJson(data)).toList()); // Stocker tous les médicaments
          resetResult(); // Initialiser à la fois medicaments et result
        } else {
          throw Exception("Échec de l'analyse des données de réponse");
        }
      }
    } catch(e) {
      throw Exception('Échec du chargement des médicaments: $e');
    }
  }

  void searchMedicaments(String query) {
    if (query.isEmpty) {
      result.assignAll(allMedicaments); // Afficher tous les médicaments si la requête est vide
    } else {
      result.value = allMedicaments
          .where((medicament) => medicament.nom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
