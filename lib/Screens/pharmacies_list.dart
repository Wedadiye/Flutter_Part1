import 'package:flutter/material.dart';
import '../Controlleurs/PharmacyController.dart';
import 'package:get/get.dart';

class PharmacyListScreen extends StatelessWidget {
  //final PharmacyController pharmacyController = Get.find();
  final PharmacyController pharmacyController = Get.find<PharmacyController>();

  @override
  Widget build(BuildContext context) {
    // Appeler fetchPharmacies au démarrage de l'application
    pharmacyController.fetchPharmacies();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Bienvenue dans notre App  ',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                pharmacyController.filterPharmacies(query);
              },
              decoration: InputDecoration(
                labelText: 'Rechercher par adresse',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: pharmacyController.displayedPharmacies.length, // Utilisez le tableau complet
                itemBuilder: (context, index) {
                  var pharmacy = pharmacyController.displayedPharmacies[index];

                  return Card(
                    color: Colors.cyan,

                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(pharmacy.name.toUpperCase(),
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ),
                          Expanded(
                            child: Padding(

                              padding: const EdgeInsets.all(12.0),
                              child: Text('Adresse: \n ' + pharmacy.adresse),
                            ),
                          ),
                          ElevatedButton(

                            onPressed: () async {
                              // Récupérez l'ID de la pharmacie visitée
                              int pharmacyId = pharmacy.id;


                              // Naviguez vers la page ListMedicament en passant l'ID de la pharmacie comme argument
                              //Get.toNamed('/list_medicament/$pharmacyId');
                              Get.toNamed('/list_medicament', arguments: {'pharmacyId': pharmacyId});

                            },
                            child: Text('Visiter'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
