
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/pharmacy.dart';
import 'dart:convert';


class PharmacyController extends GetxController {
  var pharmacies = <Pharmacy>[].obs;

  var displayedPharmacies = <Pharmacy>[].obs;

  // Méthode pour initialiser les pharmacies
  Future<void> init() async {
    await fetchPharmacies();
    filterPharmacies(""); // Filtrer avec une chaîne vide pour afficher toutes les pharmacies
  }

  Future<void> fetchPharmacies() async {
    final response = await http.get(Uri.parse('http://192.168.56.141:8000/Pharmacies/Pharmacie/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      pharmacies.assignAll(data.map((e) => Pharmacy(id: e['id'],name: e['nom'], adresse: e['adresse'],pharmacien: e['Pharmacien'])).toList());



    } else {
      throw Exception('Failed to load pharmacies -${response.statusCode}');
    }
  }


  void filterPharmacies(String query) {
    if (query.isNotEmpty) {
      displayedPharmacies.value = pharmacies
          .where((pharmacy) =>
          pharmacy.adresse.toLowerCase().contains(query.toLowerCase()))
          .toList();

    } else {
      displayedPharmacies.assignAll(pharmacies);
    }
  }
}